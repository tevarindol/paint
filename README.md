# Лабораторна робота №4. Вдосконалення структури коду графічного редактора об’єктів

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

Редактор і таблиця працюють в окремих рушіях Flutter. Пунктирний зв'язок між
`TableWindowController` і `TableConnection` позначає обмін повідомленнями через
`desktop_multi_window`, а не пряме посилання між об'єктами.

```mermaid
classDiagram
    class ShapeType {
        <<enumeration>>
        dot
        line
        rectangle
        ellipse
        circleLine
        cube
        +String label
        +IconData icon
        +bool usesDrag
    }
    class Shape {
        <<abstract>>
        +Offset start
        +Offset end
        +Rect bounds
        +drawDashed(Canvas, Paint, Path)
        +paint(Canvas)
        +paintPreview(Canvas)
    }
    class EditorController {
        -static EditorController _instance
        -CanvasShapes? _shapes
        -ShapeType? _selectedTool
        +ShapeType? selectedTool
        +CanvasShapes shapes
        +bool isDestroyed
        +selectTool(ShapeType?)
        +addShape(Shape)
        +destroy()
        +dispose()
    }
    class CanvasShapes {
        +List~Shape~ shapes
        +int count
        +Shape? selected
        +add(Shape)
        +select(Shape?)
        +deleteSelected()
        +replaceAll(Iterable~Shape~)
    }
    class ShapeCsv {
        +typeOf(Shape)$
        +encode(Iterable~Shape~)$
        +decode(String)$
    }
    class TableWindowController {
        +open()
        +close()
        +dispose()
    }
    class TableBridge {
        +Map snapshot
        +select(int)
        +delete(int)
        +dispose()
    }
    class TableConnection {
        +rows
        +int? selected
        +start()
        +select(int)
        +delete(int)
        +dispose()
    }
    class TableRowData~T~ {
        +T key
        +List~String~ cells
    }
    class ObjectTable~T~ {
        +rows
        +T? selected
        +onSelect
        +onDelete
    }
    class ChangeNotifier {
        <<abstract>>
        +notifyListeners()
    }
    class DotShape
    class LineShape
    class RectangleShape {
        +bool filled
    }
    class EllipseShape
    class CircleLineShape
    class CubeShape
    class PaintCanvas
    class _CanvasPainter
    class EditorPage
    class _EditorPageState
    class EditorMenu
    class EditorToolbar
    class _EditorApp
    class TableWindow
    class _TableWindowState

    _EditorApp --> EditorPage : home
    EditorPage ..> _EditorPageState : createState()
    _EditorPageState --> EditorController : singleton
    _EditorPageState *-- TableWindowController
    _EditorPageState ..> ShapeCsv : відкриття і збереження
    EditorController --|> ChangeNotifier : extends
    EditorController *-- CanvasShapes : володіє
    EditorController ..> Shape : addShape()
    _EditorPageState ..> ShapeType : label у заголовку вікна
    _EditorPageState --> EditorMenu
    _EditorPageState --> EditorToolbar
    _EditorPageState --> PaintCanvas
    EditorMenu ..> ShapeType : чекбокси за label
    EditorToolbar ..> ShapeType : tool icons
    PaintCanvas ..> EditorController : editor
    PaintCanvas ..> ShapeType : usesDrag
    PaintCanvas ..> _CanvasPainter : створює
    _CanvasPainter ..> Shape : paint()/paintPreview()
    CanvasShapes --|> ChangeNotifier : extends
    CanvasShapes o-- "0..*" Shape : shapes
    TableWindowController *-- TableBridge
    TableBridge --> CanvasShapes : слухає і змінює
    TableBridge ..> ShapeCsv : typeOf()
    ShapeCsv ..> Shape : encode/decode
    ShapeCsv ..> ShapeType
    TableWindow ..> _TableWindowState : createState()
    _TableWindowState *-- TableConnection
    _TableWindowState --> ObjectTable : створює
    TableConnection --|> ChangeNotifier : extends
    TableConnection --> TableRowData : rows
    ObjectTable --> TableRowData : rows
    TableWindowController ..> TableConnection : snapshot / close
    TableConnection ..> TableWindowController : ready / select / delete
    Shape ..> ShapeType : factory Shape.of()
    Shape <|-- DotShape
    Shape <|-- LineShape
    Shape <|-- RectangleShape
    Shape <|-- EllipseShape
    Shape <|-- CircleLineShape
    Shape <|-- CubeShape
    CircleLineShape o-- LineShape : делегування
    CircleLineShape o-- "2" EllipseShape : делегування
    CubeShape o-- "2" RectangleShape : делегування
    CubeShape o-- "4" LineShape : делегування
```
