import 'dart:async'; // пакет для работы с асинхронными операциями
import 'dart:io'; // пакет для работы с операциями ввода/вывода

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart'; // пакет path_provider для работы с файлами
// импортировать через прописывание
// зависимости dependencies: shared_preferences: ^2.0.12 в файле //pub   spec.yaml//

// Разбираем пример хранения данных в ФАЙЛАХ, так же пример со счётчиком

// Запускать через вызов функции FilesDemoScreen
class FilesDemoScreen extends StatelessWidget { // // Виджет без состояния, обязательно идём через него
  const FilesDemoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Reading and Writing Files',
      home: FlutterDemo(storage: CounterStorage()), // применяется виджет FlutterDemo (у него есть состояние) и применяется
      // параметр storage: - это мы создаём класс-хранилище
    );
  }
}

// Вспомогательный класс, обязательный, который предназначен для хранения данных
// здесь операции со счётчиком: записать счётчик, прочитать его
class CounterStorage {
  Future<String> get _localPath async { // реализован метод получения локальной папки _localPath
    final directory = await getApplicationDocumentsDirectory();

    return directory.path; // получаем папку, где будут храниться наши файлы (папка документов пользователя)
  }

  Future<File> get _localFile async { // метод _localFile создаёт ссылку на файл
    final path = await _localPath;
    return File('$path/counter.txt'); // и прописывает имя
  }

  Future<int> readCounter() async { // считывание значений из файла с механизмом обработки исключительных ситуаций
    try {
      final file = await _localFile;

      // Read the file
      final contents = await file.readAsString();

      return int.parse(contents); // возвращение не просто числа, а строкового значения, его надо распарсить
    } catch (e) {
      // If encountering an error, return 0
      return 0;
    }
  }

  Future<File> writeCounter(int counter) async { // запись в файл
    final file = await _localFile;

    // Write the file
    return file.writeAsString('$counter'); // в качестве данных выступает числовое значение счетчика
    // знаечние счетчика б. храниться в файле.
    // и возвращаться текущее значение счётчика
  }
  }

// виджет с состоянием
// обязательный параметр required this.storage (это хранилище) - у нас использыется параметр,
// прописанный в самом начале: home: FlutterDemo(storage: CounterStorage() - конструктор CounterStorage
// и ссылка на этот объект сохраняется в этом виджите
// Это такое грамотное разделение логики на 2 виджета ( с состоянием (счётчик) и без состояния (класс-хранилище)).
// Можно, конечно реализовать и в 1 виджете, но это не очень удобно с точки зрения сопровождения такого кода

class FlutterDemo extends StatefulWidget {
  const FlutterDemo({Key? key, required this.storage}) : super(key: key);

  final CounterStorage storage;

  @override
  _FlutterDemoState createState() => _FlutterDemoState();
}

class _FlutterDemoState extends State<FlutterDemo> {
  int _counter = 0; // переменная счётчика

  @override
  void initState() { // метод инициализации состояния
    super.initState();
    widget.storage.readCounter().then((int value) { // здесь идет обращение к виджету хранилища
      // через метод readCounter() - считать счетчик. Используется  синтаксис работы с Future-объектами then((int value)
      // поскольку это операция "будущего" - счетчик-то еще не записан
      // т.е. метод вызовется только после полной загрузки данных
      setState(() {
        _counter = value; // используется загруженное значение присвоив его локальной переменной, которое хранится внутри  _counter
      });
    });
  }

  Future<File> _incrementCounter() { // метод _incrementCounter - увеличивает значение счётчика, он тоже асинхронный,
    // поскольку все шаги идут друг за другом и ждут выполнения предыдущего
    setState(() { // выполняется через обработчик setState, чтобы виджет состояние поменял и отрисовался в новом состоянии
      _counter++;
    });

    // Write the variable as a string to the file.
    // вызывается метод writeCounter, который в хранилище у нас прописан и принимает текущее значение счётчика
    return widget.storage.writeCounter(_counter);
  }

  // внешне само тело метода build пости не отличеатся от предыдущего примера. Тело прежнее, а логика поменялась
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reading and Writing Files'),
      ),
      body: Center(
        child: Text(
          'Button tapped $_counter time${_counter == 1 ? '' : 's'}.',
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}