import 'package:flutter/foundation.dart';

import 'shape/shape.dart';

class CanvasShapes extends ChangeNotifier {
  final List<Shape> shapes = <Shape>[];

  int get count => shapes.length;

  void add(Shape shape) {
    shapes.add(shape);
    notifyListeners();
  }
}
