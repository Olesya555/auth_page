import 'package:auth_page/screens/utils/global_theme.dart';
import 'package:auth_page/screens/utils/strings.dart';
import 'package:flutter/material.dart';

class ThemesDemoApp extends StatelessWidget {
  const ThemesDemoApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: globalTheme(),  // автоматически у меня темы не менялись, нужно вручную прописывать параметр изменения
      home: ThemesDemoScreen(),
    );
  }
}

class ThemesDemoScreen extends StatefulWidget {
  const ThemesDemoScreen({Key? key}) : super(key: key);

  @override
  _ThemesDemoScreenState createState() => _ThemesDemoScreenState();
}

class _ThemesDemoScreenState extends State<ThemesDemoScreen> {
  double _currentSliderValue = 20;  // установлен шаг слайдера
  bool _isDarkTheme = false; // логическая переменна темы День/Ночь

  // Виджет navigationDraw прописан отдельно в анонимной стрелочной функции, которая его формирует и
  // вставляет в "приложение" по ссылке _navigationDraw()
  Widget _navigationDraw() => Drawer(
    child: ListView(
      padding: EdgeInsets.zero, // обязательно нулевые отступы
      children: [
        DrawerHeader( // Заголовок
          decoration: const BoxDecoration(
            color: Colors.blue,
          ),
          child: Container(
            height: 200,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 100,
                  decoration: const BoxDecoration(
                      borderRadius:
                      BorderRadius.all(Radius.circular(50.0))),
                  child: Image.network(
                      "https://upload.wikimedia.org/wikipedia/commons/thumb/4/44/Google-flutter-logo.svg/330px-Google-flutter-logo.svg.png"),
                ),
                const Text("Навигация во Flutter")
              ],
            ),
          ),
        ),
        // Кнопки-иконки с текстом и заголовок на панели navigationDraw
        ListTile(
          leading: const Icon(Icons.one_k),
          title: const Text("Каталог"),
          onTap: () {},
        ),
        ListTile(
          leading: const Icon(Icons.two_k),
          title: const Text("Корзина"),
          onTap: () {},
        ),
        const Divider(), // разделитель Divider
        const Padding(  // Текст на панели
          padding: EdgeInsets.only(left: 10),
          child: Text("Профиль",
              style: TextStyle(
                  color: Colors.grey, fontWeight: FontWeight.bold)),
        ),
        ListTile(
          leading: const Icon(Icons.settings),
          title: const Text("Настройки"),
          onTap: () {},
        ),
      ],
    ),
  );

  //Виджет AppBar прописан отдельно в анонимной стрелочной функции , которая его формирует и
  //возвращает в "приложение" по ссылке _appBar(),
  // PreferredSizeWidget (тип возвращаемого значения) - обязательно указывать - это позволяет
  //  вынести AppBar над функционалом и  сделать кастомный AppBar самим, потом поэксперементируй!!!
  PreferredSizeWidget _appBar() => AppBar(
    title: Text('Демо темы', ), // заголовок
    actions: [
      IconButton( // иконки
        icon: const Icon(Icons.add_alert),
        tooltip: 'Уведомления',
        onPressed: () {},
      ),
      IconButton( // иконки
        icon: const Icon(Icons.settings),
        tooltip: 'Настройки',
        onPressed: () {},
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //theme: globalTheme(),
      home: Scaffold(
        appBar: _appBar(),
        drawer: _navigationDraw(),
        body: SingleChildScrollView( // для скролинга, если на экране будет много элементов, его м.б. прокрутить
          // + если вызывается экранная клавиатуру, она съедает много экранного пространства и скроллинг очень помогает,
          // он убирает ошибку Переполнения по высоте
          child: Center(
            child: Column(
              children: [
                Text('Заголовок', style: Theme.of(context).textTheme.headline1),
                Container(
                  height: 100,
                  color: Theme.of(context).colorScheme.secondary,
                ),
                Row(
                  children:  [
                    Text('Логин: ', style: Theme.of(context).textTheme.headline6), // ('Логин: ') делается физический отступ в тексте, что бы этот же отступ отобразился в поле
                    const Expanded(child: TextField()),
                  ],
                ),
                Row(
                  children:  [
                    Text('Пароль: ', style: Theme.of(context).textTheme.bodyText2),
                    Expanded(child: TextField()),
                  ],
                ),
                ElevatedButton(onPressed: () {}, child: Text('Войти')),
                Text(Strings.longBodyText), // текст в отдельном файле lib/screens/utils/strings.dart импортируем его по ссылке
                Slider(
                  value: _currentSliderValue,
                  max: 100,
                  divisions: 5,
                  label: _currentSliderValue.round().toString(),
                  onChanged: (double value) {
                    setState(() {
                      _currentSliderValue = value;
                    });
                  },
                ),
                SwitchListTile(
                    title: Text('Тёмная тема'),
                    value: _isDarkTheme,
                    onChanged: (val) {
                      setState(() {
                        _isDarkTheme = !_isDarkTheme;
                        if (_isDarkTheme) {

                        }
                      });
                    }),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {  },
          child: Icon(Icons.add),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.account_box), label: 'Профиль'),
            BottomNavigationBarItem(
                icon: Icon(Icons.account_balance), label: 'Баланс'),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings), label: 'Настройки'),
          ],
        ),
      ),
    );
  }
}
