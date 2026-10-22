import 'package:flutter/material.dart';

import 'ellipse_shape.dart';
import 'line_shape.dart';
import 'shape.dart';

class CircleLineShape extends Shape {
  CircleLineShape({required super.start, required super.end})
    : _line = LineShape(start: start, end: end),
      _startDot = _circle(start),
      _endDot = _circle(end);

  static const double _radius = 5;

  final LineShape _line;
  final EllipseShape _startDot;
  final EllipseShape _endDot;

  static EllipseShape _circle(Offset center) => EllipseShape(
    start: Offset(center.dx - _radius, center.dy - _radius),
    end: Offset(center.dx + _radius, center.dy + _radius),
  );

  @override
  void paint(Canvas canvas) {
    _line.paint(canvas);
    _startDot.paint(canvas);
    _endDot.paint(canvas);
  }

  @override
  void paintPreview(Canvas canvas) {
    final paint =
        Paint()
          ..color = Colors.black
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2;
    drawDashed(
      canvas,
      paint,
      Path()
        ..moveTo(start.dx, start.dy)
        ..lineTo(end.dx, end.dy)
        ..addOval(Rect.fromCircle(center: start, radius: _radius))
        ..addOval(Rect.fromCircle(center: end, radius: _radius)),
    );
  }
}
