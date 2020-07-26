import 'package:eatwat/models/order_model.dart';
import 'package:eatwat/screens/food/empty_order.dart';
import 'package:eatwat/screens/food/order_tile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderList extends StatefulWidget {
  @override
  _OrderListState createState() => _OrderListState();
}

class _OrderListState extends State<OrderList> {
  Future<String> getEmail() async {
    final FirebaseUser user = await FirebaseAuth.instance.currentUser();
    return user.email;
  }

  @override
  Widget build(BuildContext context) {
    // access the data from the stream, return a list
    final orders = Provider.of<List<Order>>(context);
    var myOrder = [];
    // if (orders != null)
    //   orders.toList().sort((a, b) {
    //     return a.time.compareTo(b.time);
    //   });

    getEmail().then((u) => {
          orders.forEach((e) {
            if (e.userId == u) {
              myOrder.add(e);
              print(myOrder.isNotEmpty);
            }
          })
        });

    // use listview to output all items in the list
    return ListView.builder(
      itemCount: orders?.length ?? 0,
      itemBuilder: (context, index) {
        // a new widget for each individual item
        if (myOrder.isNotEmpty) {
          return OrderTile(order: myOrder[index]);
        } else {
          print("empty");
          return Empty();
        }
      },
    );
  }
}
