import 'package:canting_app/custom_widgets/order_list_item.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  late DateTime now;
  late String monthName;
  late String day;
  late String timeFull;
  late String timeHalf;

  @override
  void initState() {
    super.initState();
    now = DateTime.now();
    monthName = DateFormat('MMMM').format(now);
    day = DateFormat('d').format(now);
    timeFull = DateFormat('HH:mm').format(now); // 24 jam
    timeHalf = DateFormat('HH:mm a').format(now); // 12 jamF
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Text("My Orders"),
        ),
      ),
      body: SingleChildScrollView(
        // physics:Neve,
        child: Padding(
          padding: const EdgeInsetsGeometry.all(16.0),
          child: Column(
            spacing: 16.0,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              OrdersListItem.uncomplete(
                day: day,
                monthName: monthName,
                timeHalf: timeHalf,
                price: '122.500',
              ),
              OrdersListItem.complete(
                day: day,
                monthName: monthName,
                timeHalf: timeHalf,
                price: '62.500',
              ),
              OrdersListItem.complete(
                day: day,
                monthName: monthName,
                timeHalf: timeHalf,
                price: '22.500',
              ),
              OrdersListItem.complete(
                day: day,
                monthName: monthName,
                timeHalf: timeHalf,
                price: '100.000',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
