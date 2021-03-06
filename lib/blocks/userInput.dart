import 'package:flutter/material.dart';

import '../actionButton.dart';
import 'package:bad_neighbor/game.dart';
class UserInput extends StatelessWidget {
  final Function onActionButtonPress;

  UserInput(this.onActionButtonPress);
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Row(children: <Widget> [
            ActionButton(onActionButtonPress, Icon(Icons.rotate_left), LastButtonPressed.ROTATE_LEFT),
            ActionButton(onActionButtonPress, Icon(Icons.rotate_right), LastButtonPressed.ROTATE_RIGHT),
          ],
        ),
        Row(
          children: <Widget> [
            ActionButton(onActionButtonPress, Icon(Icons.arrow_left), LastButtonPressed.LEFT),
            ActionButton(onActionButtonPress, Icon(Icons.arrow_right), LastButtonPressed.RIGHT)
          ],
        ),
      ],
    );
  }

}