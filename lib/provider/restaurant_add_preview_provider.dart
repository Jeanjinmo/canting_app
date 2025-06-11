import 'package:canting_app/data/api/api_services.dart';
import 'package:canting_app/data/models/restaurant/resquest/restaurant_add_review_request.dart';
import 'package:canting_app/static/restaurant_add_review_result_state.dart';
import 'package:flutter/material.dart';

class RestaurantAddPreviewProvider extends ChangeNotifier {
  final ApiServices _apiServices;
  AddReviewResultState _resultState = AddReviewNoneState();

  RestaurantAddPreviewProvider(this._apiServices);

  // getter
  AddReviewResultState get resultState => _resultState;

  Future<void> addNewReview(
    String restaurantId,
    String name,
    String reviewText,
  ) async {
    try {
      _resultState = AddReviewLoadingState();
      notifyListeners();

      final requestBody = AddReviewRequest(
        id: restaurantId,
        name: name,
        review: reviewText,
      );
      final result = await _apiServices.postRestaurantAddReview(requestBody);

      if (result.error) {
        _resultState = AddReviewErrorState(result.message);
        notifyListeners();
      } else {
        _resultState = AddReviewLoadedState(result.customerReviews);
        notifyListeners();
      }
    } on Exception catch (e) {
      _resultState = AddReviewErrorState(e.toString());
      notifyListeners();
    }
  }

  void resetAddReviewState() {
    _resultState = AddReviewNoneState();
    notifyListeners();
  }
}
