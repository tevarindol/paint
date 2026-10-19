import 'package:flutter/material.dart';

import 'shape.dart';

class RectangleShape extends Shape {
  const RectangleShape({required super.start, required super.end});

  Rect get _rect => Rect.fromCenter(
    center: start,
    width: (end.dx - start.dx).abs() * 2,
    height: (end.dy - start.dy).abs() * 2,
  );

  Paint get _fill => Paint()..color = Colors.pink;

  Paint _stroke(Color color) =>
      Paint()
        ..color = color
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2;

  @override
  void paint(Canvas canvas) {
    canvas.drawRect(_rect, _fill);
    canvas.drawRect(_rect, _stroke(Colors.black));
  }

  @override
  void paintPreview(Canvas canvas) {
    drawDashed(canvas, _stroke(Colors.black), Path()..addRect(_rect));
  }
}
