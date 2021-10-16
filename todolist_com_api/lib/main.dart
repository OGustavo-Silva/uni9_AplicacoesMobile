import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert'; // Work with JSON

//Criar aplicacao disponivel no appa implementando conexao da api
// disponivel do git https://github.com/EdsonMSouza/php-api-to-do-list
void main() {
  runApp(MaterialApp(
    home: Login(),
  ));
}

class User {
  final String username;
  final String email;
  User({required this.username, required this.email});

  //Convert JSON to User object
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      username: json['username'] as String,
      email: json['email'] as String,
    );
  }
}

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  //GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  //Login method
  Uri url = Uri.parse('http://emsapi.esy.es/todolist/api/user/login/');
  _jsonRestApiHttp() async {
    //Send the request to the API
    http.Response response = await http.post(
      this.url,
      headers: <String, String>{"content-type": "application/json"},
      body: json.encode(<String, String>{
        "username": usernameController.text,
        "password": passwordController.text
      }),
    );

    final parsed = json.decode(response.body);
    var user = new User.fromJson(parsed);
    print(user);
    print(usernameController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tela de login"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            //Username input Form
            TextFormField(
              controller: usernameController,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                labelText: "Username",
              ),
            ),
            //Password Input Form
            TextFormField(
              controller: passwordController,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                labelText: "Password",
              ),
            ),
            MaterialButton(
              onPressed: () {
                _jsonRestApiHttp();
              },
              child: Text("Login"),
            )
          ],
        ),
      ),
    );
  }
}
