import 'package:eatwat/screens/authenticate/sign_in.dart';
import 'package:eatwat/screens/home/store.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:eatwat/services/auth.dart';
import 'package:eatwat/services/database.dart';
import 'package:provider/provider.dart';
import 'package:eatwat/screens/home/foodcourt_list.dart';
import 'package:eatwat/models/foodcourt_model.dart';

class FoodcourtScreen extends StatefulWidget {
  @override
  _FoodcourtScreen createState() => _FoodcourtScreen();
}

class _FoodcourtScreen extends State<FoodcourtScreen> {
  // int _selectedIndex = 0;
  // static const TextStyle optionStyle =
  //     TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  // static const List<Widget> _widgetOptions = <Widget>[
  //   Text(
  //     'Index 0: Home',
  //     style: optionStyle,
  //   ),
  //   Text(
  //     'Index 1: Order',
  //     style: optionStyle,
  //   ),
  //   Text(
  //     'Index 2: Account',
  //     style: optionStyle,
  //   ),
  // ];

  // void _onItemTapped(int index) {
  //   setState(() {
  //     _selectedIndex = index;
  //   });
  // }

  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Foodcourt>>.value(
        value: DatabaseService().foodcourts,
        child: Scaffold(
        body: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                  height: 160.0,
                  //color: Color(0xFFF5CEB8),
                  color: Colors.red[200],
                ),
                Row(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 40.0, left: 15.0),
                      child: Text(
                        "EatWat",
                        style: TextStyle(
                            fontSize: 30.0,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 40.0, left: 180.0),
                      child: FlatButton.icon(
                        icon: Icon(
                          Icons.person,
                          color: Colors.white,
                        ),
                        label: Text(
                          'logout',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        onPressed: () async {
                          await _auth.signOut();
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => SignIn()));
                        },
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(top: 90.0, left: 17.0, right: 17.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(top: 14.0),
                        hintText: 'Search for yout favorite',
                        hintStyle: TextStyle(fontSize: 14.0),
                        prefixIcon: Icon(Icons.search, color: Colors.grey),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            ButtonBar(
              alignment: MainAxisAlignment.start,
              children: <Widget>[
                FlatButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => FoodcourtScreen()));
                    },
                    child: Text(
                      "  Foodcourt",
                      style: TextStyle(
                          fontSize: 19.0,
                          color: Colors.red[300],
                          fontWeight: FontWeight.bold),
                    )),
                FlatButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => StoreScreen()));
                    },
                    child: Text(
                      "Store",
                      style: TextStyle(
                          fontSize: 19.0,
                          color: Colors.red[300],
                          fontWeight: FontWeight.bold),
                    )),
              ],
            ),
            Expanded(
              child: SizedBox(
                height: 200.0,
                child: FoodcourtList())),
          ],
        ),
        // bottomNavigationBar: BottomNavigationBar(
        //   items: const <BottomNavigationBarItem>[
        //     BottomNavigationBarItem(
        //       icon: Icon(Icons.home),
        //       title: Text('Home'),
        //     ),
        //     BottomNavigationBarItem(
        //       icon: Icon(Icons.shopping_cart),
        //       title: Text('Order'),
        //     ),
        //     BottomNavigationBarItem(
        //       icon: Icon(Icons.account_circle),
        //       title: Text('Account'),
        //     ),
        //   ],
        //   currentIndex: _selectedIndex,
        //   selectedItemColor: Colors.red[300],
        //   onTap: _onItemTapped,
        // ),
      ),
    );
  }
}
