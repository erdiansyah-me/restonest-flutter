import 'package:flutter/cupertino.dart';
import 'package:restonest/data/db/db_helper.dart';
import 'package:restonest/data/model/restaurants.dart';
import 'package:restonest/provider/result_state.dart';

class DatabaseProvider extends ChangeNotifier {
  final DbHelper dbHelper;

  DatabaseProvider({required this.dbHelper}) {
    _getFavorites();
  }

  ResultState _state = ResultState.initialState;
  ResultState get state => _state;

  String _message = '';
  String get message => _message;

  List<Restaurant> _favorites = [];
  List<Restaurant> get favorites => _favorites;

  void _getFavorites() async {
    _favorites = await dbHelper.getFavorite();
    if (_favorites.isNotEmpty) {
      _state = ResultState.hasData;
    } else {
      _state = ResultState.noData;
      _message = 'Empty Data';
    }
    notifyListeners();
  }

  void addFavorite(Restaurant restaurant) async {
    try {
      await dbHelper.insertFavorite(restaurant);
      _getFavorites();
    } catch (e) {
      _state = ResultState.error;
      _message = 'Error Menambahkan ke favorite $e';
      notifyListeners();
    }
  }

  Future<bool> isFavorited(String id) async {
    final favoritedRestaurant = await dbHelper.getFavoriteById(id);
    return favoritedRestaurant.isNotEmpty;
  }

  void removeFavorite(String id) async {
    try {
      await dbHelper.removeFavorite(id);
      _getFavorites();
    } catch (e) {
      _state = ResultState.error;
      _message = 'Error Terjadi kesalahan Menghapus  Favorit $e';
      notifyListeners();
    }
  }
}
