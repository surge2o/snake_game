import 'package:flutter/material.dart';

class Piece extends StatefulWidget {
  final int posX, posY, size;
  final Color color;

  const Piece(
      {super.key,
      required this.color,
      required this.size,
      required this.posX,
      required this.posY});

  @override
  State<Piece> createState() => _PieceState();
}

class _PieceState extends State<Piece> {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: widget.posY.toDouble(),
      left: widget.posX.toDouble(),
      child: Opacity(
        opacity: (1),
        child: Container(
          width: widget.size.toDouble(),
          height: widget.size.toDouble(),
          decoration: BoxDecoration(
              color: widget.color,
              borderRadius: const BorderRadius.all(Radius.circular(
                10.0,
              )),
              border: Border.all(width: 2.0, color: Colors.white)),
        ),
      ),
    );
  }
}
