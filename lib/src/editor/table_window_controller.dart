import 'dart:async';

import 'package:desktop_multi_window/desktop_multi_window.dart';
import 'package:flutter/services.dart';

import 'canvas/canvas_shapes.dart';
import 'table_bridge.dart';

class TableWindowController {
  TableWindowController(this._mainWindow, CanvasShapes shapes) {
    _bridge = TableBridge(shapes, onChanged: _publishSnapshot);
    _handlerReady = _mainWindow.setWindowMethodHandler(_handleCall);
  }

  final WindowController _mainWindow;
  late final TableBridge _bridge;
  late final Future<void> _handlerReady;
  WindowController? _window;
  Completer<void>? _ready;
  Future<void>? _opening;
  bool _disposed = false;

  Future<dynamic> _handleCall(MethodCall call) async {
    switch (call.method) {
      case 'ready':
        final ready = _ready;
        if (ready != null && !ready.isCompleted) ready.complete();
        return _bridge.snapshot;
      case 'select':
        _bridge.select(call.arguments as int);
        return _bridge.snapshot;
      case 'delete':
        _bridge.delete(call.arguments as int);
        return _bridge.snapshot;
      default:
        throw MissingPluginException('Unknown method: ${call.method}');
    }
  }

  void _publishSnapshot() {
    final window = _window;
    if (window == null || !(_ready?.isCompleted ?? false)) return;
    unawaited(_sendSnapshot(window));
  }

  Future<void> _sendSnapshot(WindowController window) async {
    try {
      await window.invokeMethod('snapshot', _bridge.snapshot);
    } on WindowChannelException {
      //
    }
  }

  Future<void> open() async {
    if (_disposed || _opening != null) return;
    final window = _window;
    if (window != null) {
      await window.show();
      return;
    }
    final operation = _openWindow();
    _opening = operation;
    try {
      await operation;
    } finally {
      _opening = null;
    }
  }

  Future<void> _openWindow() async {
    await _handlerReady;
    final ready = Completer<void>();
    _ready = ready;
    final window = await WindowController.create(WindowConfiguration(
      arguments: _mainWindow.windowId,
      hiddenAtLaunch: true,
    ));
    _window = window;

    await ready.future.timeout(const Duration(seconds: 15));
    await _sendSnapshot(window);
  }

  Future<void> close() async {
    final opening = _opening;
    if (opening != null) {
      try {
        await opening;
      } catch (_) {
        //
      }
    }
    final window = _window;
    if (window == null) return;
    final closed = onWindowsChanged
        .asyncMap((_) => WindowController.getAll())
        .timeout(const Duration(seconds: 5))
        .firstWhere((windows) => !windows.any((item) => item.windowId == window.windowId));

    closed.ignore();
    try {
      await window.invokeMethod('close').timeout(const Duration(seconds: 5));
    } on WindowChannelException {
      final windows = await WindowController.getAll();
      if (windows.any((item) => item.windowId == window.windowId)) rethrow;
      return;
    }
    await closed;
  }

  void dispose() {
    _disposed = true;
    _mainWindow.setWindowMethodHandler(null);
    _bridge.dispose();
  }
}
