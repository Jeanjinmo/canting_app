import 'dart:async';

import 'package:canting_app/custom_widgets/custom_elevated_button_rating.dart';
import 'package:canting_app/custom_widgets/custom_error_image_builder.dart';
import 'package:canting_app/custom_widgets/list_restaurant_home_page.dart';
import 'package:canting_app/custom_widgets/widget_error_message.dart';
import 'package:canting_app/custom_widgets/widget_loading_screen.dart';
import 'package:canting_app/provider/restaurant_list_provider.dart';
import 'package:canting_app/provider/restaurant_search_provider.dart';
import 'package:canting_app/static/restaurant_list_result_state.dart';
import 'package:canting_app/static/restaurant_search_result_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

const double borderRadiusCardHeader = 25;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _searchController = TextEditingController();
  Timer? _debounce;
  // debounce
  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      if (query.trim().isNotEmpty) {
        context.read<RestaurantSearchProvider>().performSearch(query.trim());
      } else {
        context.read<RestaurantSearchProvider>().clearSearch();
      }
    });
  }

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      if (mounted) {
        context.read<RestaurantListProvider>().fetchRestaurantList();
      }
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Theme.of(context).colorScheme.primaryContainer,
            Theme.of(context).colorScheme.secondaryContainer,
            Theme.of(context).colorScheme.tertiaryContainer,
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: _homeAppBar(context),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Stack(
                    children: [
                      Container(
                        width: double.infinity,
                        height: 200,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            borderRadiusCardHeader,
                          ),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(
                            borderRadiusCardHeader,
                          ),

                          child: Image.network(
                            'https://cdn.pixabay.com/photo/2019/02/20/09/44/hamburger-4008822_1280.jpg',
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return CustomErrorImageBuilder.noIcon();
                            },
                          ),
                        ),
                      ),
                      _underShadow(),
                      _filledShadow(context),
                    ],
                  ),
                  const SizedBox.square(dimension: 16.0),
                  Row(
                    children: [
                      Expanded(
                        child: SearchBar(
                          controller: _searchController,
                          // search saat mengetik (pake debounce)
                          onChanged: _onSearchChanged,
                          elevation: WidgetStatePropertyAll(0),
                          leading: Icon(Icons.search),
                          hintText: "Search...",

                          padding: WidgetStatePropertyAll(
                            EdgeInsets.symmetric(horizontal: 16.0),
                          ),
                          constraints: BoxConstraints(
                            minHeight: 56.0,
                            maxHeight: 56.0,
                          ),
                          backgroundColor: WidgetStatePropertyAll(
                            Theme.of(context).colorScheme.surface,
                          ),
                        ),
                      ),
                      const SizedBox.square(dimension: 8.0),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.tune),
                        padding: EdgeInsets.zero,
                        style: IconButton.styleFrom(
                          backgroundColor: Theme.of(
                            context,
                          ).colorScheme.surface,
                          minimumSize: Size(56, 56),
                          maximumSize: Size(56, 56),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox.square(dimension: 16.0),
                  // Button List Restaurant berdasarkan kote
                  _filterRestaurantWithCity(),
                  const SizedBox.square(dimension: 24.0),
                  // Count list Festaurant berdasarkan kota
                  _filterRestaurantWithCityCount(),
                  const SizedBox.square(dimension: 8.0),
                  Consumer<RestaurantSearchProvider>(
                    builder: (context, searchProvider, child) {
                      final searchQuery = searchProvider.query;
                      final searchState = searchProvider.state;

                      // tampilan restaurant list dengan search
                      if (searchQuery.isNotEmpty) {
                        return switch (searchState) {
                          // initial
                          RestaurantSearchInitialState() => Center(
                            child: Text("Preparing search..."),
                          ),
                          // loading
                          RestaurantSearchLoadingState() =>
                            WidgetLoadingScreen(),
                          // error
                          RestaurantSearchErrorState(error: var message) =>
                            WidgetErrorMessage(
                              message: "Search failed: $message",
                            ),
                          // empty search
                          RestaurantSearchEmptyState(
                            emptyMessage: var message,
                          ) =>
                            Center(child: Text(message)),
                          // has data
                          RestaurantSearchLoadedState(
                            restaurants: var foundRestaurants,
                          ) =>
                            ListRestaurantHomePage(
                              restaurantList: foundRestaurants,
                            ),
                        };
                        // tampilan restaurant list tanpa search (default)
                      } else {
                        return Consumer<RestaurantListProvider>(
                          builder:
                              (BuildContext context, value, Widget? child) {
                                return switch (value.resultState) {
                                  RestaurantListLoadingState() =>
                                    WidgetLoadingScreen(),
                                  RestaurantListErrorState(
                                    error: var message,
                                  ) =>
                                    WidgetErrorMessage(
                                      message: "Terjadi Kesalahan: $message",
                                    ),
                                  RestaurantListLoadedState() =>
                                    ListRestaurantHomePage(
                                      restaurantList: value.filteredRestaurants,
                                    ),
                                  _ => const SizedBox(),
                                };
                              },
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // text: list restaurant (count)
  Row _filterRestaurantWithCityCount() {
    return Row(
      children: [
        Consumer<RestaurantListProvider>(
          builder: (context, value, child) {
            final count = value.filteredRestaurants.length;
            final cityText = value.selectedCity != null
                ? " in ${value.selectedCity}"
                : "";

            return Text(
              "List Restaurant$cityText ($count)",
              style: Theme.of(
                context,
              ).textTheme.titleSmall!.copyWith(fontWeight: FontWeight.bold),
            );
          },
        ),
        const SizedBox.square(dimension: 4.0),
        Icon(Icons.local_restaurant),
      ],
    );
  }

  // filter restaurant (select all atau by city button)
  SizedBox _filterRestaurantWithCity() {
    return SizedBox(
      height: 40,
      child: Consumer<RestaurantListProvider>(
        builder: (context, value, child) {
          return switch (value.resultState) {
            RestaurantListLoadingState() => WidgetLoadingScreen(),
            RestaurantListErrorState(error: var message) => WidgetErrorMessage(
              message: "Terjadi Kesalahan: $message",
            ),
            // data: var data --> disimpan
            RestaurantListLoadedState() => ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: value.uniqueCities.length + 1,
              separatorBuilder: (context, index) =>
                  const SizedBox.square(dimension: 8.0),
              itemBuilder: (context, index) {
                // Tombol "All" di index 0
                // -------------------------------------------->
                if (index == 0) {
                  final isSelected = value.selectedCity == null;
                  return _showAllButton(isSelected, context, value);
                }
                final restaurantCity = value.uniqueCities[index - 1];
                final isSelected = value.selectedCity == restaurantCity;
                return _showByCityButton(
                  isSelected,
                  context,
                  value,
                  restaurantCity,
                );
              },
            ),
            _ => const SizedBox(),
          };
        },
      ),
    );
  }

  // berkaitan dengan filter juga, cuma buttonnya (show button where city).
  ElevatedButton _showByCityButton(
    bool isSelected,
    BuildContext context,
    RestaurantListProvider value,
    String restaurantCity,
  ) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        padding: EdgeInsets.symmetric(horizontal: 12.0),
        backgroundColor: isSelected
            ? Theme.of(context).colorScheme.primary
            : null,
        foregroundColor: isSelected
            ? Theme.of(context).colorScheme.onPrimary
            : null,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),

        /// jangan dihapus, untuk testing hehe
        // splashFactory: NoSplash.splashFactory,
        // overlayColor: Colors.transparent,
        shadowColor: Colors.transparent,
      ),
      onPressed: () {
        value.setSelectedCity(restaurantCity);
      },
      child: Text(restaurantCity),
    );
  }

  // berkaitan dengan filter juga, cuma button all
  ElevatedButton _showAllButton(
    bool isSelected,
    BuildContext context,
    RestaurantListProvider value,
  ) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        backgroundColor: isSelected
            ? Theme.of(context).colorScheme.primary
            : null,
        foregroundColor: isSelected
            ? Theme.of(context).colorScheme.onPrimary
            : null,
        padding: EdgeInsets.symmetric(horizontal: 12.0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        shadowColor: Colors.transparent,
      ),
      onPressed: () {
        value.clearCityFilter();
      },
      child: Text("All"),
    );
  }

  /// Appbar Home
  AppBar _homeAppBar(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Deliver to", style: Theme.of(context).textTheme.bodySmall),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.location_on, size: 18),
              SizedBox(width: 4),
              Text(
                "Your Location",
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500),
              ),
              Icon(Icons.arrow_drop_down, size: 18),
            ],
          ),
        ],
      ),
      actions: [
        IconButton(icon: Icon(Icons.notifications), onPressed: () {}),
        SizedBox(width: 8),
      ],
      backgroundColor: Colors.transparent,
      elevation: 0,
    );
  }

  /// Shadow disaping 1/2 dari container bagian kiri
  Container _filledShadow(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      height: 200,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadiusCardHeader),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1), // Warna shadow
            blurRadius: 1.0, // Tingkat blur
            spreadRadius: 1.0, // Tingkat penyebaran
            // offset: Offset(0, 4), // Posisi shadow (x, y)
          ),
        ],
      ),
      child: FractionallySizedBox(
        widthFactor: 1 / 2,
        alignment: Alignment.topLeft,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Melting Pot",
              style: Theme.of(
                context,
              ).textTheme.displaySmall!.copyWith(color: Colors.white),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              "Kota: Medan",
              style: Theme.of(
                context,
              ).textTheme.bodyLarge!.copyWith(color: Colors.white),
            ),
            CustomElevatedButtonRating(onPressed: () {}, ratingText: '(4.2)'),
          ],
        ),
      ),
    );
  }

  /// Shadow bawah Container
  Container _underShadow() {
    return Container(
      width: double.infinity,
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadiusCardHeader),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.transparent, Colors.black.withValues(alpha: 0.6)],
          stops: [0.5, 2.0],
        ),
      ),
    );
  }
}
