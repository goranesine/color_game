import 'package:flutter/material.dart';

Widget blackHole(double angle) {
  return Transform.rotate(
    angle: angle,
    alignment: Alignment.center,
    child: Transform(
      transform: Matrix4.identity()
        ..setEntry(1, 1, 1)
        ..rotateX(3.14 / 3.0),
      alignment: FractionalOffset.center,
      child: Container(
        height: 200,
        width: 200,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.black,
          boxShadow: [
            BoxShadow(
                color: Colors.red,
                blurRadius: 20.0,
                offset: Offset(20.0, 0.0),
                spreadRadius: 1.0)
          ],
        ),
      ),
    ),
  );
}