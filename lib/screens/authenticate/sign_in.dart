import 'package:eatwat/screens/home/foodcourt.dart';
import 'package:eatwat/services/auth.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;

  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  // to use the method of auth class, _auth.method()
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  // text field state
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.amber[100],
      // appBar: AppBar(
      //   backgroundColor: Colors.red[200],
      //   //Color(0xFFFD7465), //0xFFFE8A7E
      //   elevation: 0.0,
      //   title: Text(
      //     'Sign in to EatWat',
      //   ),
      //   actions: <Widget>[

      //     FlatButton.icon(

      //       icon: Icon(
      //         Icons.person,
      //         color: Colors.white,
      //       ),

      //       label: Text('Register',
      //         style: TextStyle(
      //         color: Colors.white,
      //         ),
      //       ),
      //       onPressed: () {
      //         widget.toggleView();
      //       },
      //     )
      //   ],
      // ),
      body: Column(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                height: 80.0,
                //color: Color(0xFFF5CEB8),
                color: Colors.red[200],
              ),
              Row(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 28.0, left: 16.0),
                    child: Text(
                      'Sign in to EatWat',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.only(top: 28.0, left: 120.0),
                      child: FlatButton.icon(
                        icon: Icon(
                          Icons.person,
                          color: Colors.white,
                        ),
                        label: Text(
                          'Register',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        onPressed: () {
                          widget.toggleView();
                        },
                      ))
                ],
              )
            ],
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
            // sign in anonymously
            // child: RaisedButton(
            //   child: Text('Sign in anon'),
            //   onPressed: () async {
            //     // this variable can be either a null or a firebase user
            //     dynamic result = await _auth.signInAnon();
            //     if(result == null) {
            //       // print in the debug console
            //       print('error signing in');
            //     } else {
            //       // print in the debug console
            //       print('signed in');
            //       print(result.uid);
            //     }
            //   },
            // )

            // sign in using email authentication
            child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 20.0),
                    TextFormField(
                        decoration: InputDecoration(
                          hintText: 'Enter your Email:',
                        ),
                        validator: (val) =>
                            val.isEmpty ? 'Enter an email' : null,
                        onChanged: (val) {
                          setState(() => email = val);
                        }),
                    SizedBox(height: 20.0),
                    TextFormField(
                        decoration: InputDecoration(
                          hintText: 'Enter your Password:',
                        ),
                        obscureText: true,
                        validator: (val) => val.length < 6
                            ? 'Enter a password 6+ length long'
                            : null,
                        onChanged: (val) {
                          setState(() => password = val);
                        }),
                    SizedBox(height: 20.0),
                    RaisedButton(
                      color: Colors.red[200],
                      //Color(0xFFFD7465),
                      child: Text(
                        'Sign in',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          dynamic result = await _auth
                              .signInWithEmailAndPassword(email, password);
                          if (result == null) {
                            setState(() => error =
                                'Could not sign in witht those credentials');
                          } else {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => FoodcourtScreen()));
                          }
                        }
                      },
                    ),
                    SizedBox(height: 12.0),
                    Text(
                      error,
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 14.0,
                      ),
                    )
                  ],
                )),
          ),
        ],
      ),
    );
  }
}
