import 'package:bad_neighbor/blocks/LBlock.dart';
import 'package:bad_neighbor/blocks/Iblock.dart';
import 'package:bad_neighbor/blocks/JBlock.dart';
import 'package:bad_neighbor/blocks/SBlock.dart';
import 'package:bad_neighbor/blocks/TBlock.dart';
import 'package:bad_neighbor/blocks/ZBlock.dart';
import 'package:bad_neighbor/blocks/block.dart';
import 'package:bad_neighbor/blocks/sqBlock.dart';
import 'package:bad_neighbor/game.dart';
import 'package:flutter/material.dart';
import 'dart:math';

Block getRandomBlock() {
  int randomNr = Random().nextInt(7);
  switch(randomNr) {
    case 0: 
      return IBlock(BOARD_WIDTH);
    case 1: 
      return JBlock(BOARD_WIDTH);
    case 2: 
      return LBlock(BOARD_WIDTH);
    case 3: 
      return SBlock(BOARD_WIDTH);
    case 4: 
      return SquareBlock(BOARD_WIDTH);
    case 5: 
      return TBlock(BOARD_WIDTH);
    case 6: 
      return ZBlock(BOARD_WIDTH);
  }
}


Widget getTetrisPoint(Color color) {
  return Container(
    width: POINT_SIZE,
    height: POINT_SIZE,
    decoration: new BoxDecoration(
      color: color, 
      shape: BoxShape.rectangle,
    ),
  );
}

Widget getGameOverText(int score) {
  return Center(child: Text("Game Over\n Score: $score",
  textAlign: TextAlign.center,
  style: TextStyle(
      fontSize: 35.0, 
      fontWeight: FontWeight.bold,
      color: Colors.blue,
      shadows: [
        Shadow(
          color: Colors.black,
          offset: Offset(2.0, 2.0)      
        )
      ]
    ),
  ),
  
  );
} 