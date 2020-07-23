
import 'package:eatwat/models/order_model.dart';
import 'package:eatwat/screens/food/order_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderList extends StatefulWidget {
  @override
  _OrderListState createState() => _OrderListState();
}

class _OrderListState extends State<OrderList> {
  @override
  Widget build(BuildContext context) {
    // access the data from the stream, return a list
    final orders = Provider.of<List<Order>>(context);
    
    // use listview to output all items in the list
    return ListView.builder(
      itemCount: orders?.length ?? 0,
      itemBuilder: (context, index) {
        // a new widget for each individual item
        return OrderTile(order: orders[index]);
      },
    );
  }
}