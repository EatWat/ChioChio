// responsible for cycling through the foodcourt list and output them

import 'package:eatwat/models/Store_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:eatwat/screens/home/store_tile.dart';

class StoreList extends StatefulWidget {
  @override
  _StoreListState createState() => _StoreListState();
}

class _StoreListState extends State<StoreList> {
  @override
  Widget build(BuildContext context) {
    // access the data from the stream, return a list
    final stores = Provider.of<List<Store>>(context);
    
    // use listview to output all items in the list
    return ListView.builder(
      itemCount: stores?.length ?? 0,
      itemBuilder: (context, index) {
        // a new widget for each individual item
        return StoreTile(store: stores[index]);
      },
    );
  }
}