import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restonest/data/api/api_service.dart';
import 'package:restonest/presentation/widgets/item_list.dart';
import 'package:restonest/provider/result_state.dart';
import 'package:restonest/provider/search_provider.dart';

class SearchPage extends StatefulWidget {
  static const routeName = '/search_page';
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final _searchTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SearchProvider>(
        create: (_) => SearchProvider(apiService: ApiService()),
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Search Restoran'),
          ),
          body: Column(
            children: [
              Card(
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _searchTextController,
                        decoration: const InputDecoration(
                            labelStyle: TextStyle(
                                fontWeight: FontWeight.normal,
                                color: Colors.black),
                            labelText: 'Search',
                            enabledBorder: OutlineInputBorder(
                                //Outline border type for TextFeild
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                borderSide: BorderSide(
                                  color: Colors.black,
                                  width: 1,
                                ))),
                        textInputAction: TextInputAction.search,
                      ),
                    ),
                    Builder(builder: (BuildContext context) {
                      return IconButton(
                          onPressed: () {
                            context
                                .read<SearchProvider>()
                                .fetchSearchRestaurants(
                                    _searchTextController.text);
                          },
                          icon: const Icon(Icons.search));
                    }),
                  ],
                ),
              ),
              Expanded(child: buildListSearch()),
            ],
          ),
        ));
  }

  Widget buildListSearch() {
    return Consumer<SearchProvider>(builder: (context, state, _) {
      if (state.state == ResultState.loading) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      } else if (state.state == ResultState.hasData) {
        return ListView.builder(
            itemCount: state.search?.founded,
            itemBuilder: (context, index) {
              var restaurant = state.search?.restaurants[index];
              return ItemList(restaurants: restaurant!);
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
    _searchTextController.dispose();
    super.dispose();
  }
}
