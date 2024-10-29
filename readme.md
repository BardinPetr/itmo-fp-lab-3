# Отчет по лабораторной работе №3 по предмету "Функциональное программирование"

> Выполнил: студент группы P3319 Бардин Петр Алексеевич

## Постановка задачи

Разработать программу осуществляющую интерполяцию функции по заданным точкам. 

#### Требования

- необходимо поддерживать работу с несколькими алгоритмами интерполяции одновременно
- расчет интерполяции должен производиться в оконном режиме по мере получения данных
- потоковая обработка входных данных из stdin с выводом в stdout
- требуется динамически осуществлять расчет и вывод новых значений сразу после получения достаточного количества входных данных
- для каждого метода необходимо выводить таблицу расчета значений интерполяционной функции в тестовых точках с фиксированным шагом на данном интервале
- cli для настройки режима работы
- алгоритмы: линейная интерполяция, многочлен Лагранжа

## Реализация

Структура системы:

- `main.ml` - пускатель с парсером командной строки 
- `input.ml`: `main_input_stream` - Seq из разобранных данных stdin  
- `output.ml`: `print_table` - формирование таблицы из последовательности точек
- `datagen.ml`: 
  - `gen_range` - генератор точек на отрезке
  - `apply_on_range` - применение функции на массиве точек 
- `sequtils.ml` - функции для объединения последовательностей и sliding-window 
- `interp.ml` - функции для создания функции интерполяции по точкам
- `run.ml`:
  - `main` - открыть поток stdin, его и выбранные функции передать в `apply_windowed_interpolations`, собрать результаты обратно в поток и вывести вы stdout.
  - `make_interpolation_runner` - из функции интерполяции создать функцию которая будет применяться на окнах последовательности, с учетом обертки генератора точек, применения функции. 
  - `apply_windowed_interpolations` - для всех методов интерполяции подготовить последовательности окон на входных данных и затем применить функции из `make_interpolation_runner`

## Пример работы

### Пример ввода

```
0 0.00
1.571 1
3.142 0
4.712 -1
12.568  0
```

### Пример вывода

```
Method: Linear interpolation
X |  0.00 | 1.00 | 2.00
Y |  0.00 | 0.64 | 1.27

Method: Linear interpolation
X |  1.57 | 2.57 | 3.57
Y |  1.00 | 0.36 |-0.27

Method: Lagrange interpolation (3pt)
X |  0.00 | 1.00 | 2.00 | 3.00 | 4.00
Y |  0.00 | 0.87 | 0.93 | 0.17 |-1.39

Method: Linear interpolation
X |  3.14 | 4.14 | 5.14
Y |  0.00 |-0.64 |-1.27

Method: Lagrange interpolation (3pt)
X |  1.57 | 2.57 | 3.57 | 4.57 | 5.57
Y |  1.00 | 0.36 |-0.27 |-0.91 |-1.55

Method: Lagrange interpolation (4pt)
X |  0.00 | 1.00 | 2.00 | 3.00 | 4.00 | 5.00
Y |  0.00 | 0.97 | 0.84 | 0.12 |-0.67 |-1.03

Method: Linear interpolation
X |  4.71 | 5.71 | 6.71 | 7.71 | 8.71 | 9.71 |10.71 |11.71 |12.71
Y | -1.00 |-0.87 |-0.75 |-0.62 |-0.49 |-0.36 |-0.24 |-0.11 | 0.02

Method: Lagrange interpolation (3pt)
X |  3.14 | 4.14 | 5.14 | 6.14 | 7.14 | 8.14 | 9.14 |10.14 |11.14 |12.14 |13.14
Y |  0.00 |-0.68 |-1.20 |-1.56 |-1.76 |-1.79 |-1.67 |-1.38 |-0.92 |-0.31 | 0.47

Method: Lagrange interpolation (4pt)
X |  1.57 | 2.57 | 3.57 | 4.57 | 5.57 | 6.57 | 7.57 | 8.57 | 9.57 |10.57 |11.57 |12.57
Y |  1.00 | 0.37 |-0.28 |-0.91 |-1.49 |-1.95 |-2.26 |-2.38 |-2.25 |-1.84 |-1.11 | 0.00
```

### Справка в CLI


```
INTERPOLATION APP(1)       Interpolation app Manual       INTERPOLATION APP(1)



NAME
       Interpolation app

SYNOPSIS
       Interpolation app [-m VAL] [--step=VAL] [OPTION]…

OPTIONS
       -m VAL
           Choose one or more methods to use from: linear,lagrange3,lagrange4

       -s VAL, --step=VAL (absent=1.)
           The float step value for points generator when evaluating
           interpolation

COMMON OPTIONS
       --help[=FMT] (default=auto)
           Show this help in format FMT. The value FMT must be one of auto,
           pager, groff or plain. With auto, the format is pager or plain
           whenever the TERM env var is dumb or undefined.

EXIT STATUS
       Interpolation app exits with:

       0   on success.

       123 on indiscriminate errors reported on standard error.

       124 on command line parsing errors.

       125 on unexpected internal errors (bugs).
```


## Вывод

В ходе работы удалось получиться навыки работы с вводом выводом, потоковой обработки данных c произведением ленивых вычислений. В особенности полезным было научиться использовать один входной поток данных для нескольких задач с последующим объединением результатов при сохранении у выходного потока возможности ленивого вычисления.