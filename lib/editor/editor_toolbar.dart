import 'package:flutter/material.dart';

import 'shape/shape_type.dart';

class EditorToolbar extends StatelessWidget {
  const EditorToolbar({
    super.key,
    required this.selectedTool,
    required this.onToolSelected,
  });

  final ShapeType? selectedTool;
  final ValueChanged<ShapeType?> onToolSelected;

  static IconData _iconFor(ShapeType type) => switch (type) {
    ShapeType.dot => Icons.trip_origin,
    ShapeType.line => Icons.horizontal_rule,
    ShapeType.rectangle => Icons.crop_square,
    ShapeType.ellipse => Icons.panorama_fish_eye,
  };

  Widget _buildButton(ColorScheme colorScheme, ShapeType tool) {
    final selected = selectedTool == tool;
    return IconButton(
      icon: Icon(_iconFor(tool)),
      tooltip: tool.label,
      isSelected: selected,
      onPressed: () => onToolSelected(selected ? null : tool),
      style: ButtonStyle(
        backgroundColor: WidgetStatePropertyAll<Color?>(
          selected ? colorScheme.secondaryContainer : null,
        ),
        foregroundColor: WidgetStatePropertyAll<Color?>(
          selected ? colorScheme.onSecondaryContainer : null,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Material(
      color: colorScheme.surfaceContainer,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
        child: Row(
          children: [
            for (final ShapeType tool in ShapeType.values) _buildButton(colorScheme, tool),
          ],
        ),
      ),
    );
  }
}
