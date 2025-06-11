import 'package:canting_app/data/models/restaurant/restaurant_detail.dart';

sealed class RestaurantDetailResultState {}

class RestaurantDetailNoneState extends RestaurantDetailResultState {}

class RestaurantDetailLoadingState extends RestaurantDetailResultState {}

class RestaurantDetailErrorState extends RestaurantDetailResultState {
  final String error;

  RestaurantDetailErrorState(this.error);
}

class RestaurantDetailLoadedState extends RestaurantDetailResultState {
  // class model restaurant (bukan responsenya)
  // untuk mengetahui returnnya apa, maka lihat api responsenya (map/list atau lainnya)
  final RestaurantDetail data;

  RestaurantDetailLoadedState(this.data);
}
