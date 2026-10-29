import 'package:flutter/material.dart';

import 'line_shape.dart';
import 'rectangle_shape.dart';
import 'shape.dart';

class CubeShape extends Shape {
  CubeShape({required Offset start, required Offset end})
    : this._rects(Rect.fromPoints(start, end));

  CubeShape._rects(Rect front)
    : _front = front,
      _back = front.shift(_depth(front)),
      _frontFace = RectangleShape(
        start: front.center,
        end: front.bottomRight,
        filled: false,
      ),
      _backFace = RectangleShape(
        start: _rectAt(front, _depth(front)).center,
        end: _rectAt(front, _depth(front)).bottomRight,
        filled: false,
      ),
      _edges = [
        for (final corner in _corners(front))
          LineShape(start: corner, end: corner + _depth(front)),
      ],
      super(start: front.topLeft, end: front.bottomRight);

  static const double _depthFactor = 0.35;

  final Rect _front;
  final Rect _back;

  @override
  Rect get bounds => _front.expandToInclude(_back);
  final RectangleShape _frontFace;
  final RectangleShape _backFace;
  final List<LineShape> _edges;

  static Offset _depth(Rect rect) =>
      Offset(rect.width * _depthFactor, -rect.height * _depthFactor);

  static Rect _rectAt(Rect rect, Offset shift) => Rect.fromLTWH(
    rect.left + shift.dx,
    rect.top + shift.dy,
    rect.width,
    rect.height,
  );

  static List<Offset> _corners(Rect rect) =>
      [rect.topLeft, rect.topRight, rect.bottomLeft, rect.bottomRight];

  @override
  void paint(Canvas canvas) {
    _backFace.paint(canvas);
    for (final edge in _edges) {
      edge.paint(canvas);
    }
    _frontFace.paint(canvas);
  }

  @override
  void paintPreview(Canvas canvas) {
    final paint =
        Paint()
          ..color = Colors.black
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2;
    final path = Path()
      ..addRect(_front)
      ..addRect(_back);
    final frontCorners = _corners(_front);
    final backCorners = _corners(_back);
    for (var i = 0; i < frontCorners.length; i++) {
      path
        ..moveTo(frontCorners[i].dx, frontCorners[i].dy)
        ..lineTo(backCorners[i].dx, backCorners[i].dy);
    }
    drawDashed(canvas, paint, path);
  }
}
