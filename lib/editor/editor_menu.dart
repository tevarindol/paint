import 'package:flutter/material.dart';

class EditorMenu extends StatelessWidget {
  const EditorMenu({super.key, required this.onToolSelected});

  final ValueChanged<String> onToolSelected;

  @override
  Widget build(BuildContext context) {
    return MenuBar(
      children: [
        SubmenuButton(
          menuChildren: const [],
          child: const Text('Файл'),
        ),
        SubmenuButton(
          menuChildren: [
            for (final tool in const ['Крапка', 'Лінія', 'Прямокутник', 'Еліпс'])
              MenuItemButton(
                onPressed: () => onToolSelected(tool),
                child: Text(tool),
              ),
          ],
          child: const Text('Об\'єкти'),
        ),
        SubmenuButton(
          menuChildren: const [],
          child: const Text('Довідка'),
        ),
      ],
    );
  }
}
