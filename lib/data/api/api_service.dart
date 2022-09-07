import 'dart:convert';

import 'package:restonest/data/model/detail_restaurants.dart';
import 'package:restonest/data/model/restaurants.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static const String _baseUrl = 'https://restaurant-api.dicoding.dev';

  Future<RestaurantsResult> allRestaurants() async {
    final response = await http.get(Uri.parse('$_baseUrl/list'));
    if (response.statusCode == 200) {
      return RestaurantsResult.fromJson(json.decode(response.body));
    } else {
      throw Exception('Gagal Mendapatkan Data Restoran');
    }
  }
  Future<SearchResult> searchRestaurants(query) async {
    final response = await http.get(Uri.parse('$_baseUrl/search?q=$query'));
    if (response.statusCode == 200) {
      return SearchResult.fromJson(json.decode(response.body));
    } else {
      throw Exception('Gagal Mencari Restoran');
    }
  }
  Future<DetailResult> detailRestaurants(id) async {
    final response = await http.get(Uri.parse('$_baseUrl/detail/$id'));
    if (response.statusCode == 200) {
      return DetailResult.fromJson(json.decode(response.body));
    } else {
      throw Exception('Gagal Mendapatkan Detail Restoran');
    }
  }
}