import 'package:flutter/foundation.dart';

import 'canvas/canvas_shapes.dart';
import 'shape/shape.dart';
import 'shape/shape_type.dart';

class EditorController extends ChangeNotifier {
  EditorController._();

  static EditorController? _instance;

  factory EditorController() => _instance ??= EditorController._();

  CanvasShapes? _shapes = CanvasShapes();
  ShapeType? _selectedTool;

  bool get isDestroyed => _shapes == null;

  CanvasShapes get shapes {
    final storage = _shapes;
    if (storage == null) {
      throw StateError('EditorController is destroyed');
    }
    return storage;
  }

  ShapeType? get selectedTool => _selectedTool;

  void selectTool(ShapeType? tool) {
    if (_selectedTool == tool) {
      return;
    }
    _selectedTool = tool;
    notifyListeners();
  }

  void addShape(Shape shape) => shapes.add(shape);

  void destroy() => dispose();

  @override
  void dispose() {
    if (isDestroyed) {
      return;
    }
    _shapes!.shapes.clear();
    _shapes = null;
    _selectedTool = null;
    _instance = null;
    super.dispose();
  }
}
