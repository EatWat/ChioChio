import 'package:eatwat/models/order_model.dart';
import 'package:eatwat/screens/food/order_list.dart';
import 'package:eatwat/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class OrderScreen extends StatefulWidget {
  String get foodStoreId => null;

  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Order>>.value(
      value: DatabaseService().orders,
          child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red[200],
          title: Text('My Orders', style: TextStyle(fontFamily: 'Raleway', fontSize: 20)),
          centerTitle: true,
        ),
        body: Column(children: <Widget>[
          Expanded(
            child: SizedBox(
            height: 200.0,
            child: OrderList())),
        ],)
      ),
    );
  }
}