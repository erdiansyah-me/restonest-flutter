import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restonest/common/styles.dart';
import 'package:restonest/data/model/restaurants.dart';
import 'package:restonest/provider/database_provider.dart';
import 'package:restonest/provider/detail_provider.dart';
import 'package:restonest/provider/result_state.dart';

class DetailPage extends StatelessWidget {
  static const routeName = '/detail_page';
  const DetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<DetailProvider>(builder: (context, state, _) {
      return Consumer<DatabaseProvider>(builder: (context, provider, child) {
        return FutureBuilder<bool>(
            future: provider.isFavorited(state.idResto),
            builder: (context, snapshot) {
              var isFavorited = snapshot.data ?? false;
              return Scaffold(
                appBar: AppBar(
                  title: const Text('Detail Restaurant'),
                  leading: IconButton(
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                body: SafeArea(
                  child: buildDetail(state, context),
                ),
                floatingActionButton: isFavorited
                    ? FloatingActionButton(
                        child: const Icon(Icons.favorite),
                        onPressed: () {
                          provider.removeFavorite(state.idResto);
                          isFavorited = !isFavorited;
                        })
                    : FloatingActionButton(
                        child: const Icon(Icons.favorite_outline),
                        onPressed: () {
                          var restaurant = state.detail.restaurant;
                          provider.addFavorite(Restaurant(
                              id: restaurant.id,
                              name: restaurant.name,
                              description: restaurant.description,
                              pictureId: restaurant.pictureId,
                              city: restaurant.city,
                              rating: restaurant.rating));
                          isFavorited = !isFavorited;
                        }),
              );
            });
      });
    });
  }

  Widget buildDetail(state, context) {
    if (state.state == ResultState.loading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else if (state.state == ResultState.hasData) {
      var restaurants = state.detail.restaurant;
      return SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Hero(
              tag: restaurants.pictureId,
              child: Image.network(
                'https://restaurant-api.dicoding.dev/images/medium/${restaurants.pictureId}',
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, top: 16.0),
              child: Column(
                children: [
                  Text(
                    restaurants.name,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  Padding(
                      padding: const EdgeInsets.only(left: 8.0, bottom: 8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(
                            Icons.location_pin,
                            size: 16.0,
                            color: Color.fromARGB(255, 0, 0, 0),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 4.0),
                            child: Text(restaurants.city,
                                style: Theme.of(context).textTheme.subtitle1),
                          )
                        ],
                      )),
                  Padding(
                      padding: const EdgeInsets.only(left: 8.0, bottom: 8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(
                            Icons.star_rate,
                            size: 16.0,
                            color: Color.fromARGB(255, 207, 204, 0),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 4.0),
                            child: Text(restaurants.rating.toString(),
                                style: Theme.of(context).textTheme.subtitle1),
                          )
                        ],
                      )),
                  const Divider(color: themeColor),
                  Text(
                    restaurants.description,
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                  const Divider(color: themeColor),
                  Row(
                    children: [
                      Expanded(
                          child: Column(
                        children: [
                          Text(
                            'Foods :',
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                        ],
                      )),
                      Expanded(
                          child: Column(
                        children: [
                          Text(
                            'Drinks :',
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                        ],
                      ))
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Wrap(
                          crossAxisAlignment: WrapCrossAlignment.start,
                          spacing: 2.0,
                          runAlignment: WrapAlignment.start,
                          children: restaurants.menus.foods.map<Widget>((food) {
                            return Chip(
                                label: Text(food.name,
                                    style:
                                        Theme.of(context).textTheme.subtitle2));
                          }).toList(),
                        ),
                      ),
                      Expanded(
                          child: Wrap(
                        crossAxisAlignment: WrapCrossAlignment.start,
                        spacing: 2.0,
                        runAlignment: WrapAlignment.start,
                        children: restaurants.menus.drinks.map<Widget>((drink) {
                          return Chip(
                              label: Text(drink.name,
                                  style:
                                      Theme.of(context).textTheme.subtitle2));
                        }).toList(),
                      ))
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ));
    } else if (state.state == ResultState.error) {
      return Center(
        child: Material(
          child: Text(state.message),
        ),
      );
    } else {
      return Center(
        child: Material(
          child: Text(state.message),
        ),
      );
    }
  }
}
