
import 'package:flutter/material.dart';
import 'package:navigation/dashboard.dart';
import 'package:navigation/editscreen.dart';
import 'package:navigation/pages.dart';
import 'package:navigation/tododescription.dart';

import 'addscreen_cam.dart';
import 'camera.dart';
import 'login.dart';

class Router{
  Route<dynamic> getRoute(settings){
    Map<String, dynamic> arguments = settings.arguments;

    switch (settings.name) {
      case Pages.Home :
        return _buildRoute(settings, LoginPage());
      case (Pages.List):
        return _buildRoute(settings, TodoScreen());
      case Pages.Add :
        return _buildRoute(settings, AddScreenCam(arguments['handleToDo']));
      case Pages.Edit :
        return _buildRoute(
          settings, 
          EditScreen(
            todos: arguments['todos'],
            index: arguments['index'],
            editTodo: arguments['editTodo'],
          )
        );
      case Pages.Detail :
        return _buildRoute(
          settings, 
          DetailScreen(
            todo: arguments['todos'],
            index: arguments['index'],
            function: arguments['editTodo'],
          )
        );
      case Pages.Camera :
        return _buildRoute(
          settings, 
          TakePictureScreen(camera: arguments['camera'],)
          );
      default:
        return null;
    }
  }
}

MaterialPageRoute _buildRoute(RouteSettings settings, Widget builder){
  return MaterialPageRoute(
    builder: (ctx) => builder,
    settings: settings,
  );
}
