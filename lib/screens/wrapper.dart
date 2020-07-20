import 'package:eatwat/models/user.dart';
import 'package:eatwat/screens/authenticate/authenticate.dart';
import 'package:eatwat/screens/food/order.dart';
import 'package:eatwat/screens/home/account.dart';
import 'package:eatwat/screens/home/foodcourt.dart';
import 'package:eatwat/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatefulWidget {
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
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
    final user = Provider.of<User>(context);

    //return either Home or Authenticate widge
    //based on whether the user is signed in or not
    if (user == null) {
      return Authenticate();
    } else {
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
      );
    }
  }
}
