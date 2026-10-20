# Лабораторна робота №3. Розробка інтерфейсу користувача

Варіант 27 (Ж = Жлаб2 + 1 = 26 + 1 = 27, номер в журналі 26). Простий графічний редактор на Flutter з меню Файл / Довідка та панеллю інструментів (Toolbar).
Крапка ставиться клацанням миші, лінія, прямокутник і еліпс вводяться перетягуванням.
Toolbar з кнопками-іконками та підказками служить для вибору типу об'єкта.

Параметри варіанту:
- масив вказівників Shape: динамічний (27 mod 3 = 0), без обмеження кількості;
- «гумовий» слід: пунктирна лінія чорного кольору (27 mod 4 = 3);
- прямокутник: ввід від центру до одного з кутів (27 mod 2 = 1), чорний контур з кольоровим заповненням (27 mod 5 = 2), колір заповнення — рожевий (27 mod 6 = 3);
- еліпс: ввід по двом протилежним кутам охоплюючого прямокутника (27 mod 2 = 1), чорний контур без заповнення (27 mod 5 = 2);
- позначка поточного типу об'єкта: у заголовку вікна (27 mod 2 = 1), дублюється підсвічуванням кнопки у Toolbar.

Запуск: `flutter run -d linux`

## Діаграма класів

```mermaid
classDiagram
    class ShapeType {
        <<enumeration>>
        dot
        line
        rectangle
        ellipse
        +String label
    }
    class Shape {
        <<abstract>>
        +Offset start
        +Offset end
        +drawDashed(Canvas, Paint, Path)
        +paint(Canvas)
        +paintPreview(Canvas)
    }
    class CanvasShapes {
        +List~Shape~ shapes
        +int count
        +add(Shape)
    }
    class ChangeNotifier {
        <<abstract>>
        +notifyListeners()
    }
    class DotShape
    class LineShape
    class RectangleShape
    class EllipseShape
    class PaintCanvas
    class _CanvasPainter
    class EditorPage
    class EditorMenu
    class EditorToolbar
    class PaintApp

    PaintApp --> EditorPage : home
    EditorPage --> EditorMenu
    EditorPage --> EditorToolbar
    EditorPage --> PaintCanvas
    EditorToolbar ..> ShapeType : tool icons
    PaintCanvas ..> ShapeType : selectedTool
    PaintCanvas *-- CanvasShapes : _storage
    PaintCanvas ..> _CanvasPainter : створює
    _CanvasPainter ..> Shape : paint()/paintPreview()
    CanvasShapes --|> ChangeNotifier : extends
    CanvasShapes o-- "0..*" Shape : shapes
    Shape ..> ShapeType : factory Shape.of()
    Shape <|-- DotShape
    Shape <|-- LineShape
    Shape <|-- RectangleShape
    Shape <|-- EllipseShape
```
