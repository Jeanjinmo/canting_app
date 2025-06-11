import 'package:canting_app/custom_widgets/custom_elevated_button_rating.dart';
import 'package:canting_app/data/models/restaurant/restaurant_list.dart';
import 'package:canting_app/routes/navigation_route.dart';
import 'package:flutter/material.dart';

const double borderRadiusCardList = 15;

class ListRestaurantHomePage extends StatelessWidget {
  final List<RestaurantList> restaurantList;
  const ListRestaurantHomePage({super.key, required this.restaurantList});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: restaurantList.length,
      separatorBuilder: (context, index) =>
          const SizedBox.square(dimension: 8.0),
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        final restaurant = restaurantList[index];
        return InkWell(
          onTap: () {
            // jangan dihapus.
            // Hilangkan fokus node dari elemen apa pun yang sedang aktif di aplikasi
            FocusManager.instance.primaryFocus?.unfocus();
            // fokus node dari search bar homepage.
            // FocusScope.of(context).unfocus();
            Navigator.pushNamed(
              context,
              NavigationRoute.detailRoute.name,
              arguments: restaurant.id,
            );
          },
          child: Card(
            margin: EdgeInsets.zero,
            elevation: 2.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadiusCardList),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(borderRadiusCardList),
              child: Column(
                children: [
                  Stack(
                    children: [
                      Hero(
                        tag: restaurant.id,
                        child: Image.network(
                          // 'https://cdn.pixabay.com/photo/2017/12/09/08/18/pizza-3007395_1280.jpg',
                          restaurant.largeImageUrl,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 8.0,
                          horizontal: 12.0,
                        ),
                        child: CustomElevatedButtonRating(
                          ratingText: restaurant.rating.toString(),
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                  ListTile(
                    title: Text(
                      restaurant.name,
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.location_on),
                        Text(restaurant.city),
                      ],
                    ),
                    subtitle: FractionallySizedBox(
                      widthFactor: 1 / 2,
                      alignment: Alignment.topLeft,
                      child: Text(
                        restaurant.description,
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          overflow: TextOverflow.clip,
                        ),
                        maxLines: 1,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
