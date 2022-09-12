import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restonest/common/styles.dart';
import 'package:restonest/presentation/widgets/item_list.dart';
import 'package:restonest/provider/database_provider.dart';
import 'package:restonest/provider/result_state.dart';

class FavoritePage extends StatelessWidget {
  static const routeName = '/favorite_page';
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<DatabaseProvider>(builder: (context, state, _) {
      return Scaffold(
          appBar: AppBar(
            title: const Text('Favorite RestoNest'),
          ),
          backgroundColor: primaryColor,
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: buildList(context, state),
          ));
    });
  }

  Widget buildList(BuildContext context, DatabaseProvider state) {
    if (state.state == ResultState.loading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else if (state.state == ResultState.hasData) {
      return ListView.builder(
          itemCount: state.favorites.length,
          itemBuilder: (context, index) {
            var restaurant = state.favorites[index];
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
  }
}
