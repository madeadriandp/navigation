import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:navigation/addtodo.dart';
import 'package:navigation/editscreen.dart';
import 'package:navigation/model/to_do.dart';

import 'tododescription.dart';

class TodoScreen extends StatefulWidget {
  TodoState createState() => TodoState();
}

class TodoState extends State<TodoScreen> {
  List<Todo> todos = List.generate(
      15,
      (i) => Todo('Todo ${i + 1}',
          "A description of what needs to be done for Todo ${i + 1}"));

  handleTodo(todo) {
    setState(() {
      todos.add(Todo('$todo ${todos.length + 1}',
          'A description of what needs to be done for $todo ${todos.length + 1}'));
    });
  }

  editTodo(todu, index) {
    setState(() {
      todos[index].title = todu.title;
          //'A description of what needs to be done for $todu ${todos.length + 1}');
    });
  }

  int numberChecked(){
    int jum = 0;
    setState(() {
      for (var item in todos){
        if(item.checkbox){
          jum++;
        }
      }
      // for (int i=0; i<todos.length; i++){
      //   if(todos[i].checkbox==true){
      //     jum++;
      //   }
      // }
    });
    return jum;
  }

  

  bool checkall = false;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.teal,
          title: Text('To dos'),
        ),
        body: 
            Column(children: <Widget>[
            Container(
              height: 120,
              width: MediaQuery.of(context).size.width,
              child: (
                  Row(
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
                      // Card(
                      //   child: Column(
                      //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      //     crossAxisAlignment: CrossAxisAlignment.center,
                      //     children: <Widget>[
                      //       Text("Done", style: TextStyle(fontSize: 40)),
                      //       Icon(Icons.check, size:37),
                      //       Text("12")
                      //     ],
                      //   ),
                      // ),
                      // Card(
                      //   child: Column(
                      //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      //     crossAxisAlignment: CrossAxisAlignment.center,
                      //     children: <Widget>[
                      //       Text("Todo", style: TextStyle(fontSize: 40)),
                      //       Icon(Icons.airline_seat_recline_normal, size:37),
                      //       Text("80")
                      //     ],
                      //   ),
                      // ),
                      // Card(
                      //   child: Column(
                      //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      //     crossAxisAlignment: CrossAxisAlignment.center,
                      //     children: <Widget>[
                      //       Text("Total", style: TextStyle(fontSize: 40)),
                      //       Icon(Icons.assessment, size:37),
                      //       Text("12")
                      //     ],
                      //   ),
                      // ),
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
                       setState(() {
                         for(var item in todos){
                           item.checkbox = val;
                         }
                         checkall=val;
                       }); 
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
                          setState(() {
                            checkall=false;
                            for(int i=0;i<todos.length;i++){
                              if(todos[i].checkbox){
                                todos.removeAt(i);
                                i--;
                              }
                              else{}
                            }
                          });
                        },
                      )
                      
                      
              ],
            ),
          ),
              ])),



          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height*0.57,
            child: (
            ListView.builder(
            itemCount: todos.length,
            itemBuilder: (context, index) {
              return Dismissible(
                  key: UniqueKey(),
                  onDismissed: (direction) {
                    setState(() {
                      todos.removeAt(index);
                    });

                    //Show a snackbar
                    Scaffold.of(context).showSnackBar(
                        SnackBar(content: Text("${todos[index].title} deleted"), backgroundColor: Colors.red,));
                  },

                  //show a red background as the item is swiped away
                  background: Container(color: Colors.red),
                  child: Card(
                    child: ListTile(
                      leading: Checkbox(
                        value: todos[index].checkbox,
                        onChanged: (bool newValue) {
                          setState(() {
                            todos[index].checkbox = newValue;
                            if(newValue==false){
                              checkall = false;
                            }
                            int penampung=0;
                            for (var i = 0; i < todos.length; i++) {
                              if(todos[i].checkbox==true){
                                penampung++;
                              }
                            }
                            if (penampung==todos.length){
                              checkall=true;
                            }
                          });
                        },
                      ),
                      title: 
                      Text('${todos[index].title} [${index+1}]', 
                      style: todos[index].checkbox
                      ? TextStyle(decoration: TextDecoration.lineThrough,color: Colors.blue[900])
                      : TextStyle(decoration: TextDecoration.none,color: Colors.black)
                      ),
                       
                      onLongPress: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  DetailScreen(todo: todos[index]),
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
                               editTodo: editTodo,
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
                  builder: (context) => AddScreen(handleTodo),
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
    // TODO: implement build
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