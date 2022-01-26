import 'package:flutter/material.dart';
import 'package:sliding_switch/sliding_switch.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:intl/intl.dart';

class PizzaCalculatorScreen extends StatefulWidget {
  const PizzaCalculatorScreen({Key? key}) : super(key: key);

  @override
  _PizzaCalculatorScreenState createState() => _PizzaCalculatorScreenState();
}

enum Sauce { hot, sweet, cheese } // Создаём перечисление для группы Radio по соусу

class _PizzaCalculatorScreenState extends State<PizzaCalculatorScreen> {
  bool _isSlinDough = false; // логическая переменная для теста (тонкое/обычное)
  double _pizzaSize = 40; // переменная Размер пиццы (м. и int сделать)
  int _cost = 100; // переменная для стоимости (если без копеек, то и int отлично
  Sauce? _sauce = Sauce.hot; // Переменная соус, по умолчанию стоит hot
  bool _addCheese = true; // логическая переменная дополнительный сыр

  int _calcCost() { // алгоритмика вычисления стоимости пиццы.
    // Размещена в отдельной функции, что позволит легко её подключать
    _cost = _pizzaSize.round() + 100; // 1 шаг - вычисление на основе размера
    // м.б. использовать набор условий или так же switch case

// булевые параметры выбора теста и сыра, поэтому к ним применяется условие if
// все формулы построены по принципу:
// обновлённая _coast = имеющаяся цена (_coast) + цена нового параметра (+= - сокращенно)
    if (_isSlinDough == true) _cost +=30;
    if (_addCheese == true) _cost += 50;

    // Просчет стоимости по радиокнопкам, принцип тот же
    switch (_sauce) {
      case Sauce.hot:
        _cost += 10;
        break;
      case Sauce.sweet:
        _cost += 20;
        break;
      case Sauce.cheese:
        _cost += 40;
        break;
      case null: // заложен ещё вариант null, если пользователь ничего не выбрал,
      // то автоматически ставится Sauce.hot. Можно использовать default
        _sauce = Sauce.hot;
        break;
    }
    return _cost; // возвращение стоимости
  }

  void _onSauceChanged(Sauce? value) { // Функция принимает выбор пользователя
    setState(() {
      _sauce = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          width: double.infinity,
          child: Column(
            children: [
              const SizedBox(
              height: 62,
              ),
            SizedBox(
              height: 100,
              child: Image.asset('assets/pizza.png'),
            ),

            const Text('Калькулятор пиццы',
              style: TextStyle(fontSize: 36, color: Color(0xFF000000))),
            const Text('Выберете параметры',
              style: TextStyle(fontSize: 16, color: Color(0xFF000000))),
            const SizedBox(
              height: 12,
            ),

            //Переключатель - крутой слайдер для выбора теста для пиццы
            SizedBox(
              width: 300,
              child: SlidingSwitch( // Прописывать в pubspec.yaml, он нестандартный
                value: false, // всего 2 значения м.б. - это двусторонний слайдер
                width: 300,
                onChanged: (bool value) {
                  _isSlinDough = value; // обработчиком передаем значения в калькулятор
                  setState(() {
                    _calcCost();
                  });
                },  // параметры "двойного слайдера"
                height: 30, // высота
                animationDuration: const Duration(milliseconds: 100), // Анимация, можно менять время
                onTap: () {}, // обработчики нажатия - пустые, потому что логика задана в onChanged:
                onDoubleTap: () {},
                onSwipe: () {},
                textOff: 'Обычное тесто', // заголовки выбора. Выключено - обычное тесто
                textOn: 'Тонкое тесто', // включено - тонкое тесто
                colorOn: const Color(0xFFFFFFFF), // цвета. Цвет текста в состоянии включено
                colorOff: const Color(0xF0FFFFFF), // -- // -- выключено
                background: const Color(0xFFECEFF1), // цвет фона
                buttonColor: const Color(0xFF0079D0), // цвет слайдера активный
                inactiveColor: const Color(0xFF636f7b), //  цвет слайдера в неактивном состоянии
              ),
            ),

      //Переключатель - крутой слайдер для выбора размера пиццы //
                const SizedBox(
                  height: 10,
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.only(top: 20, left: 20),
                  child: const Text('Размер',
                      style: TextStyle(fontSize: 18, color: Color(0xFF000000))),
                  ),
                SizedBox(
                    width: 300,
                    child: SfSlider( // Это сам слайдер. Прописывать в pubspec.yaml, он нестандартный
                      min: 20, // прописан минимум указания на слайдере
                      max: 60, // прописан максимум указания на слайдере
                      value: _pizzaSize,
                      interval: 20, // шаг интервала
                      showTicks: true,
                      showLabels: true,
                      numberFormat: NumberFormat('## см'), // спец. параметр NumberFormat,
                      // я его отдельно import 'package:intl/intl.dart';
                      // NumberFormat позволяет цифры на слайдере идентифицироваь как кол-во сантиметров
                      enableTooltip: false,
                      minorTicksPerInterval: 0,
                      stepSize: 20,
                      onChanged: (dynamic value) {
                        setState(() {
                          _pizzaSize = value;
                          _calcCost();
                        });
                      },
                      ),
                ),

                const SizedBox(
                  height: 10,
                ),

                // Выбор соуса. Заголовок и кнопки выбора
                Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.only(top: 10, left: 20),
                child: const Text ('Соус',
                    style: TextStyle(fontSize: 18, color: Color(0xFF000000))),
                ),

      // Группа радиокнопок
                RadioListTile<Sauce>(
                    title: const Text ('Острый'),
                    value: Sauce.hot,
                    groupValue: _sauce,
                    onChanged: _onSauceChanged,
                    visualDensity: const VisualDensity(horizontal: 0, vertical: -4),),

                RadioListTile<Sauce>(
                    title: const Text ('Кисло-сладкий'),
                    value: Sauce.sweet,
                    groupValue: _sauce,
                    onChanged: _onSauceChanged,
                    visualDensity: const VisualDensity(horizontal: 0, vertical: -4),),

                RadioListTile<Sauce>(
                    title: const Text ('Сырный'),
                    value: Sauce.cheese,
                    groupValue: _sauce,
                    onChanged: _onSauceChanged,
                    visualDensity: const VisualDensity(horizontal: 0, vertical: -4),),

              // Дополнительный сыр, переключатель
                SizedBox(
                  width: 300,
                  child: Card(
                    elevation: 0,
                    color: Color(0xFFF0F0F0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                            padding: const EdgeInsets.only(
                              right: 20,
                            ),
                        child: SizedBox(
                          width: 38,
                          height: 56,
                          child: Image.asset('assets/chees.png'),
                        ),
                        ),
                        const Text('Дополнительный сыр',
                          style: TextStyle(fontSize: 16, color: Color(0xFF263238))),
                        Switch(
                            value: _addCheese,
                            onChanged: (bool value) {
                              setState(() {
                                _addCheese = value;
                                _calcCost();
                              });
                            })
                      ],
                  ),
                ),
                ),

              // Выводим итоговую стоимость
              Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.only(top: 10, left: 20),
                child: Text('Стоимость:',
                    style: TextStyle(fontSize: 18, color: Color(0xFF000000))),
              ),

              // Цена в отдельной строке
              SizedBox(
                width: 300,
                height: 50,

                child: Card(
                  elevation: 0,
                  color: const Color(0xFFF0F0F0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                  child: Text('${_calcCost()} руб.',
                  style: const TextStyle(fontSize: 32, color: Color(0xFF000000)),
                  textAlign: TextAlign.center,
                  ),

                ),
              )

          ],
        ),
        )
      ),
    );
  }
}
