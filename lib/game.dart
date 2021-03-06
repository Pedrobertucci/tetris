import 'dart:async';

import 'package:bad_neighbor/blocks/AlivePoint.dart';
import 'package:bad_neighbor/blocks/userInput.dart';
import 'package:bad_neighbor/helper.dart';
import 'package:bad_neighbor/scoreDisplay.dart';
import 'package:flutter/material.dart';
import 'blocks/block.dart';
import 'main.dart';
import 'actionButton.dart';

enum LastButtonPressed { LEFT, RIGHT, ROTATE_LEFT, ROTATE_RIGHT, NONE }

enum MoveDirection { LEFT, RIGHT, DOWN }

const int BOARD_WIDTH = 10;
const int BOARD_HEIGHT = 20;
const double POINT_SIZE = 20; //size pixels

const int GAME_SPEED = 200;

Timer timer;

class Game extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _Game();
}
  
class _Game extends State<Game> {
  LastButtonPressed performAction = LastButtonPressed.NONE;
  Block currentBlock;
  List<AlivePoint> alivePoints = <AlivePoint>[];
  int score = 0;

  @override
  void initState() {
    super.initState();
    startGame();
  }

  void onActionButtonPress(LastButtonPressed newAction) {
    setState(() {
      performAction = newAction;
         print("changing state: " + performAction.toString());
    });
  }

  void startGame() {
    setState(() {
      currentBlock = getRandomBlock();
    });

    timer = new Timer.periodic(new Duration(milliseconds: GAME_SPEED), onTimeTick);
  }

  void checkForUserInput() {
     if(performAction != LastButtonPressed.NONE) {
        setState(() {
          switch(performAction) {
            case LastButtonPressed.LEFT:
              currentBlock.move(MoveDirection.LEFT);
            break;
            case LastButtonPressed.RIGHT:
              currentBlock.move(MoveDirection.RIGHT);
            break;
            case LastButtonPressed.ROTATE_LEFT:
              currentBlock.rotateLeft();
            break;
            case LastButtonPressed.ROTATE_RIGHT:
              currentBlock.rotateRight();
            break;
            default:
            break;
          }

          performAction = LastButtonPressed.NONE;
        });
      }
  }

  void saveOldBlock() {
      currentBlock.points.forEach((point) {
        AlivePoint newPoint = AlivePoint(point.x, point.y, currentBlock.color);
        setState(() {
          alivePoints.add(newPoint);
        }); 
      });
  }

  bool isAboweOldBlock() {
    bool retVal = false;

    alivePoints.forEach((oldPoint) {
      if(oldPoint.checkIfPointCollide(currentBlock.points)) {
        retVal = true;
      }
    });

    return retVal;
  }

  void removeRow(int row) {
    setState(() {
      alivePoints.removeWhere((point) => point.y == row);

      alivePoints.forEach((point) {
        if(point.y < row) {
          point.y += 1;
        }
      });

      score += 1;
    });
  }

  void removeFullRows() {
    for(int currentRow = 0; currentRow < BOARD_HEIGHT; currentRow++) {
      int counter = 0;

      alivePoints.forEach((point) {
        if(point.y == currentRow) {
          counter++;
        }
      });

      if(counter == BOARD_WIDTH) {
        removeRow(currentRow);
      }
    }
  }

  bool playerLost() {
    bool returnValue = false;

    alivePoints.forEach((point) {
      if(point.y <= 0)  {
        returnValue = true;
      }
    });

    return returnValue;
  }

  void onTimeTick(Timer timer) {
      if(currentBlock == null || playerLost()) return;

      removeFullRows();

      if(currentBlock.isAtBottom() || isAboweOldBlock()) {
          saveOldBlock();

          setState(() {
            currentBlock = getRandomBlock();
          });

      } else {
        setState(() {
          currentBlock.move(MoveDirection.DOWN);
        });

        checkForUserInput();
      }
  }

  Widget drawTetrisBlock() {
      if(currentBlock == null) return null;

      List<Positioned> visiblePoints = List();

      currentBlock.points.forEach((point) { 
         visiblePoints.add(
           Positioned(
            child: getTetrisPoint(currentBlock.color),
            left: point.x * POINT_SIZE,
            top: point.y * POINT_SIZE,
          )
         );
      });

      alivePoints.forEach((point) {
          visiblePoints.add(Positioned(
            child: getTetrisPoint(point.color),
            left: point.x * POINT_SIZE,
            top: point.y * POINT_SIZE,
          ));
      });
      return Stack(children: visiblePoints);
  }

  @override
  Widget build(BuildContext context) {
     return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Center(
          child: Container(
          width: WIDTH,
          height: HEIGHT,
          decoration: BoxDecoration(border: Border.all(color: Colors.black)),
          child: (playerLost() == false) ? drawTetrisBlock() : getGameOverText(score)),
        ),
        Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget> [
         ScoreDisplay(score),
         UserInput(onActionButtonPress)
        ])
      ]
    ); 
  }
}

