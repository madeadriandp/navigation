import 'package:flutter/material.dart';
import 'package:navigation/dashboard.dart';
import 'package:navigation/login.dart';
import 'package:validate/validate.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: 'Forms in Flutter',
      initialRoute: '/dashboard',
      routes: {  
        "/":(context) => LoginPage(),
        "/dashboard": (context) => TodoScreen(),
      },
    );
  }

}