import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:eatwat/services/database.dart';
import 'package:eatwat/screens/home/foodcourt.dart';
import 'package:eatwat/screens/home/store.dart';

class Status extends StatefulWidget {
  @override
  _StatusState createState() => _StatusState();
}

class _StatusState extends State<Status> {

    int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0: Home',
      style: optionStyle,
    ),
    Text(
      'Index 1: Order',
      style: optionStyle,
    ),
    Text(
      'Index 2: Account',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List>.value(
        value: DatabaseService().foodcourts,
        child: Scaffold(
        body: Column(
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
                    child: Text(
                      "Waiting for vendor to accept your order...",
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
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text('Home'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart),
              title: Text('Order'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle),
              title: Text('Account'),
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.red[300],
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}