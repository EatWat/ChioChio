import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:eatwat/services/database.dart';
import 'package:provider/provider.dart';
import 'package:eatwat/screens/home/store_list.dart';
import 'package:eatwat/models/Store_model.dart';

class NewStoreScreen extends StatefulWidget {
    final String id;
    final String name;
  NewStoreScreen({this.id,this.name});
  @override
  _NewStoreScreenState createState() => _NewStoreScreenState();
}

class _NewStoreScreenState extends State<NewStoreScreen> {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Store>>.value(
        value: DatabaseService().stores, 
        child: Scaffold(
          appBar: AppBar(
        title: Text("${widget.name}", style: TextStyle(color: Colors.white)),
        //centerTitle: true,
        backgroundColor: Colors.red[200],
        elevation: 0.0,
      ),
          backgroundColor: Colors.white,
          body: StoreList(id: widget.id)),
    );
  }
}