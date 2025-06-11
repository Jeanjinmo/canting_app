import 'package:flutter/material.dart';

enum OrderItemType { complete, uncomplete }

class OrdersListItem extends StatelessWidget {
  final String day;
  final String monthName;
  final String timeHalf;
  final String price;
  final String status;
  final OrderItemType type;

  const OrdersListItem.complete({
    super.key,
    required this.day,
    required this.monthName,
    required this.timeHalf,
    required this.price,
  }) : type = OrderItemType.complete,
       status = 'Delivered';

  const OrdersListItem.uncomplete({
    super.key,
    required this.day,
    required this.monthName,
    required this.timeHalf,
    required this.price,
  }) : type = OrderItemType.uncomplete,
       status = 'Active';

  @override
  Widget build(BuildContext context) {
    return Container(
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
            if (type == OrderItemType.uncomplete) ...[
              const SizedBox.square(dimension: 8.0),
              _foodsAndDrinksList(context),
              const SizedBox.square(dimension: 8.0),
              _foodsAndDrinksList(context),
              Divider(thickness: 1.5),
              _trackingOrders(context),
              Divider(thickness: 1.5),
            ],
            _totalPrice(context, price: price),
          ],
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
          subtitle: Text("$day $monthName, $timeHalf"),
          trailing: type == OrderItemType.complete
              ? Container(
                  padding: EdgeInsets.symmetric(vertical: 3.0, horizontal: 6.0),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.outlineVariant,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    status,
                    style: Theme.of(context).textTheme.labelLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onTertiary,
                    ),
                  ),
                )
              : Text(
                  status,
                  style: Theme.of(
                    context,
                  ).textTheme.labelLarge!.copyWith(color: Colors.green),
                ),
        ),
      ],
    );
  }

  /// Tracking Orders
  Column _trackingOrders(BuildContext context) {
    return Column(
      children: [
        ListTile(
          contentPadding: EdgeInsets.zero,
          leading: Text("On the way"),
          trailing: Text("$day $monthName, $timeHalf"),
        ),
        Row(
          children: [
            Text("RST"),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: SizedBox(
                  height: 10,
                  child: LinearProgressIndicator(
                    value: 0.7,
                    color: Theme.of(context).colorScheme.primary,
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ),
            Text("You"),
          ],
        ),
        const SizedBox.square(dimension: 8.0),
        SizedBox(
          width: double.infinity,
          child: FilledButton(
            style: FilledButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadiusGeometry.circular(12.0),
              ),
            ),
            onPressed: () {},
            child: Text("Tracking"),
          ),
        ),
      ],
    );
  }

  /// List Foods and Drinks
  Container _foodsAndDrinksList(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: CircleAvatar(
            child: Image.network(
              'https://cdn.pixabay.com/photo/2022/08/31/10/17/hamburger-7422968_1280.jpg',
            ),
          ),
        ),
        title: Text("Chicken Burger"),
        trailing: Text("x1"),
      ),
    );
  }

  /// Total Price
  Align _totalPrice(BuildContext context, {required String price}) {
    return Align(
      alignment: Alignment.centerRight,
      child: RichText(
        text: TextSpan(
          style: Theme.of(context).textTheme.bodyMedium,
          children: <TextSpan>[
            TextSpan(text: 'Total: '),
            TextSpan(
              text: "Rp.$price",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
