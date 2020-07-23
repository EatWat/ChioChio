import 'package:eatwat/models/food_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FoodList extends StatefulWidget {
  final ValueSetter<Food> _valueSetter;
  final String id;

  FoodList(this._valueSetter, this.id); 

  @override
  _FoodListState createState() => _FoodListState();
}

class _FoodListState extends State<FoodList> {
  @override
  Widget build(BuildContext context) {

    final String storeId = widget.id;
    final ValueSetter<Food> valueSetter = widget._valueSetter;
    final allFood = Provider.of<List<Food>>(context);
    final food = [];

    if (allFood != null){
      for (var i in allFood) {
        if ((i.id) == (storeId) && i.availability) {
          food.add(i);
        }
      }
    }
    
    // use listview to output all items in the list
    return Scaffold(
        body: ListView.builder(
        itemCount: food?.length ?? 0,
        itemBuilder: (context, index) {
        return Padding(
        padding: const EdgeInsets.only(top: 20.0),
        child: Card(
          margin: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 0.0),
          child: ListTile(
            leading: Image.network(food[index].image,
              width: 100,
              fit: BoxFit.fitWidth,
            ),
            title: Text(food[index].name),
            subtitle: Text('Price: ${food[index].price}\n${food[index].des}'),
            isThreeLine: true,
            onTap: (){
              valueSetter(food[index]);
              },
            ),
          ),
        );
      },
     ),
    );
  }
}