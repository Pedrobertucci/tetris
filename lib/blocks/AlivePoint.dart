import 'package:bad_neighbor/point.dart';
import 'package:flutter/material.dart';


class AlivePoint extends Point {
  Color color;

  AlivePoint(int x, int y, Color col) : super(x,y) {
     color = col;
  }

  bool checkIfPointCollide(List<Point> pointList) {
    bool retVal = false;

    pointList.forEach((pointToCheck) {
       if(pointToCheck.x == x && pointToCheck.y == y-1) {
         retVal = true;
       }
    });

    return retVal;
  }
}