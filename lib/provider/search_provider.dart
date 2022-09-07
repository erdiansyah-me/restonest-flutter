import 'package:flutter/widgets.dart';
import 'package:restonest/data/api/api_service.dart';
import 'package:restonest/data/model/restaurants.dart';

enum ResultState { loading, noData, hasData, error, initialState}

class SearchProvider extends ChangeNotifier {
  final ApiService apiService;

  SearchProvider({required this.apiService});
  
  SearchResult? _searchResult;
  ResultState _state = ResultState.initialState;
  String _message = '';

  SearchResult? get search => _searchResult;

  String get message => _message;

  ResultState get state => _state;

  void fetchSearchRestaurants(String query) async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final restaurant = await apiService.searchRestaurants(query);
      if (restaurant.restaurants.isEmpty) {
        _state = ResultState.noData;
        notifyListeners();
        _message = 'Restoran tidak bisa ditemukan';
      } else if (restaurant.founded == 0) {
        _state = ResultState.noData;
        notifyListeners();
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        _searchResult = restaurant;
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      _message = 'Error! Tidak Dapat Mencari Restoran';
    }
  }
}