import 'package:flutter/material.dart';

import 'canvas_shapes.dart';
import 'editor_controller.dart';
import 'shape/shape.dart';
import 'shape/shape_type.dart';

class PaintCanvas extends StatefulWidget {
  const PaintCanvas({super.key, required this.editor});

  final EditorController editor;

  @override
  State<PaintCanvas> createState() => _PaintCanvasState();
}

class _PaintCanvasState extends State<PaintCanvas> {
  Offset? _dragStart;
  Offset? _dragCurrent;

  Shape _buildShape(Offset start, Offset end) =>
      Shape.of(widget.editor.selectedTool!, start: start, end: end);

  bool get _isDragTool {
    final tool = widget.editor.selectedTool;
    return tool != null && tool != ShapeType.dot;
  }

  void _handleTapDown(TapDownDetails details) {
    if (widget.editor.selectedTool != ShapeType.dot) {
      return;
    }
    final position = details.localPosition;
    widget.editor.addShape(_buildShape(position, position));
  }

  void _handlePanStart(DragStartDetails details) {
    if (!_isDragTool) {
      return;
    }
    setState(() {
      _dragStart = details.localPosition;
      _dragCurrent = details.localPosition;
    });
  }

  void _handlePanUpdate(DragUpdateDetails details) {
    if (!_isDragTool) {
      return;
    }
    setState(() {
      _dragCurrent = details.localPosition;
    });
  }

  void _handlePanEnd(DragEndDetails details) {
    if (!_isDragTool) {
      return;
    }
    final start = _dragStart;
    final current = _dragCurrent;
    setState(() {
      _dragStart = null;
      _dragCurrent = null;
    });
    if (start == null || current == null) {
      return;
    }
    widget.editor.addShape(_buildShape(start, current));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTapDown: _handleTapDown,
      onPanStart: _handlePanStart,
      onPanUpdate: _handlePanUpdate,
      onPanEnd: _handlePanEnd,
      child: ColoredBox(
        color: Colors.white,
        child: CustomPaint(
          painter: _CanvasPainter(
            storage: widget.editor.shapes,
            tool: widget.editor.selectedTool,
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
    canvas.clipRect(Offset.zero & size);
    for (final shape in _storage.shapes) {
      shape.paint(canvas);
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
