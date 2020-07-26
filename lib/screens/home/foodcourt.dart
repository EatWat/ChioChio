import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:eatwat/services/database.dart';
import 'package:provider/provider.dart';
import 'package:eatwat/screens/home/foodcourt_list.dart';
import 'package:eatwat/models/foodcourt_model.dart';

class FoodcourtScreen extends StatefulWidget {
  @override
  _FoodcourtScreen createState() => _FoodcourtScreen();
}

class _FoodcourtScreen extends State<FoodcourtScreen> {

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Foodcourt>>.value(
        value: DatabaseService().foodcourts,
        child: FoodcourtList(),
    );
  }
}
