import 'package:flutter/material.dart';

class EditorMenu extends StatelessWidget {
  const EditorMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return MenuBar(
      children: [
        SubmenuButton(
          menuChildren: const [],
          child: const Text('Файл'),
        ),
        SubmenuButton(
          menuChildren: const [],
          child: const Text('Довідка'),
        ),
      ],
    );
  }
}
