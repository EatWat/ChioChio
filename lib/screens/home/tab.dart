import 'package:eatwat/screens/authenticate/sign_in.dart';
import 'package:eatwat/screens/home/store.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:eatwat/services/auth.dart';
import 'package:eatwat/screens/home/foodcourt.dart';

import '../authenticate/authenticate.dart';

class TabPage extends StatefulWidget {
  @override
  _TabPage createState() => _TabPage();
}

class _TabPage extends State<TabPage> with SingleTickerProviderStateMixin {
  TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(vsync: this, length: 2);
  }

  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                    padding: EdgeInsets.only(top: 40.0),
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
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Authenticate()));
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
          Padding(
            padding: EdgeInsets.only(top: 13.0, right: 160),
            child: TabBar(
              controller: tabController,
              indicatorColor: Colors.transparent,
              labelColor: Colors.red[300],
              unselectedLabelColor: Colors.grey.withOpacity(0.6),
              isScrollable: true,
              tabs: <Widget>[
                Tab(
                  child: Text(
                    'Foodcourts',
                    style: TextStyle(
                      fontSize: 22.0,
                      fontFamily: 'Raleway',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Tab(
                  child: Text(
                    'Stores',
                    style: TextStyle(
                      fontSize: 22.0,
                      fontFamily: 'Raleway',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: tabController,
              children: <Widget>[
                FoodcourtScreen(),
                StoreScreen(id: null),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
