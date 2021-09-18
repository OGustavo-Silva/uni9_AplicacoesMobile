import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  //Chamada da classe que contem a aplicacao
  runApp(MaterialApp(
    home: Home(), //ponto inicial da aplicacao
    debugShowCheckedModeBanner: false, //remove a logo do debug
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //declarar variaveis e objetos da aplicacao
  TextEditingController alcoolController =
      TextEditingController(); // entrada tipo EditText
  TextEditingController gasolinaController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>(); //objeto form
  String _resultado = "";

  void _calculaCombustivel() {
    setState(() {
      double vAlcool = double.parse(alcoolController.text.replaceAll(',', '.'));
      double vGasolina =
          double.parse(gasolinaController.text.replaceAll(',', '.'));
      double proporcao = vAlcool / vGasolina;
      _resultado =
          (proporcao < 0.7) ? 'Abasteça com Álcool' : 'Abasteça com Gasolina';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Álcool ou Gasolina",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.lightBlue[900],
        actions: <Widget>[
          IconButton(onPressed: () {}, icon: Icon(Icons.refresh)),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: Form(
          key: _formKey,
          child: Column(
            //coluna para abrigar os campos do formulario
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Icon(Icons.local_gas_station,
                  size: 50, color: Colors.lightBlue[900]),
              TextFormField(
                controller: alcoolController,
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
                //***validacao***
                //estilizando form
                decoration: InputDecoration(
                  labelText: "Valor do Álcool",
                  labelStyle: TextStyle(color: Colors.lightBlue[900]),
                ),
                style: TextStyle(color: Colors.lightBlue[900], fontSize: 26.0),
              ),
              TextFormField(
                controller: gasolinaController,
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Valor da Gasolina",
                  labelStyle: TextStyle(color: Colors.lightBlue[900]),
                ),
                style: TextStyle(color: Colors.lightBlue[900], fontSize: 26.0),
              ),
              Padding(
                padding: EdgeInsets.only(top: 50, bottom: 50),
                child: MaterialButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate())
                      _calculaCombustivel();
                  },
                  child: Text(
                    "Calcular",
                    style: TextStyle(color: Colors.white, fontSize: 35),
                  ),
                  color: Colors.lightBlue[900],
                ),
              ),
              Text(
                _resultado,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.lightBlue[900], fontSize: 30),
              )
            ],
          ),
        ),
      ),
    );
  }
}
