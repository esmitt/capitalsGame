import 'package:flutter/material.dart';
import 'game.dart';

class Results extends StatefulWidget {
  int correct;
  int total;
  String time;

  Results({Key key, @required this.correct, @required this.total, @required this.time})
      : super(key: key);
  @override
  _ResultsState createState() => _ResultsState(correct, total, time);
}

class _ResultsState extends State<Results> {
  int correct;
  int total;
  String message, image, stats, time;

  List<String> images = [
    "assets/images/icons8-happy-80.png",
    "assets/images/icons8-lol-80.png",
    "assets/images/icons8-sad-80.png",
  ];

  _ResultsState(this.correct, this.total, this.time);

  @override
  void initState() {
    double percentage = this.correct / this.total.toDouble();
    stats = this.correct.toString() + " de " + this.total.toString();

    if (percentage <= 0.3) {
      image = images[2];
      message =
          "Te puedes esforzar un poco más..\n";
    } else if (percentage <= 0.6) {
      image = images[1];
      message =
          "Sé que lo puedes hacer mejor..\n";
          
    } else if (percentage <= 1.0) {
      image = images[0];
      message =
          "Lo hiciste excelente! felicidades..\n";
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Resultado",
        ),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 8,
            child: Material(
              elevation: 10.0,
              child: Container(
                child: Column(
                  children: <Widget>[
                    Material(
                      child: Container(
                        width: 300.0,
                        height: 300.0,
                        child: ClipRect(
                          child: Image(
                            image: AssetImage(
                              image,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 5.0,
                        horizontal: 15.0,
                      ),
                      child: Column(
                        children: <Widget>[
                          Center(
                            child: Text(
                              message,
                              style: TextStyle(
                                fontSize: 20.0,
                              ),
                            ),
                          ),
                          Center(
                            child: Text(
                              stats + " en " + time + "s",
                              style: TextStyle(
                                fontSize: 15.0,
                              ),
                            ),
                          ),

                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                OutlineButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => Game(),
                    ));
                  },
                  child: Text(
                    "¿Otra vez?",
                    style: TextStyle(
                      fontSize: 18.0,
                    ),
                  ),
                  padding: EdgeInsets.symmetric(
                    vertical: 10.0,
                    horizontal: 25.0,
                  ),
                  borderSide: BorderSide(width: 3.0, color: Colors.indigo),
                  splashColor: Colors.indigoAccent,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
