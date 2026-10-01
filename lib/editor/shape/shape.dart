import 'package:flutter/material.dart';

import 'dot_shape.dart';
import 'ellipse_shape.dart';
import 'line_shape.dart';
import 'rectangle_shape.dart';
import 'shape_type.dart';

abstract class Shape {
  const Shape({required this.start, required this.end});

  final Offset start;
  final Offset end;

  factory Shape.of(ShapeType type, {required Offset start, Offset? end}) =>
      switch (type) {
        ShapeType.dot => DotShape(start: start),
        ShapeType.line => LineShape(start: start, end: end ?? start),
        ShapeType.rectangle => RectangleShape(start: start, end: end ?? start),
        ShapeType.ellipse => EllipseShape(start: start, end: end ?? start),
      };

  void paint(Canvas canvas);

  void paintPreview(Canvas canvas);
}
