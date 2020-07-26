import 'package:eatwat/models/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class Account extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red[200],
        title: Text('My Account', style: TextStyle(fontFamily: 'Raleway', fontSize: 20)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(30.0, 40.0, 30.0, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(
              child: CircleAvatar(
                radius: 40.0,
                backgroundImage: AssetImage('assets/happy.png'),
              ),
            ),
            Divider(
              color: Colors.grey[800],
              height: 60.0,
            ),
         
            SizedBox(height: 30.0),
            Row(
              children: <Widget>[
                Icon(
                  Icons.email,
                  color: Colors.grey[800],
                ),
                SizedBox(width: 10.0),
                Text(
                  '${user.email}',
                  style: TextStyle(
                    color: Colors.grey[800],
                    fontSize: 18.0,
                    letterSpacing: 1.0,
                  ),
                )
              ],
            ),
          ],
        ),
      )
      
    );
  }
}
