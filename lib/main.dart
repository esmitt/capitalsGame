import 'package:flutter/material.dart';
import 'package:simple_splashscreen/simple_splashscreen.dart';
import 'game.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Capitales de Liam",
      theme: ThemeData(fontFamily: 'RobotoSlab'),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Simple_splashscreen(
      context: context,
      gotoWidget: Game(),
      splashscreenWidget: SplashScreen(),
      timerInSeconds: 3,
    );
  }
}

//Splash Screen
class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Text(
            'Capitales de Liam',
            style: TextStyle(
              fontSize: 35.0,
        ),
      )),
    );
  }
}