import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart'show join; 
import 'package:path_provider/path_provider.dart';

class TakePictureScreen extends StatefulWidget{
  final CameraDescription camera;

  const TakePictureScreen({
    Key key,
    @required this.camera,

  }) :super(key:key);
  
@override
TakePictureScreenState createState() => TakePictureScreenState();

}

class TakePictureScreenState extends State<TakePictureScreen>{
  CameraController _controller;
  Future<void> _initializeControllerFuture;

  @override
  void initState(){
    super.initState();

    _controller = CameraController(
      widget.camera,

      ResolutionPreset.medium,
    );

    _initializeControllerFuture = _controller.initialize();

  }

  @override
  void dispose(){
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Prendre une photo")),

      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot){
          if(snapshot.connectionState ==  ConnectionState.done){
            return CameraPreview(_controller);
          }else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),

      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.camera),
        onPressed: ()async{
          try{
            await _initializeControllerFuture;
            final path = join(
              (await getTemporaryDirectory()).path,
              '${DateTime.now()}.png'
            );

            await _controller.takePicture(path);
            
            Navigator.pop(context, path);
          } catch(e){
            print(e);
          }
        }),
    );
  }
  
}
