import 'package:canting_app/data/models/restaurant/customer_review.dart';

class RestaurantAddReviewResponse {
  bool error;
  String message;
  List<CustomerReview> customerReviews;

  RestaurantAddReviewResponse({
    required this.error,
    required this.message,
    required this.customerReviews,
  });

  factory RestaurantAddReviewResponse.fromJson(Map<String, dynamic> json) =>
      RestaurantAddReviewResponse(
        error: json["error"],
        message: json["message"],
        customerReviews: List<CustomerReview>.from(
          json["customerReviews"].map((x) => CustomerReview.fromJson(x)),
        ),
      );

  Map<String, dynamic> toJson() => {
    "error": error,
    "message": message,
    "customerReviews": List<dynamic>.from(
      customerReviews.map((x) => x.toJson()),
    ),
  };
}
