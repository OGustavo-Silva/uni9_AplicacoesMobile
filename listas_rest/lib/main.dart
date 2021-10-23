import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lista APIRest',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BuildListView(),
    );
  }
}

class BuildListView extends StatefulWidget {
  @override
  _BuildListViewState createState() => _BuildListViewState();
}

class _BuildListViewState extends State<BuildListView> {
  //Build an environment to consume the API and list builder
  var tasks = [];

  _getTasks() {
    API.getTasks().then((response) {
      setState(() {
        Iterable list = json.decode(response.body);
        tasks = list.map((model) => Task.fromJson(model)).toList();
        print(tasks);
      });
    });
  }

  _BuildListViewState() {
    _getTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Lista de tarefas'), actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              onTap: () {
                Navigator.push(context,
                    new MaterialPageRoute(builder: (context) => addTaskPage()));
              },
              child: Text(
                "+",
                style: TextStyle(fontSize: 50),
              ),
            ),
          )
        ]),
        body: tasksList());
  }

  //Build the list(Widget) listView(ListView.builder)
  tasksList() {
    return ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(
                  "https://www.pinclipart.com/picdir/big/218-2189254_free-online-avatars-kid-characters-family-vector-for.png"),
              backgroundColor: Colors.blueAccent[300],
            ),
            title: Text(
              tasks[index].name,
              style: TextStyle(fontSize: 20.0, color: Colors.black),
            ),
            subtitle: Text(tasks[index].date),
            onTap: () {
              Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) => DetailPage(tasks[index])));
            }, //When clicking the list item
          );
        });
  }
}

class DetailPage extends StatelessWidget {
  final Task task;

  DetailPage(this.task);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(task.name),
        ),
        body: taskDetails());
  }

  taskDetails() {
    return Container(
      padding: new EdgeInsets.all(32.0),
      child: ListTile(
        title: Text(task.name, style: TextStyle(fontWeight: FontWeight.w500)),
        subtitle: Text(task.realized.toString()),
        leading: Icon(Icons.email, color: Colors.blue),
      ),
    );
  }
}

class addTaskPage extends StatefulWidget {
  @override
  _addTaskPageState createState() => _addTaskPageState();
}

class _addTaskPageState extends State<addTaskPage> {
  TextEditingController addTaskController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Adicionar nova tarefa"),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            TextFormField(
              controller: addTaskController,
              decoration: InputDecoration(
                labelText: "Informe a tarefa",
              ),
            ),
            MaterialButton(
              onPressed: () {
                API.addTask(addTaskController.text);
              },
              child: Text("Adicionar tarefa"),
            )
          ],
        ),
      ),
    );
  }
}

//TODO: edit user page and implement it

Uri url = Uri.parse('http://emsapi.esy.es/todolist/api/task/search/');

class API {
  static Future getTasks() async {
    return await http.post(
      url,
      headers: <String, String>{
        "Content-type": "Application/json; charset=UTF-8",
        "Authorization":
            "A3FABC0E28106BC6A4F4", //123 for professor's test login
      },
    );
  }

  static Future addTask(String task) async {
    url = Uri.parse('http://emsapi.esy.es/todolist/api/task/new/');
    return await http.post(
      url,
      headers: <String, String>{
        "content-type": "application/json",
        "Authorization": "A3FABC0E28106BC6A4F4",
      },
      body: jsonEncode(<String, String>{
        "name": task,
      }),
    );
  }
}

//Class that parses the JSON returned by the API
class Task {
  final int id;
  final int userId;
  final String name;
  final String date;
  final int realized;

  Task(this.id, this.userId, this.name, this.date, this.realized);

  Task.fromJson(Map json)
      : id = json['id'],
        userId = json['userId'],
        name = json['name'],
        date = json['date'],
        realized = json['realized'];
}
