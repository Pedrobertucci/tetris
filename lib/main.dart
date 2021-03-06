import 'package:flutter/material.dart';
import 'game.dart';
import 'menu.dart';

void main() => runApp(MyApp());

const double WIDTH = 200;
const double HEIGHT = 400;

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: "Bad neighbor", home: Home());
  }
}

class Home extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Bad neighbor"), 
      centerTitle: true),
      backgroundColor: Colors.white,
      body: Menu(), 
    );
  }
}

class GameScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back_ios),
          onPressed: () async {
            timer.cancel();
            Navigator.pop(context);
          },
        
      ),
      title: Text("Play")),
      backgroundColor: Colors.white,
      body: Game(),
    );
  }

}
