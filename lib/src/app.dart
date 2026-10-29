import 'package:desktop_multi_window/desktop_multi_window.dart';
import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

import 'editor/editor_page.dart';
import 'table/table_window.dart';

Future<void> launchPaint() async {
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();
  final window = await WindowController.fromCurrentEngine();
  if (window.arguments.isEmpty) {
    runApp(_EditorApp(window: window));
    return;
  }

  runApp(MaterialApp(home: TableWindow(window: window)));
}

class _EditorApp extends StatelessWidget {
  const _EditorApp({required this.window});
  final WindowController window;

  @override
  Widget build(BuildContext context) => MaterialApp(
    title: 'Paint',
    theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple), useMaterial3: true),
    home: EditorPage(title: 'Paint', window: window),
  );
}
