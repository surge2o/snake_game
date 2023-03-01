import 'dart:math';

import 'package:flutter/material.dart';
import 'package:snake_game/direction.dart';
import 'package:snake_game/piece.dart';

class GamePage extends StatefulWidget {
  const GamePage({super.key});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  late int upperBoundx, upperBoundy, lowerBoundx, lowerBoundy;
  late double screenWidth, screenHeight;
  int step = 20;
  int lenght = 5;

  Direction direction = Direction.right;
  List<Offset> positions = [];

  int getNearestTens(int num) {
    int output;
    output = (num ~/ step) * step;
    if (output == 0) {
      output += step;
    }
    return output;
  }

  Offset getRandomPosition() {
    Offset position;
    int posX = Random().nextInt(upperBoundx) + lowerBoundx;
    int posY = Random().nextInt(upperBoundy) + lowerBoundy;
    position = Offset(
        getNearestTens(posX).toDouble(), getNearestTens(posY).toDouble());

    return position;
  }

  void draw() {
    if (positions.length == 0) {
      positions.add(getRandomPosition());
    }

    while (lenght > positions.length) {
      positions.add(positions[positions.length - 1]);
    }

    for (var i = positions.length - 1; i > 0; i--) {
      positions[i] = positions[i - 1];
    }
    positions[0] = getNextPosition(positions[0])!;
  }

  Offset? getNextPosition(Offset position) {
    Offset? nextPosition;

    if (direction == Direction.right) {
      nextPosition = Offset(position.dx + step, position.dy);
    } else if (direction == Direction.left) {
      nextPosition = Offset(position.dx - step, position.dy);
    } else if (direction == Direction.up) {
      nextPosition = Offset(position.dx, position.dy - step);
    } else if (direction == Direction.down) {
      nextPosition = Offset(position.dx, position.dy + step);
    }
    return nextPosition;
  }

  List<Piece> getPieces() {
    final pieces = <Piece>[];
    draw();
    for (var i = 0; i < lenght; i++) {
      pieces.add(Piece(
        posX: positions[i].dx.toInt(),
        posY: positions[i].dy.toInt(),
        color: Colors.red,
        size: step,
      ));
    }

    return pieces;
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    lowerBoundy = step;
    lowerBoundx = step;

    upperBoundy = getNearestTens(screenHeight.toInt()) - step;
    upperBoundx = getNearestTens(screenWidth.toInt()) - step;

    return Scaffold(
        body: Container(
      color: Colors.amber,
      child: Stack(
        children: getPieces(),
      ),
    ));
  }
}
