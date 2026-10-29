import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TableRowData<T> {
  const TableRowData({required this.key, required this.cells});

  final T key;
  final List<String> cells;
}

class ObjectTable<T> extends StatelessWidget {
  const ObjectTable({
    super.key,
    required this.rows,
    required this.selected,
    required this.onSelect,
    required this.onDelete,
  });

  final List<TableRowData<T>> rows;
  final T? selected;
  final ValueChanged<T> onSelect;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return Focus(
      autofocus: true,
      onKeyEvent: (node, event) {
        if (event is KeyDownEvent && event.logicalKey == LogicalKeyboardKey.delete && selected != null) {
          onDelete();
          return KeyEventResult.handled;
        }
        return KeyEventResult.ignored;
      },
      child: SingleChildScrollView(
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            columns: const [
              DataColumn(label: Text('Назва')),
              DataColumn(label: Text('x1')),
              DataColumn(label: Text('y1')),
              DataColumn(label: Text('x2')),
              DataColumn(label: Text('y2')),
            ],
            rows: [
              for (final row in rows)
                DataRow(
                  selected: row.key == selected,
                  onSelectChanged: (_) => onSelect(row.key),
                  cells: [for (final cell in row.cells) DataCell(Text(cell))],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
