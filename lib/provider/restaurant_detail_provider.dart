import 'dart:io';

import 'package:canting_app/data/api/api_services.dart';
import 'package:canting_app/static/restaurant_detail_result_state.dart';
import 'package:flutter/material.dart';

class RestaurantDetailProvider extends ChangeNotifier {
  final ApiServices _apiServices;
  RestaurantDetailResultState _resultState = RestaurantDetailNoneState();

  RestaurantDetailProvider(this._apiServices);

  RestaurantDetailResultState get resultState => _resultState;

  Future<void> fetchRestaurantDetail(String id) async {
    try {
      _resultState = RestaurantDetailLoadingState();
      notifyListeners();

      final result = await _apiServices.getRestaurantDetail(id);
      if (result.error) {
        _resultState = RestaurantDetailErrorState(result.message);
        notifyListeners();
      } else {
        _resultState = RestaurantDetailLoadedState(result.restaurant);
        notifyListeners();
      }
    } on Exception catch (e) {
      String errorMessage;
      if (e is SocketException) {
        errorMessage =
            "Failed to connect to the server. Please check your internet connection.";
        notifyListeners();
      } else {
        errorMessage = "An error occurred: ${e.toString()}";
        notifyListeners();
      }
      _resultState = RestaurantDetailErrorState(errorMessage);
      notifyListeners();
    }
  }
}
