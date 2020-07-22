import 'package:eatwat/screens/food/order.dart';
import 'package:eatwat/screens/home/account.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:eatwat/services/auth.dart';

import 'foodcourt.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  int _currentIndex = 0;
    final List<Widget> _children = [
      FoodcourtScreen(),
      Order(),
      Account(),

    ];

  void onTappedBar(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_currentIndex],
    bottomNavigationBar: BottomNavigationBar(
      onTap: onTappedBar,
      currentIndex: _currentIndex,
      items: [
        BottomNavigationBarItem(
          icon: new Icon(Icons.home),
          title: new Text('Home'),

        ),
        BottomNavigationBarItem(
          icon: new Icon(Icons.shopping_cart),
          title: new Text('Order'),
        ),
        BottomNavigationBarItem(
          icon: new Icon(Icons.account_circle),
          title: new Text('Account'),
        ),
      ],
      
      selectedItemColor: Colors.red[300],
      
    ),
      //home: FoodcourtScreen(),
    );
  }
}
