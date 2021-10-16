import 'package:flutter/material.dart';

import 'editar.dart';

class Cadastro extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tela de cadastro"),
      ),
      body: Center(
        child: Column(
          children: [
            MaterialButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => Editar()));
              },
              child: Text("Próxima tela (Editar)"),
            )
          ],
        ),
      ),
    );
  }
}
