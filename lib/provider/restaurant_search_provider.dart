import 'package:canting_app/data/api/api_services.dart';
import 'package:canting_app/static/restaurant_search_result_state.dart';
import 'package:flutter/material.dart';

class RestaurantSearchProvider extends ChangeNotifier {
  final ApiServices _apiServices;
  String _query = "";
  RestaurantSearchResultState _resultState = RestaurantSearchInitialState();

  RestaurantSearchProvider(this._apiServices);

  // Getter
  String get query => _query;
  RestaurantSearchResultState get state => _resultState;

  Future<void> performSearch(String newQuery) async {
    _query = newQuery.trim();

    if (_query.isEmpty) {
      // reset jika kosong
      _resultState = RestaurantSearchInitialState();
      notifyListeners();
      return;
    }

    _resultState = RestaurantSearchLoadingState();
    notifyListeners();

    try {
      final result = await _apiServices.getRestaurantSearch(_query);
      if (result.error) {
        // error message tidak ada di api, jadi kita buat aja error statis
        _resultState = RestaurantSearchErrorState(
          "API Error: Failed to fetch search results.",
        );
        notifyListeners();
      } else {
        if (result.founded == 0 || result.restaurants.isEmpty) {
          // empty message tidak ada di api, jadi kita buat aja error statis
          _resultState = RestaurantSearchEmptyState(
            "No restaurants found for '$_query'.",
          );
          notifyListeners();
        } else {
          _resultState = RestaurantSearchLoadedState(result.restaurants);
          notifyListeners();
        }
      }
    } on Exception catch (e) {
      _resultState = RestaurantSearchErrorState(e.toString());
      notifyListeners();
    }
  }

  // reset query & reset state
  void clearSearch() {
    _query = "";
    _resultState = RestaurantSearchInitialState();
    notifyListeners();
  }
}
