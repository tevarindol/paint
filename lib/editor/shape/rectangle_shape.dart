import 'package:flutter/material.dart';

import 'shape.dart';

class RectangleShape extends Shape {
  const RectangleShape({required super.start, required super.end});

  Rect get _rect => Rect.fromPoints(start, end);

  Paint get _fill => Paint()..color = Colors.lightBlue;

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
    canvas.drawRect(_rect, _stroke(Colors.blue));
  }
}
