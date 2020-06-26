import 'package:eatwat/models/user.dart';
import 'package:eatwat/screens/authenticate/authenticate.dart';
import 'package:eatwat/screens/home/foodcourt.dart';
import 'package:eatwat/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    //return either Home or Authenticate widge
    //based on whether the user is signed in or not
    if (user == null) {
      return Authenticate();
    } else {
      return FoodcourtScreen();
    }
  }
}
