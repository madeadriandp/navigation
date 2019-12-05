import 'package:dio/dio.dart';

class Todo {
  final String name;
  final String address;
   bool favorite=false;
  final int id;
  final String imagepath;

   
  // Todo(this.title, this.description);

  Todo(this.name, this.address, this.favorite, this.id, this.imagepath);

  Todo.fromJson(Map<String, dynamic> response)

    : name = response['name'],
      address = response['address'],
      favorite =response['favorite'],
      id =response['id'],
      imagepath = response['image_url'];

  static getTodos() async{
    var response =
    await Dio().get("https://address-book-exp-api.herokuapp.com/users");

    List<Todo> todos = (response.data['data']as List)
      .map((item) =>Todo.fromJson(item))
      .toList();
      
  return todos; }

  static postTodos(data) async {
    var response = await Dio()
    .post("https://address-book-exp-api.herokuapp.com/users", data: await data);

    return response;
  }

  static editTodo(data,id) async{
    var response = await Dio().patch(
      "https://address-book-exp-api.herokuapp.com/users/$id",
      data:data,
    );
    return response;
    }

  static deleteTodo(id) async{
    var response = await Dio()
    .delete("https://address-book-exp-api.herokuapp.com/users/$id");
    return response;
  }

  }


