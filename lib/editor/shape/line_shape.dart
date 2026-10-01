import 'package:flutter/material.dart';

import 'shape.dart';

class LineShape extends Shape {
  const LineShape({required super.start, required super.end});

  @override
  void paint(Canvas canvas) {
    canvas.drawLine(start, end, _stroke(Colors.black));
  }

  @override
  void paintPreview(Canvas canvas) {
    canvas.drawLine(start, end, _stroke(Colors.blue));
  }

  static Paint _stroke(Color color) =>
      Paint()
        ..color = color
        ..strokeWidth = 2;
}
