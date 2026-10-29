import 'package:flutter/material.dart';

import 'shape/shape_type.dart';

class EditorMenu extends StatelessWidget {
  const EditorMenu({
    super.key,
    required this.selectedTool,
    required this.onToolSelected,
    required this.onOpen,
    required this.onSave,
    required this.onTable,
  });

  final ShapeType? selectedTool;
  final ValueChanged<ShapeType?> onToolSelected;
  final VoidCallback onOpen;
  final VoidCallback onSave;
  final VoidCallback onTable;

  @override
  Widget build(BuildContext context) {
    return MenuBar(
      children: [
        SubmenuButton(
          menuChildren: [
            MenuItemButton(onPressed: onOpen, child: const Text('Відкрити…')),
            MenuItemButton(onPressed: onSave, child: const Text('Зберегти як…')),
          ],
          child: const Text('Файл'),
        ),
        SubmenuButton(
          menuChildren: [
            for (final ShapeType tool in ShapeType.values)
              CheckboxMenuButton(
                value: selectedTool == tool,
                onChanged: (bool? selected) => onToolSelected(selected == true ? tool : null),
                child: Text(tool.label),
              ),
          ],
          child: const Text('Об\'єкти'),
        ),
        SubmenuButton(
          menuChildren: [
            MenuItemButton(
              onPressed: onTable,
              child: const Text('Таблиця'),
            ),
          ],
          child: const Text('Довідка'),
        ),
      ],
    );
  }
}
