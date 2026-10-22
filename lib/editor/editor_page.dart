import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

import 'editor_controller.dart';
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
  late final EditorController _editor;

  @override
  void initState() {
    super.initState();
    _editor = EditorController()..addListener(_handleEditorChanged);
    _updateTitle(_editor.selectedTool);
  }

  @override
  void dispose() {
    _editor
      ..removeListener(_handleEditorChanged)
      ..destroy();
    super.dispose();
  }

  void _handleEditorChanged() {
    setState(() {});
  }

  void _selectTool(ShapeType? tool) {
    _editor.selectTool(tool);
    _updateTitle(tool);
  }

  void _updateTitle(ShapeType? tool) {
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
            child: EditorMenu(selectedTool: _editor.selectedTool, onToolSelected: _selectTool),
          ),
          EditorToolbar(selectedTool: _editor.selectedTool, onToolSelected: _selectTool),
          Expanded(child: PaintCanvas(editor: _editor)),
        ],
      ),
    );
  }
}
