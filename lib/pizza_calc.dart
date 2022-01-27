import 'package:flutter/material.dart';
import 'package:sliding_switch/sliding_switch.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:intl/intl.dart';

class PizzaCalc extends StatefulWidget {
  const PizzaCalc({Key? key}) : super(key: key);



  @override
  _PizzaCalcState createState() => _PizzaCalcState();
}
enum Sauce { hot, sweet, cheese } // Создаём перечисление для группы Radio по соусу

class _PizzaCalcState extends State<PizzaCalc> {

  bool _thinTesto = false; // Логическая переменная на тонкое тесто
  double _pizzaSize = 20; // Размер пиццы, по умолчанию 20 см.
  Sauce? _sauce = Sauce.hot; // соус, по умолчанию стоит hot
  double _pizzaCost = 0; // стоимость пиццы при параметрах по умолчанию
  bool _addCheese = false; // логическая переменная дополнительный сыр

  // алгоритмика вычисления стоимости пиццы.
  double? _pizzaCalcCost() {

    // расчет по размеру
    switch (_pizzaSize.round()) {
      case 20:
        _pizzaCost = 100;
        break;
      case 40:
        _pizzaCost = 150;
        break;
      case 60:
        _pizzaCost = 200;
        break;
    }

    if (_thinTesto == true) _pizzaCost += 50; // расчет по тесту
    if (_addCheese == true) _pizzaCost += 50; // расчет по сыру

    // расчет по соусу
    switch (_sauce) {
      case Sauce.hot:
        _pizzaCost += 20;
        break;
      case Sauce.sweet:
        _pizzaCost += 50;
        break;
      case Sauce.cheese:
        _pizzaCost += 40;
        break;
      case null: // AS жалуется на то, что ноль не прописан в выборе.
        _sauce = Sauce.hot;
        break;
    }
   return _pizzaCost;
  }

  void _onSauceChanged(Sauce? value) { // Функция принимает выбор пользователя
    setState(() {
      _sauce = value;
      _pizzaCalcCost ();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(), // Панель AppBar - отбивка сверху

          body: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10), // отступы от края???
            child: SingleChildScrollView( // скроллинг

              child: Column(
                children: [

                  Container(    // Картинка пиццы  // Расположение справа
                      child: const Image(image: AssetImage ('assets/pizza_1.png'),),
                      alignment: Alignment.topRight,),

                  const SizedBox(height: 33,), // Отбивка

                  const Text('Калькулятор пиццы',
                    style: TextStyle(fontSize: 36, color: Color(0xFF000000),
                        fontWeight: FontWeight.bold),
                      ),

                  const SizedBox(height: 9,), // Отбивка

                  const Text('Выберите параметры:',
                    style: TextStyle(fontSize: 16, color: Color(0xFF000000),
                        fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 9,), // Отбивка

                  // Слайдер для выбора теста
                  SizedBox(
                    width: 300,
                    child: SlidingSwitch( // Прописывать в pubspec.yaml, он нестандартный
                      value: false, // всего 2 значения м.б. - это двусторонний слайдер
                      width: 300,
                      onChanged: (bool value) {
                        _thinTesto = value; // обработчиком передаем значения в калькулятор
                        setState(() {
                          _pizzaCalcCost();
                        });
                      },  // параметры "двойного слайдера"
                      height: 34, // высота
                      animationDuration: const Duration(milliseconds: 300), // Анимация, можно менять время
                      onTap: () {}, // обработчики нажатия - пустые, потому что логика задана в onChanged:
                      onDoubleTap: () {},
                      onSwipe: () {},
                      textOff: 'Обычное тесто', // заголовки выбора. Выключено - обычное тесто
                      textOn: 'Тонкое тесто', // включено - тонкое тесто
                      colorOn: const Color(0xFFFFFFFF), // цвета. Цвет текста в состоянии включено
                      colorOff: const Color(0xFFFFFFFF), // -- // -- выключено
                      background: const Color(0xFFECEFF1), // цвет фона
                      buttonColor: const Color(0xFF0079D0), // цвет слайдера активный
                      inactiveColor: const Color(0xFF636f7b), //  цвет слайдера в неактивном состоянии
                    ),
                  ),

                  const SizedBox(height: 19,), // Отбивка

                  // Выбор размера пиццы - слайдер
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.only(left: 20),
                    child: const Text('Размер',
                        style: TextStyle(fontSize: 18, color: Color(0xFF000000),
                            fontWeight: FontWeight.bold),
                            ),
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
                      enableTooltip: false,
                      minorTicksPerInterval: 0,
                      stepSize: 20,
                      onChanged: (dynamic value) {
                        setState(() {
                          _pizzaSize = value;
                          _pizzaCalcCost ();
                        });
                      },
                    ),
                  ),

                  const SizedBox(height: 9,), // Отбивка

                  // Группа соусов
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.only(top: 10, left: 20),
                    child: const Text('Соус:',
                        style: TextStyle(fontSize: 18, color: Color(0xFF000000),
                            fontWeight: FontWeight.bold)),
                  ),

                  RadioListTile<Sauce>(
                    title: const Text('Острый'),
                    // Разворот на надпись слева, а кнопка справа controlAffinity:
                    controlAffinity: ListTileControlAffinity.trailing,
                    value: Sauce.hot, // значение
                    groupValue: _sauce, // в какой группе находится
                    onChanged: _onSauceChanged,  // обработчик
                    // уменьшение расстояния между радиокнопками - visualDensity
                    visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
                  ),

                  // Тонкая горизонтальная линия
                  const Divider(color: Color(0xFFE8E8E8), thickness: 2,),

                  RadioListTile<Sauce>(
                    title: const Text('Кисло-сладкий'),
                    controlAffinity: ListTileControlAffinity.trailing,
                    value: Sauce.sweet,
                    groupValue: _sauce,
                    onChanged: _onSauceChanged,
                    visualDensity: const VisualDensity(horizontal: 0, vertical: -4),),

                  const Divider(color: Color(0xFFE8E8E8), thickness: 2,),

                  RadioListTile<Sauce>(
                    title: const Text('Сырный'),
                    controlAffinity: ListTileControlAffinity.trailing,
                    value: Sauce.cheese,
                    groupValue: _sauce,
                    onChanged: _onSauceChanged,
                    visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
                  ),

                  const Divider(color: Color(0xFFE8E8E8), thickness: 2,),

                  // Дополнительный сыр, переключатель
                  SizedBox(width: 300,
                    child: Card(
                      elevation: 0,
                      color: const Color(0xFFF0F0F0),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)
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
                          Switch(  // Подключаем переключатель выбора + стоимость
                              value: _addCheese,
                              onChanged: (bool value) {
                                setState(() {
                                  _addCheese = value;
                                  _pizzaCalcCost();
                                });
                              }),
                            ],),
                    ),
                  ),

                  const SizedBox(height: 10,), // Отбивка

                  Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.only(left: 25),
                    child: const Text('Стоимость:',
                        style: TextStyle(fontSize: 18, color: Color(0xFF000000),
                            fontWeight: FontWeight.bold)),
                  ),

                  const SizedBox(height: 10,), // Отбивка

                  // Поле для цены
                  SizedBox( width: 300, height: 34,
                    child: Card(
                      //elevation: 0,
                      color: const Color(0xFFECEFF1),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(36)),
                      child: Text('$_pizzaCost руб.',
                        style: const TextStyle(fontSize: 20, color: Color(0xFF000000)),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),

                  const SizedBox(height: 33,), // Отбивка

                  SizedBox(width: 180, height: 50, child:
                  ElevatedButton(onPressed: () {},
                    child: const Text('Заказать'),
                    style: ElevatedButton.styleFrom(
                      // Изменить размер текста внутри кнопки textStyle: const TextStyle(fontSize: 20),
                        textStyle: const TextStyle(fontSize: 20),
                        primary: const Color(0xFF0079D0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(36.0),
                        )
                    ),
                  )
                  ),

                  const SizedBox(height: 33,), // Отбивка
                       ]
              ),
          ),
      ),
    ),
    );
  }
}
