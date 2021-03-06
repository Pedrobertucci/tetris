import 'package:bad_neighbor/game.dart';
import 'package:flutter/material.dart';

import '../point.dart';

class Block {
  List<Point> points = List<Point>(4);
  Point rotationCenter;
  Color color;

  void move(MoveDirection direction) {
    switch(direction) {
      case MoveDirection.LEFT:
        if(canMoveToSide(-1)) {
            points.forEach((p) => p.x -= 1);
        }
      break;
      case MoveDirection.RIGHT:
        if(canMoveToSide(1)) {
            points.forEach((p) => p.x += 1);
        }
      break;
      case MoveDirection.DOWN:
      points.forEach((p) => p.y += 1);
      break;
    }
  }

  bool canMoveToSide(int moveAmt) {
    bool retVal = true;

    points.forEach((point) {
      if(point.x + moveAmt < 0 || point.x + moveAmt >= BOARD_WIDTH) {
        retVal = false;
      }
    });

    return retVal;
  } 

  bool allPointsInside() {
    bool returnValue = true;

    points.forEach((point) {
      if(point.x < 0 || point.x >= BOARD_WIDTH) {
        returnValue = false;
      }
    });

    return returnValue;
  }

  void rotateRight() {
      points.forEach((point) {
          int x = point.x;
          point.x = rotationCenter.x - point.y + rotationCenter.y;
          point.y = rotationCenter.y + x - rotationCenter.x;
      });

      if(allPointsInside() == false) {
        rotateLeft();
      }
  }

   void rotateLeft() {
      points.forEach((point) {
          int x = point.x;
          point.x = rotationCenter.x + point.y - rotationCenter.y;
          point.y = rotationCenter.y - x + rotationCenter.x;
      });

      if(allPointsInside() == false) {
        rotateRight();
      }
  }

  bool isAtBottom() {
    int lowestPoint = 0;

    points.forEach((point) {
      if(point.y > lowestPoint) {
        lowestPoint = point.y;
      }
    });

    if(lowestPoint >= BOARD_HEIGHT - 1) {
      return true;
    } else {
      return false;
    }
  }
}