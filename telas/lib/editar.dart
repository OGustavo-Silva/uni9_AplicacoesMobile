import 'package:flutter/material.dart';

class Editar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tela de edição"),
      ),
      body: Center(
        child: Column(
          children: [
            MaterialButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Voltar para cadastro"),
            )
          ],
        ),
      ),
    );
  }
}
