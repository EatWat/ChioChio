import 'package:eatwat/models/user.dart';
import 'package:eatwat/screens/wrapper.dart';
import 'package:eatwat/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  // wrap this widget with the privider that provides user data through the stream
  // to all the widget beneath this widget, including Wrapper()
  Widget build(BuildContext context) {
    // StreamProvider<User> this stream is actively listening for authentication events
    return StreamProvider<User>.value(
      value: AuthService().user, // Stream<User> get user in auth.dart
      child: MaterialApp(
        theme: ThemeData(fontFamily: 'Raleway'),
        home: Wrapper(),
      ),
    );
  }
}
