import 'dart:async';
import 'dart:math';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

class Stars extends CustomPainter {
  final Random _random = Random();
  int i = 0;
 late final Timer _timer;

  @override
  void paint(Canvas canvas, Size size) {

    const pointMode = ui.PointMode.points;
    double starSize = _random.nextInt(10).toDouble();

    final points = [
      Offset(_random.nextInt(size.width.round()).toDouble(),
          _random.nextInt(size.height.round()).toDouble()),
    ];
    void draw(double strokeWidth) {
      final paint = Paint()
        ..color = Colors.white
        ..strokeWidth = strokeWidth
        ..strokeCap = StrokeCap.round;
      canvas.drawPoints(pointMode, points, paint);
    }
    void drawStars () {
      draw(starSize);
    }
    _timer = Timer.periodic(const Duration(seconds: 10), (timer) { drawStars();});

  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
  dispose(){
    _timer.cancel();

  }
}
