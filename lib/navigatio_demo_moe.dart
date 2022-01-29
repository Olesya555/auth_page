import 'package:flutter/material.dart';

class NavigationDemoMoe extends StatefulWidget {
  const NavigationDemoMoe({Key? key}) : super(key: key);

  @override
  _NavigationDemoState createState() => _NavigationDemoState();
}

class _NavigationDemoState extends State<NavigationDemoMoe> {

// Прописываем маршрутизацию
  @override
  Widget build(BuildContext context) {
    return MaterialApp( // Прописываем маршрутизацию
      //home: const MainScreen(), // если мы прописываем маршрутизацию, то home: убираем,
      // у нас теперь дом - наша главная корневая страница
      initialRoute: '/', // инициализируем корневой каталог, наш "дом"
      routes: {
        '/': (context) => const MainScreen(), // прописываем маршрут главного экрана через стрелочную анонимную функцию
        '/first': (context) => const FirstScreen(),// прописываем маршрут к следующей странице
        '/second': (context) => const SecondScreen (),
        '/third': (context) => const ThirdScreen (),
      },
    );
  }
}

// Выдвижная панель навигации, отображается на экранах
// Подключается по ссылке drawer: navDrawer(context),
Widget navDrawer(context) => Drawer(
  child: ListView(padding: EdgeInsets.zero, children: [
    // Задаем оформление
    DrawerHeader(decoration: const BoxDecoration(
          color: Colors.blue,
  ),
      child: Container(
        height: 100,
        child: Column(
      // параметры выравнивания
      // главная ось mainAxisAlignment - вертикальная, задаём выравнивание по центру
          mainAxisAlignment: MainAxisAlignment.center,
          // вторая ось crossAxisAlignment - горизонтальная, задаём выравнивание по центру
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [ // прописываем состав колонки Container и Text
          Container(
            height: 110, width: 250, // прописываем размер
              child: const Image(image: AssetImage('assets/mnogo.jpg'), // Прописываем картинку
                fit: BoxFit.cover, // Настраиваем расположение изображения - здесь cover - покрыть весь экран
            ),
            ),
             const Text('Навигация', style: TextStyle(fontSize: 18, color: Colors.black),
               textAlign: TextAlign.center,),
  ],
    ),
  ),
),

    // Прописываем дочерние элементы NavigationDrawer
    ListTile( // первая текст-кнопка
      leading: const Icon(Icons.one_k),
      title: const Text('Главная в ящике'),
      visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
      onTap: () { // прописан корневой маршрут - метод обработки нажатий onTap: имя маршрута указываем в виде строковой константы
        //Navigator.pop(context); - а возвратный метод надо писать не здесь, а там куда мы переходим, оттуда мы и делаем возврат
        Navigator.pushNamed(context, '/');
      },
    ),

    const Divider(color: Colors.black38, thickness: 2,), // Разделитель

    ListTile( // вторая тект-кнопка
      leading: const Icon(Icons.two_k),
      title: const Text('1 экран'),
      visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
      onTap: () { // прописан метод обработки нажатий onTap: имя маршрута указываем в виде строковой константы
        Navigator.pushNamed(context, '/first');
      },
    ),

    const Divider(color: Colors.black38, thickness: 2,), // Разделитель

    ListTile( // вторая тект-кнопка
      leading: const Icon(Icons.three_k),
      title: const Text('2 экран'),
      visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
      onTap: () { // прописан метод обработки нажатий onTap: имя маршрута указываем в виде строковой константы
        Navigator.pushNamed(context, '/second');
      },
    ),

    const Divider(color: Colors.black38, thickness: 2,), // Разделитель

    ListTile( // вторая тект-кнопка
      leading: const Icon(Icons.four_k),
      title: const Text('3 экран'),
      visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
      onTap: () { // прописан метод обработки нажатий onTap: имя маршрута указываем в виде строковой константы
        Navigator.pushNamed(context, '/third');
      },
    ),

    const Divider(color: Colors.black38, thickness: 2,), // Разделитель для красоты)

  ]),
);


// Главная страница экран
class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( // Панель AppBar с заголовком, кнопкой и текстовой кнопкой
          title: const Text('Главная страница'), // просто заголовок без кнопок
          actions: <Widget> [ // кнопка-иконка
          IconButton(onPressed:() {}, icon: const Icon(Icons.cached)),
        //Текстовая кнопка, без иконки
          TextButton(
            onPressed: () {},
              child: Text ('Профиль'),
              style: TextButton.styleFrom(primary: Theme.of(context).colorScheme.onPrimary), // стиль прописан в классе.
            ),
    ],
      ),

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

// 1 экран
class FirstScreen extends StatelessWidget {
  const FirstScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( // Панель AppBar с заголовком, кнопкой и текстовой кнопкой
        title: const Text('1 экран'), // просто заголовок без кнопок
        actions: <Widget> [ // кнопка-иконка
          IconButton(onPressed:() {}, icon: const Icon(Icons.cached)),
          //Текстовая кнопка, без иконки
          TextButton(
            onPressed: () {},
            child: Text ('Профиль'),
            style: TextButton.styleFrom(primary: Theme.of(context).colorScheme.onPrimary), // стиль прописан в классе.
          ),
        ],
      ),

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


// 2 экран
class SecondScreen extends StatelessWidget {
  const SecondScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( // Панель AppBar с заголовком, кнопкой и текстовой кнопкой
        title: const Text('2 экран'), // просто заголовок без кнопок
        actions: <Widget> [ // кнопка-иконка
          IconButton(onPressed:() {}, icon: const Icon(Icons.cached)),
          //Текстовая кнопка, без иконки
          TextButton(
            onPressed: () {},
            child: Text ('Профиль'),
            style: TextButton.styleFrom(primary: Theme.of(context).colorScheme.onPrimary), // стиль прописан в классе.
          ),
        ],
      ),

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

// 3 экран
class ThirdScreen extends StatelessWidget {
  const ThirdScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( // Панель AppBar с заголовком, кнопкой и текстовой кнопкой
        title: const Text('3 экран'), // просто заголовок без кнопок
        actions: <Widget> [ // кнопка-иконка
          IconButton(onPressed:() {}, icon: const Icon(Icons.cached)),
          //Текстовая кнопка, без иконки
          TextButton(
            onPressed: () {},
            child: Text ('Профиль'),
            style: TextButton.styleFrom(primary: Theme.of(context).colorScheme.onPrimary), // стиль прописан в классе.
          ),
        ],
      ),

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