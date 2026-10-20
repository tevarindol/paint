import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

import 'editor_menu.dart';
import 'editor_toolbar.dart';
import 'paint_canvas.dart';
import 'shape/shape_type.dart';

class EditorPage extends StatefulWidget {
  const EditorPage({super.key, required this.title});

  final String title;

  @override
  State<EditorPage> createState() => _EditorPageState();
}

class _EditorPageState extends State<EditorPage> {
  ShapeType? selectedTool;

  @override
  void initState() {
    super.initState();
    _updateTitle();
  }

  void _selectTool(ShapeType? tool) {
    setState(() => selectedTool = tool);
    _updateTitle();
  }

  void _updateTitle() {
    final tool = selectedTool;
    windowManager.setTitle(tool == null ? 'Paint' : 'Paint (${tool.label})');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: Text(widget.title)),
      body: Column(
        children: [
          Align(
            alignment: AlignmentDirectional.centerStart,
            child: EditorMenu(selectedTool: selectedTool, onToolSelected: _selectTool),
          ),
          EditorToolbar(selectedTool: selectedTool, onToolSelected: _selectTool),
          Expanded(child: PaintCanvas(selectedTool: selectedTool)),
        ],
      ),
    );
  }
}
