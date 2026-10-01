import 'package:flutter/material.dart';

import 'editor_menu.dart';
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

  void _selectTool(ShapeType? tool) {
    setState(() => selectedTool = tool);
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
          Expanded(child: PaintCanvas(selectedTool: selectedTool)),
        ],
      ),
    );
  }
}
