/*
model key restaurant
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
 */

import 'package:canting_app/data/models/restaurant/category.dart';
import 'package:canting_app/data/models/restaurant/customer_review.dart';
import 'package:canting_app/data/models/restaurant/menus.dart';

class RestaurantDetail {
  String id;
  String name;
  String description;
  String city;
  String address;
  String pictureId;
  List<Category> categories;
  Menus menus;
  double rating;
  List<CustomerReview> customerReviews;

  RestaurantDetail({
    required this.id,
    required this.name,
    required this.description,
    required this.city,
    required this.address,
    required this.pictureId,
    required this.categories,
    required this.menus,
    required this.rating,
    required this.customerReviews,
  });

  factory RestaurantDetail.fromJson(Map<String, dynamic> json) =>
      RestaurantDetail(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        city: json["city"],
        address: json["address"],
        pictureId: json["pictureId"],
        categories: List<Category>.from(
          json["categories"].map((x) => Category.fromJson(x)),
        ),
        menus: Menus.fromJson(json["menus"]),
        rating: json["rating"]?.toDouble(),
        customerReviews: List<CustomerReview>.from(
          json["customerReviews"].map((x) => CustomerReview.fromJson(x)),
        ),
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "city": city,
    "address": address,
    "pictureId": pictureId,
    "categories": List<dynamic>.from(categories.map((x) => x.toJson())),
    "menus": menus.toJson(),
    "rating": rating,
    "customerReviews": List<dynamic>.from(
      customerReviews.map((x) => x.toJson()),
    ),
  };

  /// pictureId untuk getImage
  String get smallImageUrl =>
      'https://restaurant-api.dicoding.dev/images/small/$pictureId';
  String get mediumImageUrl =>
      'https://restaurant-api.dicoding.dev/images/medium/$pictureId';
  String get largeImageUrl =>
      'https://restaurant-api.dicoding.dev/images/large/$pictureId';
}
