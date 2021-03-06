import 'package:bad_neighbor/main.dart';
import 'package:bad_neighbor/menuButton.dart';
import 'package:flutter/material.dart';

class Menu extends StatefulWidget {
  State<StatefulWidget> createState() => _MenuClass();
}



class _MenuClass extends State<Menu> {

  void onPlayClicked() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => GameScreen()));
  }

  @override
  Widget build(BuildContext context) {
    
   return Container(alignment: Alignment.center, 
   child: Column(mainAxisAlignment: MainAxisAlignment.center,
   children: [
     Text("Tetris",
      textAlign: TextAlign.center,
      style: TextStyle(
       fontSize: 70.0,
       fontWeight: FontWeight.bold,
       color: Colors.blue,
       shadows: [
         Shadow(color: Colors.black, blurRadius: 8.0, offset: Offset(2.0, 2.0))
       ]
     ),),
     SizedBox(height: 50),
     MenuButton(onPlayClicked),
    ]));
  }
}