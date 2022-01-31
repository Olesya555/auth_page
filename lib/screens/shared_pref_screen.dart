import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart'; // импортировать через прописывание
// зависимости dependencies: shared_preferences: ^2.0.12 в файле //pub   spec.yaml//

// если есть проблема Unhandled Exception: MissingPluginException(No implementation found for method getAll on channel plugins.flutter.io/shared_preferences)
// (Необработанное исключение: исключение MissingPluginException(Не найдена реализация метода GetAll для плагинов канала.flutter.io/shared_preferences ))
// Переподключить и Перезагрузить зависимости в //pub   spec.yaml// и перезагрузиь саму студию, тогда работает

// Разбираем хранение пар "ключ-значение"  на примере счетчика нажатий

// Запускать через вызов функции SharedPrefScreen
class SharedPrefScreen extends StatelessWidget { // Виджет без состояния, обязательно идём через него
  const SharedPrefScreen({Key? key}) : super(key: key);

  // This widget is the root of the application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Shared preferences demo',
      home: MyHomePage(title: 'Shared preferences demo'),
    );
  }
}

class MyHomePage extends StatefulWidget { // Виджет с состоянием - будет показывать экран работы с сохраненными данными
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0; // инициализируем переменную, отвечающую за счетчик

  @override
  void initState() {
    super.initState();// метод initState - происходит инициализация состояния и загрузка данных
    _loadCounter(); // нижнее подчеркивание _ - это приватность данных для "внутренного пользования", они не доступны извне
  }

  // Загрузка данных по счетчику. Вызывается однократно при старте приложения, точнее при инициализации состояния нашего виджета
  //Loading counter value on start
  void _loadCounter() async { // переменная, отвечающая за загрузку данных, идёт в режиме async (асинхронном)
    final prefs = await SharedPreferences.getInstance(); // получение ссылки на объект SharedPreferences (классическое получение)
    setState(() { // в методе setState происходит установка значения нашего счетчика, переменной _counter
      _counter = (prefs.getInt('counter') ?? 0);  // с помощью классической конструкции null safety
    }); // если у нас при первой загрузке, в счетчике еще не было значения, то преиенная получит значение "0"
  }

  // Сохранение данных по счетчику
  //Incrementing counter after click
  void _incrementCounter() async { // приватная переменная "Увеличение счетчика" (_incrementCounter), идёт в асинхроне
    // потому что внутри у него используется ключевое слово await - ожидание, потому что операция м. занимать время, и нужно
    // дождаться завершения текущей операции, чтобы перейти к следующей
    final prefs = await SharedPreferences.getInstance(); // получение ссылки на объект SharedPreferences (классическое получение)
    // идет получение ссылки на результат счётчика
    setState(() { //и только потом выполняетя строка с командой "увеличение результата счетчика на +1" с защитой от  null
      _counter = (prefs.getInt('counter') ?? 0) + 1; // если просто использовать getInt, то в случае пустого значения у нас
      // бы возникла ошибка, потому что прибавлять к значению null +1 это ошибка.
      prefs.setInt('counter', _counter); // после увеличения счетчика мы его записываем в файл настроек с тем же самым ключом 'counter'
    });
  }
// В каком случае будет вызываться увеличение счётчика?
  // Здесь используется пример, похожий на стартовое приложение Flutter, но есть отличие: если мы остановим
  // наше приложение или даже выгрузим из памяти - произведем STOP (красный квадратик на верхней панели Андроид Студии)
  // и сделаем удаление из оперативной памяти телефона, то при повторном его запуске - значение счетчика сохраняется,
  // поскольку был использован внутренний файл на устройстве для сохранения значения счётчика

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // расположение по центру
          children: [
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter', // подставка значения счётчика
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton( // "плавающая" сверху кнопка
        onPressed: _incrementCounter, // в обработчике нажатия вызывается метод _incrementCounter, который не просто
        // увеличивает счётчик, но и сохраняет его в файл настроек
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}