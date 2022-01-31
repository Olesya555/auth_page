// Переделывала преподавательский пример
// Насторила навигацию НАЗАД на 1 и 2 экране - РАБОТАЕТ!
// в панели NavigationDrawer настроена только навигация вперед
// Панель NavigationDrawer прописана так, что отображается на всех экранах!!!


import 'package:flutter/material.dart';

class NavigationDemo extends StatefulWidget {
  const NavigationDemo({Key? key}) : super(key: key);

  @override
  _NavigationDemoState createState() => _NavigationDemoState();
}

class _NavigationDemoState extends State<NavigationDemo> {

// Прописываем маршрутизацию
  @override
  Widget build(BuildContext context) {
    return MaterialApp( // Прописываем маршрутизацию
      //home: const MainScreen(), // если мы прописываем маршрутизацию, то home: убираем,
      // у нас теперь дом - наша главная корневая страница
      initialRoute: '/', // инициализируем корневой каталог, наш "дом"
      routes: {
        '/': (context) => const MainScreen(), // прописываем маршрут главного экрана через стрелочную анонимную функцию
        '/contacts': (context) => const SecondScreen(), // прописываем маршрут ко второй странице
      },
    );
  }
}

// Выдвижная панель навигации, отображается на 1 и втором экране
// Подключается по ссылке drawer: navDrawer(context),
Widget navDrawer(context) => Drawer(
  child: ListView(padding: EdgeInsets.zero, children: [
    // Задаем оформление (цвет и отступ) можно и другие параметры
    // DrawerHeader нужен для смещения пунктов "меню" вниз
    DrawerHeader(
      decoration: const BoxDecoration(
        color: Colors.blue,
      ),
      child: Container(
        height: 200,
      ),
    ),

    // Прописываем дочерние элементы NavigationDrawer
    ListTile( // первая текст-кнопка
      leading: const Icon(Icons.one_k),
      title: const Text("Главная в ящике"),
      onTap: () { // прописан корневой маршрут - метод обработки нажатий onTap: имя маршрута указываем в виде строковой константы
        //Navigator.pop(context); - а возвратный метод надо писать не здесь, а там куда мы переходим, оттуда мы и делаем возврат
        Navigator.pushNamed(context, '/');
      },
    ),
    ListTile( // вторая тект-кнопка
      leading: const Icon(Icons.two_k),
      title: const Text("Контакты"),
      onTap: () { // прописан метод обработки нажатий onTap: имя маршрута указываем в виде строковой константы
        Navigator.pushNamed(context, '/contacts');
      },
    ),
  ]),
);

// Создано 2 экрана: виджет 1 - class MainScreen и виджет 2 class SecondScreen
// 1 экран
class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Главная')), // просто заголовок без кнопок
      // Панель навигации NavigationDrawer - её описание вынесено на верх, чтобы не дублировать код
      drawer: navDrawer(context),
        body: Center(
          child: Column(
            children: [
              ElevatedButton(
                  onPressed: () {
                  Navigator.pushNamed(context, '/contacts');
                  },
                  child: const Text('Перейти в контакты'),
                  ),

              // сама создала - рабочая кнопка возврата назад
              // прописан метод обработки нажатий onTap: имя маршрута без константы!!!
              ElevatedButton(
                  onPressed: () {
                  Navigator.pop(context);
                  },
              child: const Text('Вернуться назад'),
        ),
            ],
          ),
    ),
    );
  }
}

// 2 экран
class SecondScreen extends StatelessWidget {
  const SecondScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Контакты')),
      // Панель навигации NavigationDrawer - её описание вынесено на верх, чтобы не дублировать код
        drawer: navDrawer(context),
        body: Center(
        child: ElevatedButton(
            onPressed: () {
            Navigator.pop(context);
            },
          child: const Text('Вернуться назад'),
        ),
    ),
    );
  }
}

