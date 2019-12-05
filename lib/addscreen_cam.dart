import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:navigation/pages.dart';

class AddScreenCam extends StatefulWidget{
  final handleTodo;

  const AddScreenCam(this.handleTodo);
  
  @override
  AddScreenState createState() => AddScreenState(handleTodo);
}

class AddScreenState extends State<AddScreenCam>{
  final handleTodo;

  AddScreenState (this.handleTodo);

  CameraDescription firstCamera;
  String path;

  final descriptionController = TextEditingController();

  @override
  void initState(){
    super.initState();
    getCamera();
  }

  getCamera() async{
    final cameras = await availableCameras();
    setState(() {
      firstCamera=cameras.first;
    });
  }

  navigateAndGetPhoto() async{
    final result= await Navigator.pushNamed(context, Pages.Camera,
    arguments: {"camera": firstCamera});


    setState(() {
      path=result;
    });
  }

@override
Widget build(BuildContext context){
  return Scaffold(
    appBar: AppBar(
      title: Text("Add Todo(s)"),
    ),
    body: Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(10),
          child: TextField(
            controller: descriptionController,
            autofocus: true,
            decoration: InputDecoration(
              hintText: "Add To Do", labelText: "Add New To Do"
            ),
          ),
        ),

        Container(
          child: path != null
          ? Image.file(File(path))
          : IconButton(
              icon: Icon(Icons.camera),
              onPressed: navigateAndGetPhoto,
          )
        ),
        RaisedButton(
          onPressed: (){
            handleTodo(descriptionController.text, path);
            Navigator.pop(context);
          },
          child: Text("Add Todo User"),
        )
      ],
    ),
  );
}
}