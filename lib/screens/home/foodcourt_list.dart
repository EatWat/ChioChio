// responsible for cycling through the foodcourt list and output them

import 'package:eatwat/models/foodcourt_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:eatwat/screens/home/foodcourt_tile.dart';

class FoodcourtList extends StatefulWidget {
  @override
  _FoodcourtListState createState() => _FoodcourtListState();
}

class _FoodcourtListState extends State<FoodcourtList> {
  @override
  Widget build(BuildContext context) {

    // access the data from the stream, return a list
    final foodcourts = Provider.of<List<Foodcourt>>(context);
    
    // use listview to output all items in the list
    return ListView.builder(
      itemCount: foodcourts?.length ?? 0,
      itemBuilder: (context, index) {
        // a new widget for each individual item
        return FoodcourtTile(foodcourt: foodcourts[index]);
      },
    );
  }
}