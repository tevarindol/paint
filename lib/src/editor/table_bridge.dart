import 'dart:collection';

import 'canvas/canvas_shapes.dart';
import 'shape/shape.dart';
import 'shape_csv.dart';

class TableBridge {
  TableBridge(this._shapes, {required this.onChanged}) {
    _shapes.addListener(_onShapesChanged);
  }

  final CanvasShapes _shapes;
  final void Function() onChanged;
  final Map<Shape, int> _ids = HashMap.identity();
  int _nextId = 0;
  int _revision = 0;

  int _idFor(Shape shape) => _ids.putIfAbsent(shape, () => _nextId++);

  Map<String, Object?> get snapshot => {
    'revision': _revision,
    'rows': [
      for (final shape in _shapes.shapes)
        {'id': _idFor(shape), 'cells': [
          ShapeCsv.typeOf(shape).label,
          '${shape.start.dx}', '${shape.start.dy}',
          '${shape.end.dx}', '${shape.end.dy}',
        ]},
    ],
    'selectedId': _shapes.selected == null ? null : _idFor(_shapes.selected!),
  };

  Shape? _findShape(int id) {
    for (final shape in _shapes.shapes) {
      if (_idFor(shape) == id) return shape;
    }
    return null;
  }

  void select(int id) {
    final shape = _findShape(id);
    if (shape != null) _shapes.select(shape);
  }

  void delete(int id) {
    final shape = _findShape(id);
    if (shape == null) return;
    _shapes.select(shape);
    _shapes.deleteSelected();
  }

  void _onShapesChanged() {
    final active = HashSet<Shape>.identity()..addAll(_shapes.shapes);
    _ids.removeWhere((shape, _) => !active.contains(shape));
    _revision++;
    onChanged();
  }

  void dispose() => _shapes.removeListener(_onShapesChanged);
}
