enum ShapeType {
  dot('Крапка', usesDrag: false),
  line('Лінія'),
  rectangle('Прямокутник'),
  ellipse('Еліпс'),
  circleLine('Лінія з кружечками'),
  cube('Каркас куба');

  const ShapeType(this.label, {this.usesDrag = true});

  final String label;

  /// true — фігура вводиться перетягуванням, false — клацанням.
  final bool usesDrag;
}
