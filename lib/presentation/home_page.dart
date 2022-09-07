import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restonest/common/styles.dart';
import 'package:restonest/data/api/api_service.dart';
import 'package:restonest/presentation/search_page.dart';
import 'package:restonest/presentation/widgets/item_list.dart';
import 'package:restonest/provider/restaurants_provider.dart';


class HomePage extends StatelessWidget {
  static const routeName = '/home_page';

  const HomePage({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('RESTONEST'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, SearchPage.routeName);
            }, 
            icon: const Icon(Icons.search),
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
                child: Padding(padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Text('Halo! Selamat Datang!', style: Theme.of(context).textTheme.headline5,),
                      Text('Mau Makan Dimana Hari ini?', style: Theme.of(context).textTheme.headline6,),
                    ],
                  ),
                )
              ),
            Expanded(
              child: ChangeNotifierProvider<RestaurantsProvider>(
                create: (_) => RestaurantsProvider(apiService: ApiService()),
                child: buildList(),
              ),
            ),
          ],
        ),
      )
    );
  }
  Widget buildList() {
    return Consumer<RestaurantsProvider>(
          builder: (context, state, _) {
            if (state.state == ResultState.loading) {
              return const Center(child: CircularProgressIndicator(),);
            } else if (state.state == ResultState.hasData) {
              return ListView.builder(
                itemCount: state.result.count,
                itemBuilder: (context, index) {
                  var restaurant = state.result.restaurants[index];
                  return ItemList(restaurants: restaurant);
                }
              );
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
          }
        );
  }
}