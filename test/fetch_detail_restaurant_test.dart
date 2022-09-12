import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:restonest/data/api/api_service.dart';
import 'package:restonest/data/model/detail_restaurants.dart';
import 'fetch_detail_restaurant_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  group('fetch and parsing data detail restaurant', () {
    test('return DetailResult when the http success called', () async {
      const id = 'rqdv5juczeskfw1e867';
      final client = MockClient();
      when(client
              .get(Uri.parse('https://restaurant-api.dicoding.dev/detail/$id')))
          .thenAnswer((_) async => Future.value(http.Response('''
        {
          "error": false,
          "message": "success",
          "restaurant": {
              "id": "rqdv5juczeskfw1e867",
              "name": "Melting Pot",
              "description": "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. ...",
              "city": "Medan",
              "address": "Jln. Pandeglang no 19",
              "pictureId": "14",
              "categories": [
                  {
                      "name": "Italia"
                  },
                  {
                      "name": "Modern"
                  }
              ],
              "menus": {
                  "foods": [
                      {
                          "name": "Paket rosemary"
                      },
                      {
                          "name": "Toastie salmon"
                      }
                  ],
                  "drinks": [
                      {
                          "name": "Es krim"
                      },
                      {
                          "name": "Sirup"
                      }
                  ]
              },
              "rating": 4.2,
              "customerReviews": [
                  {
                      "name": "Ahmad",
                      "review": "Tidak rekomendasi untuk pelajar!",
                      "date": "13 November 2019"
                  }
              ]
          }
      }
      ''', 200)));
      DetailResult result =
          await ApiService().fetchDetailRestaurants(id, client);
      expect(result, isA<DetailResult>());
    });
    test('throw exception when http call error', () {
      final client = MockClient();
      const id = 'rqdv5juczeskfw1e867';
      when(client
              .get(Uri.parse('https://restaurant-api.dicoding.dev/detail/$id')))
          .thenAnswer((_) async => Future.value(http.Response(
            'Not Found', 404)));
      expect(ApiService().fetchDetailRestaurants(id, client), throwsException);
    });
  });
}
