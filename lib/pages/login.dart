import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          width: double.maxFinite,
          height: double.maxFinite,
          child: Row(
            children: <Widget>[
              Expanded(
                  flex: 2,
                  child:Container(
                    color: Colors.white,
                    child: Column(),
                  )
              ),
              Expanded(
                  flex: 1,
                  child: Container(
                    color: Colors.red,
                    child: Column(),
                  )
              )
            ],
          )),
    );
  }
}
