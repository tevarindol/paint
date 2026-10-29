import 'dart:ui';

import 'package:csv/csv.dart';
import 'package:flutter/foundation.dart';

import 'shape/circle_line_shape.dart';
import 'shape/cube_shape.dart';
import 'shape/dot_shape.dart';
import 'shape/ellipse_shape.dart';
import 'shape/line_shape.dart';
import 'shape/rectangle_shape.dart';
import 'shape/shape.dart';
import 'shape/shape_type.dart';

class ShapeCsv {
  static final _csv = Csv(lineDelimiter: '\n', autoDetect: false);
  static const _header = ['type', 'x1', 'y1', 'x2', 'y2'];

  static ShapeType typeOf(Shape shape) => switch (shape) {
    DotShape() => ShapeType.dot,
    LineShape() => ShapeType.line,
    RectangleShape() => ShapeType.rectangle,
    EllipseShape() => ShapeType.ellipse,
    CircleLineShape() => ShapeType.circleLine,
    CubeShape() => ShapeType.cube,
    _ => throw ArgumentError('Unknown shape: ${shape.runtimeType}'),
  };

  static String encode(Iterable<Shape> shapes) {
    final rows = <List<dynamic>>[_header];
    for (final shape in shapes) {
      final type = typeOf(shape);
      rows.add([type.name, shape.start.dx, shape.start.dy, shape.end.dx, shape.end.dy]);
    }
    return _csv.encode(rows);
  }

  static List<Shape> decode(String text) {
    final rows = _csv.decode(text);
    final result = <Shape>[];
    for (var i = 0; i < rows.length; i++) {
      final fields = rows[i].map((value) => value.toString().trim()).toList();
      if (i == 0 && listEquals(fields, _header)) continue;
      if (fields.length != _header.length) {
        throw FormatException('Запис ${i + 1}: потрібно 5 полів');
      }
      final types = ShapeType.values.where((type) => type.name == fields[0]);
      final coordinates = fields.skip(1).map(double.tryParse).toList();
      if (types.isEmpty || coordinates.any((value) => value == null || !value.isFinite)) {
        throw FormatException('Запис ${i + 1}: невідомий тип або координати');
      }
      final start = Offset(coordinates[0]!, coordinates[1]!);
      final end = Offset(coordinates[2]!, coordinates[3]!);
      if (types.first == ShapeType.dot && start != end) {
        throw FormatException('Запис ${i + 1}: координати точки не збігаються');
      }
      result.add(Shape.of(types.first, start: start, end: end));
    }
    return result;
  }
}
