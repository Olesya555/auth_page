import 'package:auth_page/pizza_calc_i_interactivnosti.dart';
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
  double _pizzaCost = 170; // стоимость пиццы при параметрах по умолчанию
  bool _addCheese = true; // логическая переменная дополнительный сыр

  // алгоритмика вычисления стоимости пиццы.
  double? _pizzaCalcCost() {

    if (_thinTesto == true) _pizzaCost += 50; // расчет по тесту
    if (_addCheese == true) _pizzaCost += 50; // расчет по сыру

    // расчет по размеру
    switch (_pizzaSize.round()) {
      case 40:
        _pizzaCost += 50;
        break;
      case 60:
        _pizzaCost += 100;
        break;
      default:
        _pizzaCost;
        break;
    }

    // расчет по соусу
    switch (_sauce) {
      case Sauce.sweet:
        _pizzaCost += 50;
        break;
      case Sauce.cheese:
        _pizzaCost += 40;
        break;
      default:
        _pizzaCost;
        break;
    }
    return _pizzaCost;
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
        appBar: AppBar(), // Панель AppBar - отбивка сверху