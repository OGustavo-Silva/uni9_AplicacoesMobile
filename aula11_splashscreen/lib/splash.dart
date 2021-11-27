import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rive/rive.dart';

import 'home.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Artboard _riveArtboard;
  RiveAnimationController _controller;
  bool get isPlaying => _controller.isActive;

  @override
  void initState() {
    super.initState();
    //selecao do tipo de animacao (arquivos locais)
    rootBundle.load('assets/chat.riv').then((value) {
      final file = RiveFile();
      if (file.import(value)) {
        final artboard = file.mainArtboard;
        artboard.addController(_controller = SimpleAnimation("principal"));
        setState(() => _riveArtboard = artboard);
      }
    });
    starTime();

  
  }

    void startTime() Async{
      
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
