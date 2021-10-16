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
  //Construir um ambiente para consumir a API e o builder da lista
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
        appBar: AppBar(
          title: const Text('Lista de tarefas'),
        ),
        body: tasksList());
  }

  //constroi a lista(widgegt) listView (ListView.builder)
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
            // onTap: () {
            //   Navigator.push(
            //       context,
            //       new MaterialPageRoute(
            //           builder: (context) => DetailPage(tasks[index])));
            // }, //Quando clicar no item da lista
          );
        });
  }
}

// class DetailPage extends StatelessWidget{

// }

Uri url = Uri.parse('http://emsapi.esy.es/todolist/api/task/search/');

class API {
  static Future getTasks() async {
    return await http.post(
      url,
      headers: <String, String>{
        "Content-type": "Application/json; charset=UTF-8",
        "Authorization": "123",
      },
    );
  }
}

//Classe que faz o parser do JSON retornado da API
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
