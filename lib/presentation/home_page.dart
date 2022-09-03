import 'package:flutter/material.dart';
import 'package:restonest/common/styles.dart';

import '../data/model/restaurants.dart';
import 'detail_page.dart';

class HomePage extends StatelessWidget {
  static const routeName = '/home_page';

  const HomePage({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('RESTONEST'),
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
              child: FutureBuilder<String>(
                future: DefaultAssetBundle.of(context).loadString('assets/local_restaurant.json'),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.data == null) {
                      return Center(
                        child: Text('NO DATA', style: Theme.of(context).textTheme.headline4),
                      );
                    } else {
                      final List<Restaurants> restaurants = restaurantsFromJson(snapshot.data);  
                      return ListView.builder(
                        itemCount: restaurants.length,
                        itemBuilder: (context, index) {
                          return _buildRestaurantListItem(context, restaurants[index]);
                        }, 
                      );
                    }// error
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );// loading
                  }
                }
              ),
            ),
          ],
        ),
      )
    );
  }
  
  Widget _buildRestaurantListItem(BuildContext context, Restaurants restaurants) {
    return Material(
        color: primaryColor,
        child: ListTile(
          leading: Hero(
              tag: restaurants.pictureId,
              child: Image.network(
                restaurants.pictureId,
                width: 100,
              ),
            ),
            title: Text(
              restaurants.name,
              style: Theme.of(context).textTheme.headline6,
            ),
            subtitle : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, bottom: 8.0, top: 8.0),
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
                          style: Theme.of(context).textTheme.subtitle2
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
                )
              ],
            ),
            onTap: () {
              Navigator.pushNamed(context, DetailPage.routeName,
                arguments: restaurants
              );
            },
        ),
    );
  }
}