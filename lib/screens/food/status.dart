import 'package:eatwat/models/foodcourt_model.dart';
import 'package:eatwat/screens/food/order.dart';
import 'package:eatwat/screens/home/account.dart';
import 'package:eatwat/screens/home/foodcourt.dart';
import 'package:eatwat/screens/home/store.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eatwat/screens/food/review.dart';

class Status extends StatefulWidget {
  String orderId;
  Status(this.orderId);

  @override
  _StatusState createState() => _StatusState();
}

class _StatusState extends State<Status> {

  bool reviewFlag = false;
  var reviews;

  @override
  void initState(){
    super.initState();

   }



  @override
  Widget build(BuildContext context) {
    String id = widget.orderId.toString();
    print(id);
    print('aaaaaaaaaaa');
     return Scaffold(
    body: StreamBuilder(
      stream: Firestore.instance.collection('Order').document(id).snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return Text('Loading data.. Please wait..');
      
      return Column(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                height: 200.0,
                //color: Color(0xFFF5CEB8),
                color: Colors.red[200],
              ),
              Padding(
                padding: EdgeInsets.only(top: 60.0, left: 35.0),
                child: Text(
                  "Status : ",
                  style: TextStyle(
                      fontSize: 28.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 113.0, left: 70.0, right: 70.0),
                child: Center(
                  child: Text((() {
                    //print(widget.orderId);
                    int status = snapshot.data['status'];
                    //print(status);
                    String st = '';
                    if (status == 1) {
                      st = 'Waiting for the vendor to accept your order...';
                    } else if (status == 2) {
                      st = 'Your order has been accepted.';
                    } else if (status == 3 ) {
                      st = 'Your order has been Rejected. We are sorry :(';
                    } else if (status == 4) {
                      st = 'Your food is ready. Please collected it asap.';
                    } else if (status == 5) {
                      st = 'Your food has been collected. Enjoy your meal :)';
                    }
                    return st;
                  })(),
                    style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
          
        ]
      );
      }
    ),
      );
   }

  
}