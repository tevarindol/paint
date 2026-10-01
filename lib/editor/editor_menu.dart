import 'package:flutter/material.dart';

import 'shape/shape_type.dart';

class EditorMenu extends StatelessWidget {
  const EditorMenu({
    super.key,
    required this.selectedTool,
    required this.onToolSelected,
  });

  final ShapeType? selectedTool;
  final ValueChanged<ShapeType?> onToolSelected;

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
            for (final ShapeType tool in ShapeType.values)
              MenuItemButton(
                onPressed: () => onToolSelected(selectedTool == tool ? null : tool),
                trailingIcon: selectedTool == tool ? const Icon(Icons.check) : null,
                child: Text(tool.label),
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
