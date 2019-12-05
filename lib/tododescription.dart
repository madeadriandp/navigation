import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:navigation/model/to_do.dart';

class DetailScreen extends StatelessWidget{
  final Todo todo;
  final function;
  final index;

  DetailScreen({Key key, @required this.todo, this.function, this.index}) : super(key:key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.teal,
        title: Text(todo.name),
      ),
      body: Padding(
        padding: EdgeInsets.all(10.0),
        child: Text("Description of ${todo.name}"),
      ),
    );
  }

  
}