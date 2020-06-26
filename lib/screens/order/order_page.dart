import 'package:flutter/material.dart';
import 'package:eatwat/screens/order/order_card.dart';

class OrderPage extends StatefulWidget {
  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Food Cart", style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: Colors.blue,
        elevation: 0.0,
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        scrollDirection: Axis.vertical,
        children: <Widget>[
          OrderCard(),
          OrderCard(),
          OrderCard(),
          OrderCard(),
          OrderCard(),
          OrderCard(),
        ],
      ),
      bottomNavigationBar: _buildTotalContainer(),
    ); 
  }
  
  Widget _buildTotalContainer(){
    return Container(
      height: 140.0,
      margin: EdgeInsets.only(top: 20.0),
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        children: <Widget>[
          ListTile(
            leading: Text(
              "Sub Total",
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Colors.grey
              ),),
            trailing: Text(
              "23.0",
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Colors.black
              ),),
          ),
    
          SizedBox(),
          
          Container(
            width: MediaQuery.of(context).size.width,
            height: 50.0,
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(30.0)
            ),
            child: Center(
              child: Text(
                "Comfirm Order",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                ),
                )
            )
          ),
        ],
      )
    );
  }
}