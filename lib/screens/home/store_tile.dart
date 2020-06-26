import 'package:eatwat/models/Store_model.dart';
import 'package:flutter/material.dart';
import 'package:eatwat/screens/food/food.dart';

class StoreTile extends StatelessWidget {

  final Store store;
  StoreTile({ this.store });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 0.0),
        child: ListTile(
          leading: Image.network(store.image,
            width: 100,
            fit: BoxFit.fitWidth,
          ),
          title: Text(store.name),
          subtitle: Text('Location: ${store.location}\nCategory: ${store.category}' ),
          isThreeLine: true,
          onTap: () async {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => FoodScreen(id: store.id, name: store.name)));
                        },
        ),
      ),
    );
  }
}