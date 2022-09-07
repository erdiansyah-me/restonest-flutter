import 'package:flutter/widgets.dart';
import 'package:restonest/data/api/api_service.dart';
import 'package:restonest/data/model/detail_restaurants.dart';

enum ResultState { loading, noData, hasData, error}

class DetailProvider extends ChangeNotifier {
  final ApiService apiService;
  final String id;

  DetailProvider({required this.apiService, required this.id}){
    _fetchDetailRestaurant(id);
  }
  
  late DetailResult _detailResult;
  late ResultState _state;
  String _message = '';

  DetailResult get detail => _detailResult;

  String get message => _message;

  ResultState get state => _state;

  Future<dynamic> _fetchDetailRestaurant(id) async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final restaurant = await apiService.detailRestaurants(id);
      if (restaurant.error == true) {
        _state = ResultState.error;
        notifyListeners();
        return _message = 'Error! Tidak Bisa Menemukan Restoran';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _detailResult = restaurant;
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = 'Error! Tidak Bisa Menemukan Restoran';
    }
  }
}