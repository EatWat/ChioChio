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
      padding: const EdgeInsets.only(top: 20.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
        child: ListTile(
          
          // leading: ,
          //   width: 100,
          //   fit: BoxFit.fitWidth,
          // ),
          
          title: Text(storename),
          subtitle: //Text(order.time.toDate().toString()),
          Text((() {
                    //print(widget.orderId);
                    int status = order.status;
                    //print(status);
                    String st = ' ' + "\n";
                    if (status == 1) {
                      st += 'Waiting for the vendor to accept your order...';
                    } else if (status == 2) {
                      st += 'Your order has been accepted.';
                    } else if (status == 3 ) {
                      st += 'Your order has been Rejected. We are sorry :(';
                    } else if (status == 4) {
                      st += 'Your food is ready. Please collected it asap.';
                    } else if (status == 5) {
                      st += 'Your food has been collected. This order is closed.';
                    }
                    st = st + '\n\n' + order.time.toDate().toString();
                    return st;
                  })(),
          ),
          // isThreeLine: true,
          onTap: () async {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => Status(order.documentID)));
                        },
        ),
      ),
    );
  }
}