import 'package:canting_app/data/models/restaurant/restaurant_list.dart';

sealed class RestaurantSearchResultState {}

// State awal sebelum pencarian dilakukan
class RestaurantSearchInitialState extends RestaurantSearchResultState {}

class RestaurantSearchLoadingState extends RestaurantSearchResultState {}

class RestaurantSearchErrorState extends RestaurantSearchResultState {
  final String error;
  RestaurantSearchErrorState(this.error);
}

// State ketika pencarian berhasil namun tidak ada hasil yang ditemukan
class RestaurantSearchEmptyState extends RestaurantSearchResultState {
  final String emptyMessage;
  RestaurantSearchEmptyState(this.emptyMessage);
}

class RestaurantSearchLoadedState extends RestaurantSearchResultState {
  final List<RestaurantList> restaurants;
  RestaurantSearchLoadedState(this.restaurants);
}
