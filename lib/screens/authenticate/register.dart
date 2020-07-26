import 'package:eatwat/screens/home/foodcourt.dart';
import 'package:eatwat/screens/wrapper.dart';
import 'package:eatwat/services/auth.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  final Function toggleView;

  Register({this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
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
      //   title: Text('Sign up to EatWat'),
      //   actions: <Widget>[
      //     FlatButton.icon(
      //       icon: Icon(
      //         Icons.person,
      //         color: Colors.white,
      //       ),

      //       label: Text('Sign In',
      //         style: TextStyle(
      //           color: Colors.white,
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
                          'Sign In',
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
            child: Form(
                // this key can be used to validate the form
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 20.0),
                    TextFormField(
                        decoration: InputDecoration(
                          hintText: 'Enter your Email',
                        ),
                        // check if this form view is valid (non-empty)
                        validator: (val) =>
                            val.isEmpty ? 'Enter an email' : null,
                        onChanged: (val) {
                          setState(() => email = val);
                        }),
                    SizedBox(height: 20.0),
                    TextFormField(
                        decoration: InputDecoration(
                          hintText: 'Enter your Password',
                        ),
                        obscureText: true,
                        // check if this form view is valid (length longer than 6 characters)
                        validator: (val) => val.length < 6
                            ? 'Enter a password 6+ length long'
                            : null,
                        onChanged: (val) {
                          setState(() => password = val);
                        }),
                    SizedBox(height: 20.0),
                    RaisedButton(
                      //color: Color(0xFFFD7465),
                      color: Colors.red[200],
                      child: Text(
                        'Register',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () async {
                        // check if we have a valid form
                        if (_formKey.currentState.validate()) {
                          dynamic result = await _auth
                              .registerWithEmailAndPassword(email, password);
                          if (result == null) {
                            setState(
                                () => error = 'please supply a valid email');
                          } else {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Wrapper()));
                          }
                        }
                      },
                    ),
                    SizedBox(height: 12.0),
                    Text(
                      error,
                      style: TextStyle(color: Colors.red, fontSize: 14.0),
                    )
                  ],
                )),
          ),
        ],
      ),
    );
  }
}
