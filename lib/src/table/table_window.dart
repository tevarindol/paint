import 'dart:async';

import 'package:desktop_multi_window/desktop_multi_window.dart';
import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

import 'object_table.dart';
import 'table_connection.dart';

class TableWindow extends StatefulWidget {
  const TableWindow({super.key, required this.window});

  final WindowController window;

  @override
  State<TableWindow> createState() => _TableWindowState();
}

class _TableWindowState extends State<TableWindow> with WindowListener {
  late final TableConnection _connection;

  @override
  void initState() {
    super.initState();
    _connection = TableConnection(widget.window, widget.window.arguments);
    windowManager.addListener(this);
    unawaited(_start());
  }

  Future<void> _start() async {
    await windowManager.setPreventClose(true);
    if (!mounted) return;
    await _connection.start();
    if (!mounted) return;
    await windowManager.waitUntilReadyToShow(const WindowOptions(
      size: Size(700, 450),
      title: 'Таблиця графічних об’єктів',
    ));
    if (!mounted) return;
    await windowManager.show();
    await windowManager.focus();
  }

  @override
  void onWindowClose() => windowManager.hide();

  @override
  void dispose() {
    windowManager.removeListener(this);
    _connection.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListenableBuilder(
        listenable: _connection,
        builder: (context, _) {
          return ObjectTable<int>(
            rows: _connection.rows,
            selected: _connection.selected,
            onSelect: _connection.select,
            onDelete: () {
              final selected = _connection.selected;
              if (selected != null) _connection.delete(selected);
            },
          );
        },
      ),
    );
  }
}
