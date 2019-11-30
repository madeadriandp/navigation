import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:navigation/model/to_do.dart';

class DetailScreen extends StatelessWidget{
  final Todo todo;

  DetailScreen({Key key, @required this.todo}) : super(key:key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.teal,
        title: Text(todo.title),
      ),
      body: Padding(
        padding: EdgeInsets.all(10.0),
        child: Text(todo.description),
      ),
    );
  }

  
}