import 'package:eatwat/screens/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
                      st = 'Your food has been collected. This order is closed.';
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
          SingleChildScrollView(
            child: Stack(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 60.0, left: 35.0),
                  child: Text(
                    "Order Summary : ",
                    style: TextStyle(
                        fontSize: 28.0,
                        color: Colors.grey[800],
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 113.0, left: 70.0, right: 70.0),

                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text('Dish ',style: TextStyle(
                              fontSize: 20.0,
                              color: Colors.grey[800],
                              fontWeight: FontWeight.bold,
                              )
                          ),
                          Text('Qty',style: TextStyle(
                              fontSize: 20.0,
                              color: Colors.grey[800],
                              fontWeight: FontWeight.bold
                              )
                          ),
                        ],
                      ), 
                      Divider(
                              color: Colors.grey[800]
                          ), 
                      // Text('  ',style: TextStyle(
                      //         fontSize: 20.0,
                      //         color: Colors.grey[800],
                      //         //fontWeight: FontWeight.bold
                      //         )),
                      for(var item in snapshot.data['dishes'] ) 
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(item['name'].toString(),style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.grey[800],)),
                            Text(item['quantity'].toString(),style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.grey[800],)),
                          ],
                        ),
                      Divider(
                              color: Colors.grey[800]
                          ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text('Total price: ',style: TextStyle(
                              fontSize: 20.0,
                              color: Colors.grey[800],
                              fontWeight: FontWeight.bold)
                          ),
                          Text("\$"+snapshot.data['totalPrice'].toStringAsFixed(2),style: TextStyle(
                              fontSize: 20.0,
                              color: Colors.grey[800],
                              fontWeight: FontWeight.bold)
                          ),
                        ],
                      ),  
                    ],
                  )
                ),
              ],
            ),
          ),
        ]
      );
  }
    ),
    floatingActionButton: RaisedButton(
        onPressed: () async {
               Navigator.push(context,
                           MaterialPageRoute(builder: (context) => Wrapper()));
               },
        textColor: Colors.white,
        padding: const EdgeInsets.all(0.0),
        child: Container(
              decoration: const BoxDecoration(
                color: Color(0xFFEF9A9A),
              ),
              padding: const EdgeInsets.all(15.0),
              child:
                  const Text('Back to home', style: TextStyle(fontSize: 21),),
            ),
      ),
      );
   }

  
}