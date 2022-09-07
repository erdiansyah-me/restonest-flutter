import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restonest/common/styles.dart';
import 'package:restonest/data/api/api_service.dart';
import 'package:restonest/provider/detail_provider.dart';


class DetailPage extends StatelessWidget {
  static const routeName = '/detail_page';
  final DetailArguments args;
  const DetailPage({Key? key, required this.args}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Text(args.nameRestaurant),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white,),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
      ),
      body: SafeArea(
        child: ChangeNotifierProvider<DetailProvider>(
          create: (_) => DetailProvider(apiService: ApiService(), id: args.idRestaurant),
          child: const BuildDetail(),
        )
      ),
    );
  }
}

class BuildDetail extends StatelessWidget {

  
  const BuildDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<DetailProvider>(
      builder: (context, state, _) {
        if (state.state == ResultState.loading) {
          return const Center(child: CircularProgressIndicator(),);
        } else if (state.state == ResultState.hasData) {
          var restaurants = state.detail.restaurant;
          return SingleChildScrollView(
          child: Padding(padding: const EdgeInsets.all(8.0),
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
                Padding(padding: const EdgeInsets.only(left: 8.0, top: 16.0),
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
                              child: Text(
                                restaurants.city,
                                style: Theme.of(context).textTheme.subtitle1
                              ),
                            )
                          ],
                        )
                      ),
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
                              child: Text(
                                restaurants.rating.toString(),
                                style: Theme.of(context).textTheme.subtitle1
                              ),
                            )
                          ],
                        )
                      ),
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
                                  Text('Foods :', style: Theme.of(context).textTheme.bodyText1,),
                                  
                                ],
                              )
                            ),
                            Expanded(
                              child: Column(
                              children: [
                                Text('Drinks :', style: Theme.of(context).textTheme.bodyText1,),
                                
                              ],
                            )
                            )
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(child: Wrap(
                                  crossAxisAlignment: WrapCrossAlignment.start,
                                  spacing: 2.0,
                                  runAlignment: WrapAlignment.start,
                                  children: restaurants.menus.drinks.map((drink) {
                                    return Chip(
                                      label: Text(drink.name, style: Theme.of(context).textTheme.subtitle2)
                                    );
                                  }).toList(),
                                ),
                              ),
                            Expanded(child: Wrap(
                                    crossAxisAlignment: WrapCrossAlignment.start,
                                    spacing: 2.0,
                                    runAlignment: WrapAlignment.start,
                                    children: restaurants.menus.foods.map((food) {
                                      return Chip(
                                        label: Text(food.name, style: Theme.of(context).textTheme.subtitle2)
                                      );
                                    }).toList(),
                                  )
                                )
                          ],
                        )
                    ],
                  ),
                ),
              ],
            ),
          )
        );
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
      },
    );
  }
}

class DetailArguments {
  final String nameRestaurant;
  final String idRestaurant;

  DetailArguments(this.nameRestaurant, this.idRestaurant);
}