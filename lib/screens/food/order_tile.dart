import 'package:eatwat/models/Store_model.dart';
import 'package:eatwat/models/order_model.dart';
import 'package:eatwat/screens/food/status.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class OrderTile extends StatelessWidget {

  final Order order;
  OrderTile({ this.order });

  @override
  Widget build(BuildContext context) {
    // final allStore = Provider.of<List<Store>>(context);
    // var storename;
    // for (var i in allStore) {
      
    //     if ((i.foodCourtId) == (order.foodStoreId)) {
    //       storename = i.name;
    //     }
    //   }
    String storename;
    if(order.foodStoreName != null) {
      storename = order.foodStoreName;
    } else {
      storename = "order";
    }
     

    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
        child: ListTile(
          // leading: ,
          //   width: 100,
          //   fit: BoxFit.fitWidth,
          // ),
          title: Text(storename),
          subtitle: Text(order.time.toDate().toString()),
          // isThreeLine: true,
          // onTap: () async {
          //                 Navigator.push(context,
          //                     MaterialPageRoute(builder: (context) => Status()));
          //               },
        ),
      ),
    );
  }
}