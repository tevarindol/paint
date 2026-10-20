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
  #text(size: 16pt, weight: "bold")[Лабораторна робота №3] \
  #v(1.2em)
  з дисципліни \
  «Об’єктно-орієнтоване програмування» \
  #v(1.2em)
  на тему \
  «Розробка інтерфейсу користувача»
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

+ Створити у середовищі розробки проєкт з ім’ям Lab3 (продовження проєкту графічного редактора, розробленого у лабораторній роботі №2).
+ Написати вихідний текст програми згідно варіанту завдання.
+ Скомпілювати вихідний текст і отримати виконуваний файл програми.
+ Перевірити роботу програми. За потреби налагодити програму.
+ Проаналізувати та прокоментувати результати та вихідний текст програми.
+ Оформити звіт.

= Завдання згідно варіанту

+ У звіті повинна бути схема успадкування класів – діаграма класів.
+ Усі методи-обробники повідомлень повинні бути функціями-членами деякого класу.
+ Для вибору типу об’єкта в графічному редакторі Lab3 передбачено вікно Toolbar з кнопками-іконками відповідно до типів об’єктів. Кнопки мають підказки (tooltips) та дублюють функціональність пунктів меню «Об’єкти», яке зникло з головного вікна: вибір інструмента виконується виключно кнопками панелі.
+ Для вибору варіанту використовується Ж = Ж~лаб2~ + 1, де Ж~лаб2~ – номер студента в журналі, використаний у лабораторній роботі №2 (Ж~лаб2~ = 26), тож Ж = 27. Решта вимог повторює пункти 4–7 лабораторної роботи №2 з новим значенням Ж.

Для мене (Ж = 27) буде:

- динамічний масив вказівників для Shape (27 mod 3 = 0) розрахунковим обсягом N = Ж + 100 = 127 об’єктів;
- «гумовий» слід (27 mod 4 = 3) – пунктирна лінія чорного кольору;
- прямокутник: ввід від центру до одного з кутів (27 mod 2 = 1), чорний контур з кольоровим заповненням (27 mod 5 = 2), колір заповнення – рожевий (27 mod 6 = 3);
- еліпс: ввід по двом протилежним кутам охоплюючого прямокутника (27 mod 2 = 1), чорний контур без заповнення (27 mod 5 = 2);
- позначка поточного типу об’єкта: у заголовку вікна (27 mod 2 = 1), дублюється підсвічуванням відповідної кнопки Toolbar.

= Лістинги програми

#listing("../lib/main.dart")
#listing("../lib/editor/editor_page.dart")
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

= Діаграма

#figure(
  image("media/lab3-diagram.png", width: 75%),
  supplement: [Рисунок],
  caption: [Діаграма класів графічного редактора],
)

= Скріншоти

#figure(
  image("media/lab3-screenshot-1.png", width: 80%),
  supplement: [Рисунок],
  caption: [Вигляд програми після запуску],
)

#figure(
  image("media/lab3-screenshot-2.png", width: 80%),
  supplement: [Рисунок],
  caption: [Вибір інструмента «Прямокутник»: підсвічена кнопка, підказка (tooltip) та позначка поточного типу об’єкта у заголовку вікна],
)

#figure(
  image("media/lab3-screenshot-3.png", width: 80%),
  supplement: [Рисунок],
  caption: [Ввід прямокутника від центру до кута: пунктирний «гумовий» слід під час перетягування; частина фігури, що вийшла за межі полотна, обрізається],
)

#figure(
  image("media/lab3-screenshot-4.png", width: 80%),
  supplement: [Рисунок],
  caption: [Результат роботи: рожеві прямокутники з чорним контуром, еліпс без заповнення, ввід еліпса по протилежних кутах охоплюючого прямокутника],
)

= Висновки

Отримав досвід роботи з елементом toolbar в Flutter. Перемістив частину меню (субменю Об'єкти) на місце тулбару. Поміняв стилі роботи елементів редактора (прямокутник, лінія, крапка, еліпс). Зробив список елементів динамічним.
