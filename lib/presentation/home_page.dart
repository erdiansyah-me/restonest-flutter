import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restonest/common/styles.dart';
import 'package:restonest/data/notification/notif_helper.dart';
import 'package:restonest/presentation/detail_page.dart';
import 'package:restonest/presentation/favorite_page.dart';
import 'package:restonest/presentation/search_page.dart';
import 'package:restonest/presentation/settings_page.dart';
import 'package:restonest/presentation/widgets/item_list.dart';
import 'package:restonest/provider/restaurants_provider.dart';
import 'package:restonest/provider/result_state.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/home_page';

  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late NotifHelper notifHelper = NotifHelper();

    @override
    void initState() {
      super.initState();
      notifHelper.configureNotifSubject(DetailPage.routeName);
    }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: const Text('RestoNEST'),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, SearchPage.routeName);
              },
              icon: const Icon(Icons.search),
              color: primaryColor,
            ),
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, FavoritePage.routeName);
              },
              icon: const Icon(Icons.favorite),
              color: primaryColor,
            ),
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, SettingsPage.routeName);
              },
              icon: const Icon(Icons.settings),
              color: primaryColor,
            ),
          ],
        ),
        backgroundColor: primaryColor,
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Card(
                  color: primaryColor,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Text(
                          'Halo! Selamat Datang!',
                          style: Theme.of(context).textTheme.headline5,
                        ),
                        Text(
                          'Mau Makan Dimana Hari ini?',
                          style: Theme.of(context).textTheme.headline6,
                        ),
                      ],
                    ),
                  )),
              Expanded(
                child: buildList(),
              ),
            ],
          ),
        ));
  }

  Widget buildList() {
    return Consumer<RestaurantsProvider>(builder: (context, state, _) {
      if (state.state == ResultState.loading) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      } else if (state.state == ResultState.hasData) {
        return ListView.builder(
            itemCount: state.result.count,
            itemBuilder: (context, index) {
              var restaurant = state.result.restaurants[index];
              return ItemList(restaurants: restaurant);
            });
      } else if (state.state == ResultState.noData) {
        return Center(
          child: Material(
            child: Text(state.message),
          ),
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
    });
  }

  @override
  void dispose() {
    notifSubject.close();
    super.dispose();
  }
}
