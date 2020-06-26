import 'package:flutter/material.dart';
import 'package:eatwat/screens/food/food_list.dart';
import 'package:eatwat/services/database.dart';
import 'package:provider/provider.dart';
import 'package:eatwat/models/food_model.dart';
import 'package:eatwat/screens/food/checkoutScreen.dart';

class FoodScreen extends StatefulWidget {

  final String id, name;
  FoodScreen({this.id, this.name});

  @override
  _FoodScreenState createState() => _FoodScreenState();
}

class _FoodScreenState extends State<FoodScreen> {
  List<Food> cart = [];
  double sum = 0;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: (){
          return showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Are you sure to exit this store?'),
              content: Text('The items in your cart may be cleared.'),
              actions: <Widget>[
                FlatButton(
                  color: Colors.blue,
                  onPressed: () {Navigator.of(context).pop(true);}, 
                  child: Text('Yes')),
                FlatButton(
                  //color: Colors.blue,
                  onPressed: () {Navigator.of(context).pop(false);}, 
                  child: Text('No')),
              ],
            )
          );
        },
        child: DefaultTabController(
          length: 2,
          child: Scaffold(
          appBar: AppBar(
            title: Text('${widget.name}', style: TextStyle(fontFamily: 'Raleway', fontSize: 20)),
            bottom: TabBar(
                tabs: <Widget>[
                  Tab(child: Text( "All food",
                        style: TextStyle(fontFamily: 'Raleway', fontSize: 18))),
                  Tab(child: Text( "My cart",
                        style: TextStyle(fontFamily: 'Raleway', fontSize: 18))),
                ],
              ),
            ),
          body: StreamProvider<List<Food>>.value(
            value: DatabaseService().food,
            child: //TabControl(id: widget.id)),
              TabBarView(
              children: <Widget>[ 
                FoodList((selectedProduct){//嗯嗯😊
                  setState(() {//???????????????
                    bool unique = true;
                    cart.forEach((element){
                      if (selectedProduct.name == element.name){
                        unique = false;
                      } 
                    });
                    if (unique) {
                      cart.add(selectedProduct);}
                    sum = 0;    
                    cart.forEach((item){
                      sum = sum + item.price;
                    });
                  });
                }, widget.id),
                CheckoutScreen(cart, sum),
              ],
            ),
          )
        ),
      ),
    );
  }
}