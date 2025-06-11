import 'dart:convert';

import 'package:canting_app/data/models/restaurant/response/restaurant_add_review_response.dart';
import 'package:canting_app/data/models/restaurant/response/restaurant_detail_response.dart';
import 'package:canting_app/data/models/restaurant/response/restaurant_list_response.dart';
import 'package:canting_app/data/models/restaurant/response/restaurant_search_response.dart';
import 'package:canting_app/data/models/restaurant/resquest/restaurant_add_review_request.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ApiServices {
  static const String _baseUrl = "https://restaurant-api.dicoding.dev";

  // GET Restaurant List
  Future<RestaurantListResponse> getRestaurantList() async {
    final response = await http.get(Uri.parse("$_baseUrl/list"));

    if (response.statusCode == 200) {
      return RestaurantListResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception(
        'Failed to load Restaurant list. status code: ${response.statusCode}',
      );
    }
  }

  // GET Restaurant Detail
  Future<RestaurantDetailResponse> getRestaurantDetail(String id) async {
    final response = await http.get(Uri.parse('$_baseUrl/detail/$id'));

    if (response.statusCode == 200) {
      // debugPrint(response.body);
      return RestaurantDetailResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception(
        'Failed to load Restaurant Detail. status code: ${response.statusCode}',
      );
    }
  }

  // POST Restaurant Add Review
  Future<RestaurantAddReviewResponse> postRestaurantAddReview(
    AddReviewRequest requestBody,
  ) async {
    final url = Uri.parse("$_baseUrl/review");
    final headers = <String, String>{'Content-Type': 'application/json'};
    final body = jsonEncode(requestBody.toJson());

    debugPrint('url ke: $url');
    debugPrint('request body: $body');

    final response = await http.post(url, headers: headers, body: body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      return RestaurantAddReviewResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception(
        'Failed to add review. Status code: ${response.statusCode}, Body: ${response.body}',
      );
    }
  }

  // GET Restaurant Search
  Future<RestaurantSearchResponse> getRestaurantSearch(String query) async {
    final response = await http.get(Uri.parse('$_baseUrl/search?q=$query'));

    if (response.statusCode == 200) {
      debugPrint('Search response: ${response.body}');
      return RestaurantSearchResponse.fromJson(jsonDecode(response.body));
    } else {
      debugPrint(
        'Failed to search. Status: ${response.statusCode}, Body: ${response.body}',
      );
      throw Exception(
        'Failed to search restaurants. Status code: ${response.statusCode}',
      );
    }
  }
}
