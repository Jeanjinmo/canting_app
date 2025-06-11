import 'package:canting_app/custom_widgets/custom_text_input_.dart';
import 'package:canting_app/custom_widgets/sliver_to_box_adapter_restaurant_detail.dart';
import 'package:canting_app/custom_widgets/widget_error_message.dart';
import 'package:canting_app/custom_widgets/widget_loading_screen.dart';
import 'package:canting_app/provider/restaurant_add_preview_provider.dart';
import 'package:canting_app/provider/restaurant_detail_provider.dart';
import 'package:canting_app/static/restaurant_add_review_result_state.dart';
import 'package:canting_app/static/restaurant_detail_result_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DetailPage extends StatefulWidget {
  final String restaurantId;
  const DetailPage({super.key, required this.restaurantId});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _myReviewController = TextEditingController();
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      if (mounted) {
        context.read<RestaurantDetailProvider>().fetchRestaurantDetail(
          widget.restaurantId,
        );
      }
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _myReviewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            automaticallyImplyLeading: true,
            pinned: true,
            // floating: true,
            // snap: true,
            // elevation: 0,
            // backgroundColor: Colors.transparent,
            actions: [
              IconButton(onPressed: () {}, icon: Icon(Icons.favorite_outline)),
              IconButton(onPressed: () {}, icon: Icon(Icons.shopping_cart)),
            ],
            // kombinasi antara gambar dan lengkungan modal bottomsheet namun di sliverAppbar
            flexibleSpace: _imageFlexibleSpaceConsumer(colorScheme),
            bottom: _showDragHandleSliverAppBar(colorScheme, context),
          ),
          SliverToBoxAdapter(
            child: Consumer<RestaurantDetailProvider>(
              builder: (context, value, child) {
                return switch (value.resultState) {
                  RestaurantDetailLoadingState() => WidgetLoadingScreen(),
                  RestaurantDetailErrorState(error: var message) =>
                    WidgetErrorMessage(message: "Terjadi Kesalahan: $message"),
                  RestaurantDetailLoadedState(data: var data) =>
                    SliverToBoxAdapterRestaurantDetail(restaurantDetail: data),
                  _ => const SizedBox(),
                };
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showDialog<String>(
            context: context,
            builder: (BuildContext dialogContext) {
              return Consumer<RestaurantAddPreviewProvider>(
                builder: (context, value, child) {
                  return switch (value.resultState) {
                    AddReviewLoadingState() => _loadingDialogReview(),
                    AddReviewErrorState(error: var message) =>
                      _errorDialogReview(message, value, dialogContext),
                    AddReviewLoadedState() => _successDialogReview(
                      value,
                      context,
                      dialogContext,
                    ),
                    _ => _addDialogReview(value, dialogContext, context),
                  };
                },
              );
            },
          );
        },
        label: Text("Send Review"),
        icon: Icon(Icons.rate_review),
      ),
    );
  }

  Dialog _addDialogReview(
    RestaurantAddPreviewProvider value,
    BuildContext dialogContext,
    BuildContext context,
  ) {
    return Dialog(
      // Default state - tampilkan dialog form review
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          spacing: 8.0,
          children: <Widget>[
            Center(
              child: Text(
                "Add Review",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 8),
            const Text("Nama"),
            CustomTextInput(
              controller: _nameController,
              textInputType: TextInputType.text,
              hintText: "Name",
            ),
            const Text("Review"),
            CustomTextInput(
              controller: _myReviewController,
              textInputType: TextInputType.multiline,
              hintText: "write a comment...",
            ),
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () {
                      value.resetAddReviewState();
                      Navigator.pop(dialogContext);
                    },
                    child: const Text('Close'),
                  ),
                ),
                Expanded(
                  child: TextButton(
                    onPressed: () async {
                      // Validasi input
                      if (_nameController.text.isEmpty ||
                          _myReviewController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Please fill all fields")),
                        );
                        return;
                      }

                      await context
                          .read<RestaurantAddPreviewProvider>()
                          .addNewReview(
                            widget.restaurantId,
                            _nameController.text,
                            _myReviewController.text,
                          );
                    },
                    child: const Text('Submit'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Dialog _successDialogReview(
    RestaurantAddPreviewProvider value,
    BuildContext context,
    BuildContext dialogContext,
  ) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.check_circle, color: Colors.green, size: 48),
            SizedBox(height: 16),
            Text(
              "Success!",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text("Review added successfully", textAlign: TextAlign.center),
            SizedBox(height: 16),
            TextButton(
              onPressed: () {
                value.resetAddReviewState();
                final provider = context.read<RestaurantAddPreviewProvider>();
                if (provider.resultState is AddReviewLoadedState) {
                  _nameController.clear();
                  _myReviewController.clear();
                }
                context.read<RestaurantDetailProvider>().fetchRestaurantDetail(
                  widget.restaurantId,
                );
                Navigator.pop(dialogContext);
              },
              child: Text("Close"),
            ),
          ],
        ),
      ),
    );
  }

  Dialog _errorDialogReview(
    String message,
    RestaurantAddPreviewProvider value,
    BuildContext dialogContext,
  ) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.error, color: Colors.red, size: 48),
            SizedBox(height: 16),
            Text(
              "Error",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(message, textAlign: TextAlign.center),
            SizedBox(height: 16),
            TextButton(
              onPressed: () {
                value.resetAddReviewState();
              },
              child: Text("Try Again"),
            ),
            TextButton(
              onPressed: () {
                value.resetAddReviewState();
                Navigator.pop(dialogContext);
              },
              child: Text("Close"),
            ),
          ],
        ),
      ),
    );
  }

  // loading dialog review
  Dialog _loadingDialogReview() {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text("Submitting review..."),
          ],
        ),
      ),
    );
  }

  // garis lengkungan dan showDragHandle seperti modalBottomsheet
  PreferredSize _showDragHandleSliverAppBar(
    ColorScheme colorScheme,
    BuildContext context,
  ) {
    return PreferredSize(
      preferredSize: Size.fromHeight(30.0),
      child: Container(
        height: 30,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40),
            topRight: Radius.circular(40),
          ),
          color: colorScheme.surface,
        ),
        child: Center(
          child: Container(
            margin: EdgeInsets.only(top: 8.0),
            width: MediaQuery.of(context).size.width * 0.10, // 10%
            height: 5,
            decoration: BoxDecoration(
              color: colorScheme.onSurfaceVariant.withValues(alpha: 0.4),
              borderRadius: BorderRadius.circular(2.5),
            ),
          ),
        ),
      ),
    );
  }

  // Image Appbar
  FlexibleSpaceBar _imageFlexibleSpaceConsumer(ColorScheme colorScheme) {
    return FlexibleSpaceBar(
      expandedTitleScale: 1.5,
      background: Stack(
        // fit -> mengisi seluruh ruang dari stack
        fit: StackFit.expand,
        children: [
          Consumer<RestaurantDetailProvider>(
            builder: (BuildContext context, value, Widget? child) {
              // return switch (value.resultState) {
              //   RestaurantDetailNoneState() => throw UnimplementedError(),
              //   RestaurantDetailLoadingState() => throw UnimplementedError(),
              //   RestaurantDetailErrorState() => throw UnimplementedError(),
              //   RestaurantDetailLoadedState() => throw UnimplementedError(),
              // };
              /// coba g pake switch case
              if (value.resultState is RestaurantDetailLoadedState) {
                final restaurant =
                    (value.resultState as RestaurantDetailLoadedState).data;
                return Hero(
                  tag: restaurant.id,
                  child: Image.network(
                    restaurant.largeImageUrl,
                    fit: BoxFit.cover,
                  ),
                );
              } else if (value.resultState is RestaurantDetailLoadingState) {
                return WidgetLoadingScreen();
              } else if (value.resultState is RestaurantDetailErrorState) {
                return WidgetErrorMessage(
                  message:
                      "Terjadi Kesalahan: ${(value.resultState as RestaurantDetailErrorState).error}",
                );
              } else {
                return SizedBox();
              }
            },
          ),
          // shadow ngeexpand, jadi buat positionned.
          Positioned(
            // top: 0,
            bottom: 0,
            // width: 50,
            left: 0,
            right: 0,
            height: 50,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    colorScheme.surface.withValues(alpha: 0.8),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
