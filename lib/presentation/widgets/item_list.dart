// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:restonest/common/styles.dart';
import 'package:restonest/data/model/restaurants.dart';
import 'package:restonest/presentation/detail_page.dart';
import 'package:restonest/provider/detail_provider.dart';

class ItemList extends StatelessWidget {
  final Restaurant restaurants;

  const ItemList({
    Key? key,
    required this.restaurants,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: primaryColor,
      child: ListTile(
        leading: Hero(
          tag: restaurants.pictureId,
          child: Image.network(
            'https://restaurant-api.dicoding.dev/images/small/${restaurants.pictureId}',
            width: 100,
          ),
        ),
        title: Text(
          restaurants.name,
          style: Theme.of(context).textTheme.headline6,
        ),
        subtitle: Column(
          children: [
            Padding(
                padding:
                    const EdgeInsets.only(left: 8.0, bottom: 8.0, top: 8.0),
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
                          style: Theme.of(context).textTheme.subtitle2),
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
                ))
          ],
        ),
        onTap: () {
          context.read<DetailProvider>().idResto = restaurants.id;
          Navigator.pushNamed(context, DetailPage.routeName);
        },
      ),
    );
  }
}
