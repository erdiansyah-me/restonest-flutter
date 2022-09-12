import 'package:flutter/widgets.dart';
import 'package:restonest/data/api/api_service.dart';
import 'package:restonest/data/model/detail_restaurants.dart';
import 'package:restonest/provider/result_state.dart';
import 'package:http/http.dart' as http;

class DetailProvider extends ChangeNotifier {
  final ApiService apiService;

  DetailProvider({required this.apiService});

  late DetailResult _detailResult;
  late ResultState _state;
  String _message = '';

  String _idResto = "";

  set idResto(String newId) {
    if (_idResto != newId) {
      _idResto = newId;
      //load detailnya dari backend
      _fetchDetailRestaurant(_idResto);
    }
  }

  String get idResto => _idResto;

  DetailResult get detail => _detailResult;

  String get message => _message;

  ResultState get state => _state;

  Future<dynamic> _fetchDetailRestaurant(id) async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final restaurant =
          await apiService.fetchDetailRestaurants(id, http.Client());
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
