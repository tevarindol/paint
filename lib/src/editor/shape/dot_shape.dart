import 'package:flutter/material.dart';

import 'shape.dart';

class DotShape extends Shape {
  const DotShape({required super.start}) : super(end: start);

  @override
  void paint(Canvas canvas) {
    canvas.drawCircle(start, 3, Paint()..color = Colors.black);
  }

  @override
  void paintPreview(Canvas canvas) {}
}
