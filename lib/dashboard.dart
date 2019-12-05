import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:navigation/addscreen_cam.dart';
import 'package:navigation/editscreen.dart';
import 'package:navigation/model/to_do.dart';

import 'tododescription.dart';

class TodoScreen extends StatefulWidget {
  
  @override
  State<StatefulWidget> createState(){
    return TodoState();
  }
}

class _InputData{
  String description = "";
  int urutan;
}

_InputData data = _InputData();

class TodoState extends State<TodoScreen> {
  List<Todo> todos ;
  bool loading = true;
  bool checkall = false;
  String filtered ="total";

  void getTodos() async{
    var response =await Todo.getTodos();
    setState(() {
      todos=response;
      loading=false;
    });
  }


  @override
  void initState(){
    print('test');
    super.initState();
    getTodos();
  }

  Future<FormData> photo({path, name}) async {
    return FormData.fromMap({
      "name":name,
      "favorite": false,
      "photo": await MultipartFile.fromFile(path, filename:"user-photo")
    
    });
  }

  handleTodo(val, path) {
    Todo.postTodos(photo(path: path,  name: val));
    getTodos();
  }
  
  //Edit the name of a Todos
  editTodos(Todo todo, index) {
    Todo.editTodo({"name": todo.name}, todo.id);
    getTodos();  
  }

  removeWidget(Todo todo, index){
    Todo.deleteTodo(todo.id);
    // print(todo.id);
    todos.removeAt(index);
    // getTodos();
  }

  //Change the favorite status of a Todos
  clickCheckBox(Todo todo, check, index){
   Todo.editTodo({"favorite":check}, todo.id);
   getTodos();
  }

  handleCheckAll(value){
    for (var i = 0; i < todos.length; i++) {
      Todo.editTodo({'favorite' : value}, todos[i].id);
      todos[i].favorite = value;
    }
    setState(() {
      checkall = value;
    });
  }
  

  handleDeleteAll(){
    setState(() {
      //int total = kerjaan.length;
      for (int i = 0;i<todos.length;i++) {
        if(todos[i].favorite=true){
          Todo.deleteTodo(todos[i].id);
          //getTodos();
          i--;
        }
      }
      checkall = false;
    });
  }
  int numberChecked(){
    int jum = 0;
    setState(() {
      for (var item in todos){
        if(item.favorite){
          jum++;
        }
      }
      // for (int i=0; i<todos.length; i++){
      //   if(todos[i].favorite==true){
      //     jum++;
      //   }
      // }
    });
    return jum;
  }


  @override
  Widget build(BuildContext context) {
    // 
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.yellowAccent[900],
          title: Text('To dos'),
        ),
        body: loading
        ? Text('loading')
            :Column(children: <Widget>[
            Container(
              height: 120,
              width: MediaQuery.of(context).size.width,
              child: (loading
              ? CircularProgressIndicator()
              : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Box(
                        name: 'Done',
                        color:  Colors.green[700],
                        number: numberChecked(),
                        icon: Icon(Icons.check_box_outline_blank)

                      ),

                      Box(
                        name: 'To dos',
                        color: Colors.orange,
                        number: todos.length-numberChecked(),
                        icon: Icon(Icons.airline_seat_recline_normal),

                      ),

                      Box(
                        name: 'Total',
                        color: Colors.blueGrey,
                        number: todos.length,
                        icon: Icon(Icons.assessment)
                      ),
                      
                    ],
                  ))
              ),
         
          Container(
            margin: const EdgeInsets.all(20),
            child: 
            todos.length==0
            ? Text("ADD MORE TODOS!")
            :
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  child: 
                  Column(
                    children: <Widget>[
                      Text("Check All"),
                    Checkbox(
                      value:checkall,
                      onChanged: (val){
                       handleCheckAll(val); 
                      }
                    ),

              ],
            ),
          ),

          Container(
                  child: 
                  Column(
                    children: <Widget>[
                      Text("Delete Checked"),
                      RaisedButton.icon(
                        elevation: 0,
                        label: Card(

                        ),
                        color: Colors.transparent,
                        icon: Icon(Icons.delete_outline),
                        onPressed: (){
                          handleDeleteAll();
                        },
                      )
              ],
            ),
          ),
              ])),



          Expanded(
            // width: MediaQuery.of(context).size.width,
            // height: MediaQuery.of(context).size.height*0.57,
            child: (
            ListView.builder(
            itemCount: todos.length,
            itemBuilder: (context, index) {
              return Dismissible(
                  key: UniqueKey(),
                  onDismissed: (direction) {
                    removeWidget(todos[index], index);
              

                    //Show a snackbar
                    Scaffold.of(context).showSnackBar(
                        SnackBar(content: Text("${todos[index].name} deleted"), backgroundColor: Colors.red,));
                  },

                  //show a red background as the item is swiped away
                  background: Container(color: Colors.red),
                  child: Card(
                    child: ListTile(
                      leading: todos[index].imagepath == null
                      ? Icon(Icons.casino)
                      : CircleAvatar(child: Image.network(todos[index].imagepath), backgroundColor: Colors.transparent,),
                      trailing: Checkbox(
                        value: todos[index].favorite,
                        onChanged: (favorite) {
                          clickCheckBox(todos[index], favorite, index);
                          if(favorite ==false){
                            checkall=false;
                          }
                          int temp=0;
                          for(var i=0; i<todos.length; i++){
                            if(todos[i].favorite==true){
                              temp++;
                            }
                          }
                          if(temp == todos.length){
                            checkall=true;
                          }
                        },
                      ),
                      title: 
                      Text(todos[index].name, 
                      style: todos[index].favorite
                      ? TextStyle(decoration: TextDecoration.lineThrough,color: Colors.blue[900])
                      : TextStyle(decoration: TextDecoration.none,color: Colors.black)
                      ),
                       
                      onLongPress: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  DetailScreen(
                                    todo: todos[index]),
                            ));
                      },

                      onTap:(){
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                             EditScreen(
                               todos:todos[index],
                               index: index,
                               editTodo: editTodos,
                             )
                          ),);
                      } ,
                    ),
                  ));
            },
          )
          )),]),
          
          floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.teal,
            child: Icon(
              Icons.add_circle_outline,
              size: 45,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddScreenCam(handleTodo),
                ),
              );
            },
          ),
        );
  }
}

class Box extends StatelessWidget{

  final String name;
  final Icon icon;
  final int number;
  final Color color;

const Box({Key key, @required this.name, @required this. icon, 
@required this.number, @required this.color}) : super(key:key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      height: MediaQuery.of(context).size.height*2/10,
      child: Material(
        elevation: 10.0,
        child: (
          Column(
            children: <Widget>[
              Text(name,style: TextStyle(color: color, fontSize: 35, fontStyle: FontStyle.italic),),
              Icon(icon.icon, size: 35, color: color,),
              Text(number.toString(), style:TextStyle(color:color, fontSize: 35, fontStyle: FontStyle.italic)),
            ],
          )
        ),
      )
    );
  }

}