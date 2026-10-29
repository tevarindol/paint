import 'dart:async';
import 'dart:io';

import 'package:desktop_multi_window/desktop_multi_window.dart';
import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

import 'canvas/editor_toolbar.dart';
import 'canvas/paint_canvas.dart';
import 'editor_controller.dart';
import 'editor_menu.dart';
import 'shape/shape_type.dart';
import 'shape_csv.dart';
import 'table_window_controller.dart';

class EditorPage extends StatefulWidget {
  const EditorPage({super.key, required this.title, required this.window});

  final String title;
  final WindowController window;

  @override
  State<EditorPage> createState() => _EditorPageState();
}

class _EditorPageState extends State<EditorPage> with WindowListener {
  late final EditorController _editor;
  late final TableWindowController _table;
  bool _closing = false;

  @override
  void initState() {
    super.initState();
    _editor = EditorController()..addListener(_handleEditorChanged);
    _table = TableWindowController(widget.window, _editor.shapes);
    windowManager.addListener(this);
    unawaited(windowManager.setPreventClose(true));
    _updateTitle(_editor.selectedTool);
  }

  @override
  void dispose() {
    windowManager.removeListener(this);
    _table.dispose();
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

  Future<void> _openTable() async {
    if (_closing) return;
    await _table.open();
  }

  @override
  void onWindowClose() async {
    if (_closing) return;
    _closing = true;
    try {
      await _table.close();
      await windowManager.destroy();
    } finally {
      _closing = false;
    }
  }

  Future<void> _open() async {
    const type = XTypeGroup(label: 'CSV', extensions: ['csv']);
    final file = await openFile(acceptedTypeGroups: [type]);
    if (file == null) return;
    final shapes = ShapeCsv.decode(await file.readAsString());
    if (!mounted) return;
    _editor.shapes.replaceAll(shapes);
  }

  Future<void> _save() async {
    const type = XTypeGroup(label: 'CSV', extensions: ['csv']);
    final location = await getSaveLocation(acceptedTypeGroups: [type], suggestedName: 'paint.csv');
    if (location == null) return;
    await File(location.path).writeAsString(ShapeCsv.encode(_editor.shapes.shapes));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: Text(widget.title)),
      body: Column(
        children: [
          Align(
            alignment: AlignmentDirectional.centerStart,
            child: EditorMenu(
              selectedTool: _editor.selectedTool,
              onToolSelected: _selectTool,
              onOpen: _open,
              onSave: _save,
              onTable: _openTable,
            ),
          ),
          EditorToolbar(selectedTool: _editor.selectedTool, onToolSelected: _selectTool),
          Expanded(child: PaintCanvas(editor: _editor)),
        ],
      ),
    );
  }
}
