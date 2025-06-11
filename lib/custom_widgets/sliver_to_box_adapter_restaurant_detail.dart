import 'package:canting_app/data/models/restaurant/restaurant_detail.dart';
import 'package:canting_app/provider/simple_property_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_popup/flutter_popup.dart';
import 'package:provider/provider.dart';

class SliverToBoxAdapterRestaurantDetail extends StatefulWidget {
  final RestaurantDetail restaurantDetail;
  const SliverToBoxAdapterRestaurantDetail({
    super.key,
    required this.restaurantDetail,
  });

  @override
  State<SliverToBoxAdapterRestaurantDetail> createState() =>
      _SliverToBoxAdapterRestaurantDetailState();
}

class _SliverToBoxAdapterRestaurantDetailState
    extends State<SliverToBoxAdapterRestaurantDetail> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Row(
            children: [
              Text(
                widget.restaurantDetail.name,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              Spacer(),
              Text(
                widget.restaurantDetail.city,
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  // color: Theme.of(context).colorScheme.tertiary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Text(widget.restaurantDetail.address),
          const SizedBox.square(dimension: 8.0),
          Container(
            height: 50,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Theme.of(
                context,
              ).colorScheme.tertiaryContainer.withValues(alpha: 0.5),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24.0,
                vertical: 8.0,
              ),
              child: Row(
                spacing: 4.0,
                children: [
                  Icon(Icons.delivery_dining),
                  Text("Free Delivery"),
                  Spacer(),
                  Icon(Icons.timer_rounded),
                  Text("20-30"),
                  Spacer(),
                  Icon(Icons.star_half, color: Colors.amber),
                  Text(widget.restaurantDetail.rating.toString()),
                ],
              ),
            ),
          ),
          const SizedBox.square(dimension: 8.0),
          Text("Description", style: Theme.of(context).textTheme.titleMedium),
          const SizedBox.square(dimension: 8.0),
          _descriptionSection(context),
          const SizedBox.square(dimension: 16.0),
          Text("Categories"),
          const SizedBox.square(dimension: 8.0),
          _categoriesSection(context),
          const SizedBox.square(dimension: 8.0),
          Text(
            "Menus:",
            style: Theme.of(
              context,
            ).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.w500),
          ),
          const SizedBox.square(dimension: 4.0),
          Text("Drinks", style: Theme.of(context).textTheme.titleMedium),
          _drinksSection(),
          const SizedBox.square(dimension: 8.0),
          Text("Foods", style: Theme.of(context).textTheme.titleMedium),
          _foodsSection(),
          const SizedBox.square(dimension: 16.0),
          Text("Reviews (${widget.restaurantDetail.customerReviews.length})"),
          _reviewsSection(),
          const SizedBox.square(dimension: 24.0),
        ],
      ),
    );
  }

  // Review
  ListView _reviewsSection() {
    return ListView.separated(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      separatorBuilder: (context, index) =>
          const SizedBox.square(dimension: 8.0),
      itemCount: widget.restaurantDetail.customerReviews.length,
      itemBuilder: (context, index) {
        final reviews = widget.restaurantDetail.customerReviews[index];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: CircleAvatar(
                child: Image.network(
                  'https://stickershop.line-scdn.net/stickershop/v1/product/8804885/LINEStorePC/main.png?v=1',
                ),
              ),
              title: Text(reviews.name),
              subtitle: Text(reviews.date),
              trailing: CustomPopup(
                content: Text(
                  'Report',
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: Theme.of(context).colorScheme.error,
                  ),
                ),
                child: Icon(Icons.more_vert),
              ),
            ),
            Text(reviews.review),
          ],
        );
      },
    );
  }

  // Foods
  ConstrainedBox _foodsSection() {
    return ConstrainedBox(
      constraints: BoxConstraints(minHeight: 120, maxHeight: 200),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        separatorBuilder: (context, index) =>
            const SizedBox.square(dimension: 16.0),
        itemCount: widget.restaurantDetail.menus.foods.length,
        itemBuilder: (context, index) {
          final food = widget.restaurantDetail.menus.foods[index];
          return LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              final double itemHeight = constraints.maxHeight;
              final double itemWidth = itemHeight;
              return SizedBox(
                width: itemWidth,
                height: itemHeight,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadiusGeometry.circular(20),
                      child: Image.network(
                        'https://cdn.pixabay.com/photo/2017/12/09/08/18/pizza-3007395_1280.jpg',
                        fit: BoxFit.cover,
                      ),
                    ),
                    FractionallySizedBox(
                      heightFactor: 1 / 3,
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(20),
                            bottomLeft: Radius.circular(20),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black45,
                              blurRadius: 1.0,
                              spreadRadius: 1.0,
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            food.name,
                            style: Theme.of(context).textTheme.titleMedium!
                                .copyWith(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }

  // Drinks
  ConstrainedBox _drinksSection() {
    return ConstrainedBox(
      constraints: BoxConstraints(minHeight: 120, maxHeight: 200),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        separatorBuilder: (context, index) =>
            const SizedBox.square(dimension: 16.0),
        itemCount: widget.restaurantDetail.menus.drinks.length,
        itemBuilder: (context, index) {
          final food = widget.restaurantDetail.menus.drinks[index];
          return LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              final double itemHeight = constraints.maxHeight;
              final double itemWidth = itemHeight;
              return SizedBox(
                width: itemWidth,
                height: itemHeight,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadiusGeometry.circular(20),
                      child: Image.network(
                        'https://cdn.pixabay.com/photo/2016/10/14/18/21/tee-1740871_1280.jpg',
                        fit: BoxFit.cover,
                      ),
                    ),
                    FractionallySizedBox(
                      heightFactor: 1 / 3,
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(20),
                            bottomLeft: Radius.circular(20),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black45,
                              blurRadius: 1.0,
                              spreadRadius: 1.0,
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            food.name,
                            style: Theme.of(context).textTheme.titleMedium!
                                .copyWith(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }

  // Category
  Wrap _categoriesSection(BuildContext context) {
    return Wrap(
      spacing: 4.0, // Jarak horizontal antar item
      runSpacing: 8.0, // Jarak vertical antar baris
      children: List.generate(widget.restaurantDetail.categories.length, (
        index,
      ) {
        final categories = widget.restaurantDetail.categories[index];
        return Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.outlineVariant,
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 12.0,
              vertical: 8.0,
            ),
            child: Text(categories.name),
          ),
        );
      }),
    );
  }

  // Description
  Column _descriptionSection(BuildContext context) {
    bool isExpanded = context.watch<SimplePropertyProvider>().isExpanded;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Bagian Deskripsi dengan Show More/Less
        Text(
          widget.restaurantDetail.description,
          overflow: isExpanded ? TextOverflow.visible : TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(),
          maxLines: isExpanded ? null : 4,
        ),
        GestureDetector(
          onTap: () {
            context.read<SimplePropertyProvider>().toggleExpanded();
          },
          child: Text(
            isExpanded ? "Show Less" : "Show More",
            style: TextStyle(color: Theme.of(context).colorScheme.primary),
          ),
        ),
      ],
    );
  }
}
