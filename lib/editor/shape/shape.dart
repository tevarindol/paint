import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'dot_shape.dart';
import 'ellipse_shape.dart';
import 'line_shape.dart';
import 'rectangle_shape.dart';
import 'shape_type.dart';

abstract class Shape {
  const Shape({required this.start, required this.end});

  static const double _dash = 6;
  static const double _gap = 4;

  final Offset start;
  final Offset end;

  factory Shape.of(ShapeType type, {required Offset start, Offset? end}) =>
      switch (type) {
        ShapeType.dot => DotShape(start: start),
        ShapeType.line => LineShape(start: start, end: end ?? start),
        ShapeType.rectangle => RectangleShape(start: start, end: end ?? start),
        ShapeType.ellipse => EllipseShape(start: start, end: end ?? start),
      };

  void drawDashed(Canvas canvas, Paint paint, Path path) {
    for (final metric in path.computeMetrics()) {
      double distance = 0;
      while (distance < metric.length) {
        final next = math.min(distance + _dash, metric.length);
        canvas.drawPath(metric.extractPath(distance, next), paint);
        distance = next + _gap;
      }
    }
  }

  void paint(Canvas canvas);

  void paintPreview(Canvas canvas);
}
