import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:eatwat/services/auth.dart';

import 'foodcourt.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FoodcourtScreen(),
    );
  }
}
