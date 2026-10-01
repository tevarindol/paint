import 'package:flutter/material.dart';

import 'shape.dart';

class EllipseShape extends Shape {
  const EllipseShape({required super.start, required super.end});

  Rect get _rect => Rect.fromCenter(
    center: start,
    width: (end.dx - start.dx).abs() * 2,
    height: (end.dy - start.dy).abs() * 2,
  );

  Paint get _fill => Paint()..color = Colors.white;

  Paint _stroke(Color color) =>
      Paint()
        ..color = color
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2;

  @override
  void paint(Canvas canvas) {
    canvas.drawOval(_rect, _fill);
    canvas.drawOval(_rect, _stroke(Colors.black));
  }

  @override
  void paintPreview(Canvas canvas) {
    canvas.drawOval(_rect, _stroke(Colors.blue));
  }
}
