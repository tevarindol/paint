#let fonts = ("Times New Roman", "Liberation Serif", "DejaVu Serif")
#let mono = ("Courier New", "Liberation Mono", "DejaVu Sans Mono")

#set text(font: fonts, size: 14pt, lang: "uk", hyphenate: false)
#set page(paper: "a4", margin: (left: 3cm, right: 1.5cm, top: 2cm, bottom: 2cm))
#set par(justify: true, leading: 1.5em, first-line-indent: 1.25cm, spacing: 1.5em)
#set figure.caption(separator: [ -- ])
#show figure.caption: set text(size: 12pt)
#show heading.where(level: 1): it => align(center, text(weight: "bold", it))
#show raw.where(block: true): set text(font: mono, size: 7.5pt)
#show raw.where(block: true): set par(justify: false, first-line-indent: 0pt, leading: 0.65em)
#show figure.where(kind: "listing"): set block(breakable: true)

#let listing(f) = {
  let name = f.split("/").last()
  figure(raw(lang: "dart", block: true, read(f)), kind: "listing", supplement: [Лістинг], caption: name)
}

// ---------- Титульна сторінка ----------
#set par(first-line-indent: 0pt, leading: 0.9em, spacing: 0.9em, justify: false)
#align(center)[
  МІНІСТЕРСТВО ОСВІТИ І НАУКИ УКРАЇНИ \
  Національний технічний університет України \
  «Київський політехнічний інститут імені Ігоря Сікорського» \
  Факультет інформатики та обчислювальної техніки \
  Кафедра обчислювальної техніки
]
#v(1fr)
#align(center)[
  #text(size: 16pt, weight: "bold")[Лабораторна робота №5] \
  #v(1.2em)
  з дисципліни \
  «Об’єктно-орієнтоване програмування» \
  #v(1.2em)
  на тему \
  «Розробка багатовіконного інтерфейсу користувача для графічного редактора об’єктів»
]
#v(1fr)
#grid(
  columns: (1fr, 1fr),
  align: (left, right),
  [
    Виконав: \
    студент групи ІМ-55 \
    Стеблевець Олександр Олександрович \
    Номер в списку – 26
  ],
  [Перевірив: \ Рекечинський Д.О.],
)
#v(2.5em)
#align(center)[Київ 2026]

#pagebreak()

// ---------- Основна частина ----------
#set page(numbering: "1")
#set par(first-line-indent: 1.25cm, leading: 1.5em, spacing: 1.5em, justify: true)

= Мета роботи

Отримати навички програмування багатовіконного інтерфейсу в об’єктно-орієнтованому стилі.

= Завдання та варіант

Номер у журналі – 26, тому контролер редактора потрібно реалізувати як класичний Singleton. Графічний редактор з попередньої роботи необхідно доповнити окремим немодальним вікном таблиці об’єктів та збереженням фігур у файл. Також потрібно передбачити виділення й видалення фігур через таблицю та завантаження збережених фігур із файлу.

= Лістинги програми

#listing("../lib/main.dart")
#listing("../lib/src/app.dart")
#listing("../lib/src/editor/editor_page.dart")
#listing("../lib/src/editor/editor_controller.dart")
#listing("../lib/src/editor/editor_menu.dart")
#listing("../lib/src/editor/table_window_controller.dart")
#listing("../lib/src/editor/table_bridge.dart")
#listing("../lib/src/editor/shape_csv.dart")
#listing("../lib/src/editor/canvas/editor_toolbar.dart")
#listing("../lib/src/editor/canvas/paint_canvas.dart")
#listing("../lib/src/editor/canvas/canvas_shapes.dart")
#listing("../lib/src/editor/shape/shape_type.dart")
#listing("../lib/src/editor/shape/shape.dart")
#listing("../lib/src/editor/shape/dot_shape.dart")
#listing("../lib/src/editor/shape/line_shape.dart")
#listing("../lib/src/editor/shape/rectangle_shape.dart")
#listing("../lib/src/editor/shape/ellipse_shape.dart")
#listing("../lib/src/editor/shape/circle_line_shape.dart")
#listing("../lib/src/editor/shape/cube_shape.dart")
#listing("../lib/src/table/table_window.dart")
#listing("../lib/src/table/table_connection.dart")
#listing("../lib/src/table/object_table.dart")

= Діаграма

#figure(
  image("media/lab5-diagram.png", width: 85%),
  supplement: [Рисунок],
  caption: [Діаграма класів редактора та вікна таблиці],
)

= Приклад файлу об’єктів

Кожен рядок CSV містить тип фігури та координати двох точок. Для прямокутника перша точка задає центр, друга – кут; координати точки збігаються.

```csv
type,x1,y1,x2,y2
dot,10,130,10,130
line,45,23,400,327
ellipse,123,304,257,412
rectangle,200,200,250,240
```

= Скріншоти

#figure(
  image("media/lab5-screenshot-1.png", width: 80%),
  supplement: [Рисунок],
  caption: [Головне вікно редактора з виділеною фігурою],
)

#figure(
  image("media/lab5-screenshot-2.png", width: 80%),
  supplement: [Рисунок],
  caption: [Вікно таблиці з вибраним рядком, що відповідає виділеній фігурі],
)

= Висновки

Реалізував багатовіконний інтерфейс редактора, обмін даними між вікнами та збереження й завантаження фігур. Отримав практичний досвід використання Singleton, колбеків і сповіщень про зміни стану.
