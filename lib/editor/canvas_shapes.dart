import 'package:flutter/foundation.dart';

import 'shape/shape.dart';

class CanvasShapes extends ChangeNotifier {
  final List<Shape?> shapes = List.filled(126, null, growable: false);
  int _count = 0;

  bool get isFull => _count >= shapes.length;

  int get count => _count;

  void add(Shape shape) {
    if (isFull) {
      return;
    }
    shapes[_count++] = shape;
    notifyListeners();
  }
}
