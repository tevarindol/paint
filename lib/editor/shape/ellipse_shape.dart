import 'package:flutter/material.dart';

import 'shape.dart';

class EllipseShape extends Shape {
  const EllipseShape({required super.start, required super.end});

  Rect get _rect => Rect.fromPoints(start, end);

  Paint _stroke(Color color) =>
      Paint()
        ..color = color
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2;

  @override
  void paint(Canvas canvas) {
    canvas.drawOval(_rect, _stroke(Colors.black));
  }

  @override
  void paintPreview(Canvas canvas) {
    drawDashed(canvas, _stroke(Colors.black), Path()..addOval(_rect));
  }
}
