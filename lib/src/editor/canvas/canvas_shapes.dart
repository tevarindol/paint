import 'package:flutter/foundation.dart';

import '../shape/shape.dart';

class CanvasShapes extends ChangeNotifier {
  final List<Shape> shapes = <Shape>[];

  Shape? _selected;
  Shape? get selected => _selected;

  int get count => shapes.length;

  void add(Shape shape) {
    shapes.add(shape);
    notifyListeners();
  }

  void select(Shape? shape) {
    if (shape != null && !shapes.contains(shape)) {
      throw ArgumentError('Shape is not in the canvas');
    }
    if (_selected == shape) return;
    _selected = shape;
    notifyListeners();
  }

  void deleteSelected() {
    final shape = _selected;
    if (shape == null) return;
    shapes.remove(shape);
    _selected = null;
    notifyListeners();
  }

  void replaceAll(Iterable<Shape> replacement) {
    final newShapes = List<Shape>.of(replacement);
    shapes
      ..clear()
      ..addAll(newShapes);
    _selected = null;
    notifyListeners();
  }
}
