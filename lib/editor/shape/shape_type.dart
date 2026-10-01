enum ShapeType { dot, line, rectangle, ellipse }

extension ShapeTypeLabel on ShapeType {
  String get label => switch (this) {
    ShapeType.dot => 'Крапка',
    ShapeType.line => 'Лінія',
    ShapeType.rectangle => 'Прямокутник',
    ShapeType.ellipse => 'Еліпс',
  };
}
