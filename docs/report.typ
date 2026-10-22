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
  #text(size: 16pt, weight: "bold")[Лабораторна робота №4] \
  #v(1.2em)
  з дисципліни \
  «Об’єктно-орієнтоване програмування» \
  #v(1.2em)
  на тему \
  «Вдосконалення структури коду графічного редактора об’єктів»
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

= Завдання

+ Створити у середовищі розробки проєкт з ім’ям Lab4 (подальший розвиток проєкту графічного редактора, розробленого у лабораторній роботі №3).
+ Написати вихідний текст програми згідно варіанту завдання.
+ Скомпілювати вихідний текст і отримати виконуваний файл програми.
+ Перевірити роботу програми. Налагодити програму.
+ Проаналізувати та прокоментувати результати та вихідний текст програми.
+ Оформити звіт.

= Завдання згідно варіанту

Номер варіанту дорівнює номеру студента в журналі: Ж = 26.

+ Студенти з парним номером програмують *динамічний* об’єкт класу MyEditor, забезпечивши коректне його створення та знищення. Ж = 26 – парне, тому в контролері редактора (клас `EditorController`, що виконує роль MyEditor; назву обрано ідіоматичною для Flutter) об’єкт стану створюється в `initState` і явно знищується у `dispose`.
+ Усі кольори та стилі геометричних форм (за винятком «гумового» сліду) – як у лабораторній роботі №3: прямокутник вводиться від центру до кута з рожевим заповненням і чорним контуром, еліпс – по протилежних кутах охоплюючого прямокутника без заповнення. «Гумовий» слід при вводі *усіх* фігур малюється пунктирною лінією.
+ Окрім чотирьох типів фігур з лабораторних робіт №2–3, запрограмовано введення та відображення двох нових фігур – *лінії з кружечками* та *каркасу куба*. Кольори ліній та заповнення цих фігур обрано на власний розсуд (чорний контур без заповнення).
+ Класи нових фігур має бути запрограмовано множинним успадкуванням. Мова Dart множинного успадкування не підтримує, тому, як дозволяє завдання, його замінено *композицією-делегуванням*: клас `CircleLineShape` містить об’єкти `LineShape` і два `EllipseShape` і для відображення викликає їхні методи `paint()`; клас `CubeShape` містить два `RectangleShape` (грані) і чотири `LineShape` (ребра) – теж через виклики `paint()`. Пряма вимога завдання «показувати лінії методом Show з класу LineShape, кружечки – з класу EllipseShape, прямокутники – з класу RectShape» виконується буквально: нові класи самі нічого не малюють.
+ Для всіх шести типів форм реалізовано кнопки панелі Toolbar з підказками (tooltips). Позначка поточного типу об’єкта, як і в роботі №3, – у заголовку вікна та підсвічуванням кнопки.
+ У звіті наведена схема успадкування класів – діаграма класів.

= Лістинги програми

#listing("../lib/main.dart")
#listing("../lib/editor/editor_page.dart")
#listing("../lib/editor/editor_controller.dart")
#listing("../lib/editor/editor_menu.dart")
#listing("../lib/editor/editor_toolbar.dart")
#listing("../lib/editor/paint_canvas.dart")
#listing("../lib/editor/canvas_shapes.dart")
#listing("../lib/editor/shape/shape_type.dart")
#listing("../lib/editor/shape/shape.dart")
#listing("../lib/editor/shape/dot_shape.dart")
#listing("../lib/editor/shape/line_shape.dart")
#listing("../lib/editor/shape/rectangle_shape.dart")
#listing("../lib/editor/shape/ellipse_shape.dart")
#listing("../lib/editor/shape/circle_line_shape.dart")
#listing("../lib/editor/shape/cube_shape.dart")

= Діаграма

#figure(
  image("media/lab4-diagram.png", width: 75%),
  supplement: [Рисунок],
  caption: [Діаграма класів графічного редактора (успадкування, агрегація та делегування)],
)

= Скріншоти

#figure(
  image("media/lab4-screenshot-1.png", width: 80%),
  supplement: [Рисунок],
  caption: [Панель інструментів з кнопками для всіх шести типів фігур: вибір інструмента «Каркас куба» – підсвічена кнопка, підказка (tooltip) та позначка поточного типу об’єкта у заголовку вікна],
)

#figure(
  image("media/lab4-screenshot-2.png", width: 80%),
  supplement: [Рисунок],
  caption: [Кнопка нової фігури «Лінія з кружечками» з підказкою],
)

#figure(
  image("media/lab4-screenshot-3.png", width: 80%),
  supplement: [Рисунок],
  caption: [Результат роботи: намальований каркас куба та лінія з кружечками на кінцях; пунктирний «гумовий» слід введення наступного куба],
)

= Висновки

Отримав досвід роботи з enum і конструкторами в Dart. Переніс всю фігурну логіку (як приклад - іконки) в сам enum. Також додав дві фігури в програму і переробив логіку внутрішньного стану редактора.
