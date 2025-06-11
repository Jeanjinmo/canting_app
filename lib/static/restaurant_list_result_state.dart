import 'package:canting_app/data/models/restaurant/restaurant_list.dart';

sealed class RestaurantListResultState {}

class RestaurantListNoneState extends RestaurantListResultState {}

class RestaurantListLoadingState extends RestaurantListResultState {}

class RestaurantListErrorState extends RestaurantListResultState {
  final String error;

  RestaurantListErrorState(this.error);
}

class RestaurantListLoadedState extends RestaurantListResultState {
  // class model restaurant (bukan responsenya)
  final List<RestaurantList> data;

  RestaurantListLoadedState(this.data);
}
