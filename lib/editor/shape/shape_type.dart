enum ShapeType { dot, line, rectangle, ellipse, circleLine, cube }

extension ShapeTypeLabel on ShapeType {
  String get label => switch (this) {
    ShapeType.dot => 'Крапка',
    ShapeType.line => 'Лінія',
    ShapeType.rectangle => 'Прямокутник',
    ShapeType.ellipse => 'Еліпс',
    ShapeType.circleLine => 'Лінія з кружечками',
    ShapeType.cube => 'Каркас куба',
  };
}
