import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:eatwat/services/database.dart';
import 'package:provider/provider.dart';
import 'package:eatwat/screens/home/store_list.dart';
import 'package:eatwat/models/Store_model.dart';


class StoreScreen extends StatefulWidget {
  final String id;
  StoreScreen({this.id});
  @override
  _StoreScreen createState() => _StoreScreen();
}

class _StoreScreen extends State<StoreScreen> {
  
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Store>>.value(
        value: DatabaseService().stores, 
        child: Scaffold(
          body: StoreList(id: widget.id)),
    );
  }
}