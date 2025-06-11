import 'dart:io';

import 'package:canting_app/data/api/api_services.dart';
import 'package:canting_app/data/models/restaurant/restaurant_list.dart';
import 'package:canting_app/static/restaurant_list_result_state.dart';
import 'package:flutter/material.dart';

class RestaurantListProvider extends ChangeNotifier {
  final ApiServices _apiServices;
  RestaurantListResultState _resultState = RestaurantListNoneState();
  String? _selectedCity;
  List<RestaurantList> _allRestaurants = [];

  RestaurantListProvider(this._apiServices);

  RestaurantListResultState get resultState => _resultState;
  String? get selectedCity => _selectedCity;

  // get Cities Unique
  List<String> get uniqueCities {
    if (_resultState is RestaurantListLoadedState) {
      final data = (_resultState as RestaurantListLoadedState).data;
      return data.map((restaurant) => restaurant.city).toSet().toList();
    }
    return [];
  }

  // Get Restaurant Filtered by City
  List<RestaurantList> get filteredRestaurants {
    if (_selectedCity == null || _selectedCity!.isEmpty) {
      return _allRestaurants;
    }
    return _allRestaurants
        .where((restaurant) => restaurant.city == _selectedCity)
        .toList();
  }

  // set SelectedCity buat pilih kota
  void setSelectedCity(String? city) {
    _selectedCity = city;
    notifyListeners();
  }

  // Null Selected City
  void clearCityFilter() {
    _selectedCity = null;
    notifyListeners();
  }

  // manggil api buat dapatin restaurant list
  Future<void> fetchRestaurantList() async {
    try {
      _resultState = RestaurantListLoadingState();
      notifyListeners();

      final result = await _apiServices.getRestaurantList();

      if (result.error) {
        _resultState = RestaurantListErrorState(result.message);
        notifyListeners();
      } else {
        _allRestaurants = result.restaurants;
        _resultState = RestaurantListLoadedState(result.restaurants);
        notifyListeners();
      }
    } on Exception catch (e) {
      // _resultState = RestaurantListErrorState(e.toString());
      String errorMessage;
      if (e is SocketException) {
        errorMessage =
            "Failed to connect to the server. Please check your internet connection.";
        notifyListeners();
      } else {
        errorMessage = "An error occurred: ${e.toString()}";
        notifyListeners();
      }
      _resultState = RestaurantListErrorState(errorMessage);
      notifyListeners();
    }
  }
}
