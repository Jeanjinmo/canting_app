// Testing
// widget tidak dipakai.
// jangan dihapus
import 'package:canting_app/provider/simple_property_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum OrderItemType { complete, uncomplete }

class OrderItemTypeAnimation extends StatefulWidget {
  final String day;
  final String monthName;
  final String timeHalf;
  final String price;
  final String status;
  final OrderItemType type;

  const OrderItemTypeAnimation.complete({
    super.key,
    required this.day,
    required this.monthName,
    required this.timeHalf,
    required this.price,
  }) : type = OrderItemType.complete,
       status = 'Delivered';

  const OrderItemTypeAnimation.uncomplete({
    super.key,
    required this.day,
    required this.monthName,
    required this.timeHalf,
    required this.price,
  }) : type = OrderItemType.uncomplete,
       status = 'Active';

  @override
  State<OrderItemTypeAnimation> createState() =>
      _OrdersListItemAnimationState();
}

class _OrdersListItemAnimationState extends State<OrderItemTypeAnimation> {
  @override
  Widget build(BuildContext context) {
    bool isExpanded = context.watch<SimplePropertyProvider>().isExpanded;
    return InkWell(
      onTap: () {
        if (widget.type == OrderItemType.uncomplete) {
          context.read<SimplePropertyProvider>().toggleExpanded();
        }
      },
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border.all(
            width: 1.5,
            color: Theme.of(context).colorScheme.outlineVariant,
          ),
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              _driverOrderProfile(context),
              Divider(thickness: 1.5),
              if (widget.type == OrderItemType.uncomplete)
                AnimatedCrossFade(
                  firstChild: const SizedBox.shrink(),
                  secondChild: Column(
                    children: [
                      const SizedBox.square(dimension: 8.0),
                      _foodsAndDrinksList(context),
                      const SizedBox.square(dimension: 8.0),
                      _foodsAndDrinksList(context),
                      Divider(thickness: 1.5),
                      _trackingOrders(context),
                      Divider(thickness: 1.5),
                    ],
                  ),
                  crossFadeState: isExpanded
                      ? CrossFadeState.showSecond
                      : CrossFadeState.showFirst,
                  duration: const Duration(milliseconds: 300),
                ),
              _totalPrice(context, price: widget.price),
            ],
          ),
        ),
      ),
    );
  }

  /// Driver Order Profile
  Column _driverOrderProfile(BuildContext context) {
    return Column(
      children: [
        ListTile(
          contentPadding: EdgeInsets.zero,
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: CircleAvatar(
              backgroundColor: Colors.grey[300],
              radius: 25,
              child: Image.network(
                'https://stickershop.line-scdn.net/stickershop/v1/product/28539734/LINEStorePC/main.png?v=1',
                fit: BoxFit.cover,
              ),
            ),
          ),
          title: Text("#123456"),
          subtitle: Text(
            "${widget.day} ${widget.monthName}, ${widget.timeHalf}",
          ),
          trailing: widget.type == OrderItemType.complete
              ? Container(
                  padding: EdgeInsets.symmetric(vertical: 3.0, horizontal: 6.0),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.outlineVariant,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    widget.status,
                    style: Theme.of(context).textTheme.labelLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onTertiary,
                    ),
                  ),
                )
              : Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      widget.status,
                      style: Theme.of(
                        context,
                      ).textTheme.labelLarge!.copyWith(color: Colors.green),
                    ),
                    Icon(
                      context.watch<SimplePropertyProvider>().isExpanded
                          ? Icons.expand_less
                          : Icons.expand_more,
                      color: Colors.grey,
                    ),
                  ],
                ),
        ),
      ],
    );
  }

  /// Foods and Drinks List
  Row _foodsAndDrinksList(BuildContext context) {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: CircleAvatar(
            backgroundColor: Colors.grey[300],
            radius: 25,
            child: Image.network(
              'https://stickershop.line-scdn.net/stickershop/v1/product/28539734/LINEStorePC/main.png?v=1',
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Mie Goreng Special',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 4),
              Text('Rp 15.000', style: Theme.of(context).textTheme.labelMedium),
            ],
          ),
        ),
        Text('x1', style: Theme.of(context).textTheme.titleMedium),
      ],
    );
  }

  /// Tracking Orders
  Column _trackingOrders(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Order Status',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Text(
              'On Process',
              style: Theme.of(
                context,
              ).textTheme.titleMedium!.copyWith(color: Colors.green),
            ),
          ],
        ),
        const SizedBox(height: 12),
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: LinearProgressIndicator(
            value: 0.7,
            backgroundColor: Colors.grey[300],
            valueColor: AlwaysStoppedAnimation<Color>(
              Theme.of(context).colorScheme.primary,
            ),
            minHeight: 8,
          ),
        ),
        const SizedBox(height: 8),
      ],
    );
  }

  /// Total Price
  Row _totalPrice(BuildContext context, {required String price}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('Total', style: Theme.of(context).textTheme.titleMedium),
        Text(
          price,
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      ],
    );
  }
}
