import 'package:flutter/material.dart';
import 'package:simple_splashscreen/simple_splashscreen.dart';
import 'game.dart';

void main() => runApp(MyApp());

// flutter packages pub run flutter_launcher_icons:main
// flutter build apk --split-per-abi
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
      timerInSeconds: 2,
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
            child: Image.asset(
              'assets/images/icon-main.png',
              width: 500,
              alignment: Alignment.center,
            ),
          ),
          Center( 
            child: Text(
              "CAPITALES",
              style: TextStyle(
                color: Colors.redAccent.shade200,
                fontSize: 45,
                fontFamily: 'Raleway',
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        ],
      ),
    );
  }
}
