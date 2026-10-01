import 'package:flutter/material.dart';

import 'canvas_shapes.dart';
import 'shape/shape.dart';
import 'shape/shape_type.dart';

class PaintCanvas extends StatefulWidget {
  const PaintCanvas({super.key, required this.selectedTool});

  final ShapeType? selectedTool;

  @override
  State<PaintCanvas> createState() => _PaintCanvasState();
}

class _PaintCanvasState extends State<PaintCanvas> {
  final CanvasShapes _storage = CanvasShapes();

  Offset? _dragStart;
  Offset? _dragCurrent;

  Shape _buildShape(Offset start, Offset end) => Shape.of(widget.selectedTool!, start: start, end: end);

  void _handleTapDown(TapDownDetails details) {
    if (widget.selectedTool != ShapeType.dot) {
      return;
    }
    final position = details.localPosition;
    _storage.add(_buildShape(position, position));
  }

  void _handlePanStart(DragStartDetails details) {
    setState(() {
      _dragStart = details.localPosition;
      _dragCurrent = details.localPosition;
    });
  }

  void _handlePanUpdate(DragUpdateDetails details) {
    setState(() {
      _dragCurrent = details.localPosition;
    });
  }

  void _handlePanEnd(DragEndDetails details) {
    final start = _dragStart;
    final current = _dragCurrent;
    setState(() {
      _dragStart = null;
      _dragCurrent = null;
    });
    if (start == null || current == null || _storage.isFull) {
      return;
    }
    _storage.add(_buildShape(start, current));
  }

  @override
  Widget build(BuildContext context) {
    final tool = widget.selectedTool;
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTapDown: tool == ShapeType.dot ? _handleTapDown : null,
      onPanStart: tool == ShapeType.dot ? null : _handlePanStart,
      onPanUpdate: tool == ShapeType.dot ? null : _handlePanUpdate,
      onPanEnd: tool == ShapeType.dot ? null : _handlePanEnd,
      child: ColoredBox(
        color: Colors.white,
        child: CustomPaint(
          painter: _CanvasPainter(
            storage: _storage,
            tool: widget.selectedTool,
            dragStart: _dragStart,
            dragCurrent: _dragCurrent,
          ),
          child: const SizedBox.expand(),
        ),
      ),
    );
  }
}

class _CanvasPainter extends CustomPainter {
  const _CanvasPainter({
    required CanvasShapes storage,
    required this.tool,
    required this.dragStart,
    required this.dragCurrent,
  }) : _storage = storage,
       super(repaint: storage);

  final CanvasShapes _storage;
  final ShapeType? tool;
  final Offset? dragStart;
  final Offset? dragCurrent;

  @override
  void paint(Canvas canvas, Size size) {
    for (final Shape? shape in _storage.shapes) {
      shape?.paint(canvas);
    }
    final start = dragStart;
    final current = dragCurrent;
    if (start == null || current == null || tool == null) {
      return;
    }
    Shape.of(tool!, start: start, end: current).paintPreview(canvas);
  }

  @override
  bool shouldRepaint(covariant _CanvasPainter oldDelegate) =>
      oldDelegate.dragStart != dragStart || oldDelegate.dragCurrent != dragCurrent;
}
