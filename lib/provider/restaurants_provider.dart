import 'package:flutter/widgets.dart';
import 'package:restonest/data/api/api_service.dart';
import 'package:restonest/data/model/restaurants.dart';

enum ResultState { loading, noData, hasData, error}

class RestaurantsProvider extends ChangeNotifier {
  final ApiService apiService;
  
  RestaurantsProvider({required this.apiService}) {
    _fetchAllRestaurants();
  }

  late RestaurantsResult _restaurantsResult;
  late ResultState _state;
  String _message = '';

  String get message => _message;

  RestaurantsResult get result => _restaurantsResult;
  
  ResultState get state => _state;
  
  Future<dynamic> _fetchAllRestaurants() async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final restaurant = await apiService.allRestaurants();
      if (restaurant.restaurants.isEmpty) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'Terjadi kesalahan!/nTidak Dapat Menampilkan Restoran';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _restaurantsResult = restaurant;
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = 'Terjadi kesalahan! Tidak Dapat Menampilkan Restoran';
    }
  }
  
  
}