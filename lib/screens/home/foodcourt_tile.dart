import 'package:eatwat/models/foodcourt_model.dart';
import 'package:eatwat/screens/home/newStore.dart';
import 'package:flutter/material.dart';

class FoodcourtTile extends StatelessWidget {

  final Foodcourt foodcourt;
  FoodcourtTile({ this.foodcourt });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
        child: ListTile(
          onTap: () async {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => NewStoreScreen(id: foodcourt.id, name: foodcourt.name)));
                        },
          leading: Image.network(foodcourt.image,
            width: 100,
            fit: BoxFit.fitWidth,
          ),
          title: Text(foodcourt.name),
          subtitle: Text('Location: ${foodcourt.location}' ),
          isThreeLine: true,
        ),
      ),
    );
  }
}