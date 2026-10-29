import 'dart:async';

import 'package:desktop_multi_window/desktop_multi_window.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:window_manager/window_manager.dart';

import 'object_table.dart';

class TableConnection extends ChangeNotifier {
  TableConnection(this._window, String mainWindowId)
    : _main = WindowController.fromWindowId(mainWindowId);

  final WindowController _window;
  final WindowController _main;
  List<TableRowData<int>> _rows = [];
  int? _selected;
  int _revision = -1;
  bool _disposed = false;

  List<TableRowData<int>> get rows => _rows;
  int? get selected => _selected;

  Future<void> start() async {
    await _window.setWindowMethodHandler(_handleCall);
    final snapshot = await _main.invokeMethod<Map>('ready');
    if (snapshot != null) _applySnapshot(snapshot);
  }

  Future<dynamic> _handleCall(MethodCall call) async {
    switch (call.method) {
      case 'snapshot':
        _applySnapshot(call.arguments as Map);
      case 'close':
        Timer.run(() => windowManager.destroy());
      default:
        throw MissingPluginException('Unknown method: ${call.method}');
    }
  }

  void _applySnapshot(Map snapshot) {
    final revision = snapshot['revision'] as int;
    if (_disposed || revision < _revision) return;
    final rows = snapshot['rows'] as List;
    _revision = revision;
    _selected = snapshot['selectedId'] as int?;
    _rows = rows.map((value) {
      final row = value as Map;
      return TableRowData<int>(
        key: row['id'] as int,
        cells: (row['cells'] as List).cast<String>(),
      );
    }).toList();
    notifyListeners();
  }

  Future<void> select(int id) => _send('select', id);

  Future<void> delete(int id) => _send('delete', id);

  Future<void> _send(String action, int id) async {
    final result = await _main.invokeMethod<Map>(action, id);
    if (result != null) _applySnapshot(result);
  }

  @override
  void dispose() {
    _disposed = true;
    _window.setWindowMethodHandler(null);
    super.dispose();
  }
}
