import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StartScreen1 extends StatelessWidget {
  const StartScreen1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHome(title: 'Страница приветствия'),
        );
  }
}

class MyHome extends StatefulWidget {
  const MyHome({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomeState createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {

  dynamic _name;

  @override
  void initState() {
    super.initState();// метод initState - происходит инициализация состояния и загрузка данных
    _loadName(); // нижнее подчеркивание _ - это приватность данных для "внутренного пользования", они не доступны извне
  }

  // Загрузка данных по счетчику. Вызывается однократно при старте приложения, точнее при инициализации состояния нашего виджета
  //Loading counter value on start
  void _loadName() async { // переменная, отвечающая за загрузку данных, идёт в режиме async (асинхронном)
    final prefs = await SharedPreferences.getInstance(); // получение ссылки на объект SharedPreferences (классическое получение)
    setState(() { // в методе setState происходит установка значения нашего счетчика, переменной _counter
      _name = (prefs.getString('name') ?? 0);  // с помощью классической конструкции null safety
    }); // если у нас при первой загрузке, в счетчике еще не было значения, то преиенная получит значение "0"
  }

  // Сохранение данных по счетчику
  //Incrementing counter after click
  void _newName() async { // приватная переменная "Увеличение счетчика" (_incrementCounter), идёт в асинхроне
    // потому что внутри у него используется ключевое слово await - ожидание, потому что операция м. занимать время, и нужно
    // дождаться завершения текущей операции, чтобы перейти к следующей
    final prefs = await SharedPreferences.getInstance(); // получение ссылки на объект SharedPreferences (классическое получение)
    // идет получение ссылки на результат счётчика
    setState(() { //и только потом выполняетя строка с командой "увеличение результата счетчика на +1" с защитой от  null
      _name = (prefs.getString('name') ?? 0); // если просто использовать getInt, то в случае пустого значения у нас
      // бы возникла ошибка, потому что прибавлять к значению null +1 это ошибка.
      prefs.setString('name', _name); // после увеличения счетчика мы его записываем в файл настроек с тем же самым ключом 'counter'
    });
  }

  final myController = TextEditingController();
  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {

    const borderStyle1 = OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(36)),
        borderSide: BorderSide(color: Colors.red, width: 2));

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
              children: [

                const Text('Введите, пожалуйста, Ваш логин',
                  style: TextStyle(fontSize: 20, color: Colors.black),
                  textAlign: TextAlign.center, // Расположение текста по центру
                ),

                const SizedBox(height: 30,), // Отбивка

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40.0),
                  child: TextField(
                    decoration: const InputDecoration(
                      filled: true,
                      fillColor: Colors.white24,
                      enabledBorder: borderStyle1,
                      focusedBorder: borderStyle1,
                    ),
                    controller: myController,
                  ),
                ),
                const SizedBox(height: 50,), // Отбивка

                SizedBox(width: 180, height: 50,
                  child: ElevatedButton(
                    onPressed: _newName,

                    child: const Text('Войти'),
                      style: ElevatedButton.styleFrom(
                      textStyle: const TextStyle(fontSize: 20),
                      primary: Color(0xFF0079D0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(36.0),),
                    ),
                  ),

                ),
                const SizedBox(height: 20,), // Отбивка
                Text(
                  'Здравствуйте, $_name',
                ),
          ],
          ),
        ),
      ),
    );
  }
}

  class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( // Панель AppBar с заголовком, кнопкой и текстовой кнопкой
        title: const Text('1 экран'), // просто заголовок без кнопок

    ),
    );
  }
  }
