import 'package:flutter/material.dart';

class NavigationDrawerScreen extends StatefulWidget {
  const NavigationDrawerScreen({Key? key}) : super(key: key);

  @override
  _NavigationDrawerScreenState createState() => _NavigationDrawerScreenState();
}

class _NavigationDrawerScreenState extends State<NavigationDrawerScreen> {
// Используем глобальный ключ для использования панели SnackBar
  final _messengerKey = GlobalKey<ScaffoldMessengerState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Задаём мессенджер scaffoldMessengerKey, в нём прописываем нашу
      // переменную _messengerKey - обязательный параметр для SnackBar
      scaffoldMessengerKey: _messengerKey,
      home: Scaffold(
        appBar: AppBar(),

        drawer: Drawer( // Панель навигации боковая NavigationDrawer

          child: ListView(  // Список отображения
            padding: EdgeInsets.zero, // Обязательно нулевой отступ

            children: [  // прописываем детей - заголовок, наши строки и иконки

// Заголовок для NavigationDrawer
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Colors.blue,
              ),
               child: Container(
                 height: 200,
                 child: Column(
                   // параметры выравнивания
                   // главная ось mainAxisAlignment - вертикальная, задаём выравнивание по центру
                   mainAxisAlignment: MainAxisAlignment.center,
                   // вторая ось crossAxisAlignment - горизонтальная, задаём выравнивание по центру
                   crossAxisAlignment: CrossAxisAlignment.center,
                   children: [ // прописываем состав колонки Container и Text
                     Container(
                       height: 100,
                       decoration: const BoxDecoration( // скругляем углы, но без фона это не видно
                         borderRadius: BorderRadius.all(Radius.circular(50.0)),
                       ),
                       // Прописываем картинку из интернета
                       child: Image.network("https://upload.wikimedia.org/wikipedia/commons/thumb/4/44/Google-flutter-logo.svg/330px-Google-flutter-logo.svg.png"),
                       ),
                      const Text('Навигация по Flutter'),
                      ],
                     ),
            ),
                   ),

// Блок строк с иконками - меню управления, настроек и т.д.
              ListTile( // строка с иконкой
                // атрибут для отображения иконки или значка - leading:
                leading: const Icon(Icons.one_k),
                title: const Text('Каталог'), // текст
                onTap: () {
// через переменную _messengerKey обращаемся к текущему состоянию currentState и просим
//отобразить SnackBar
//! - обязателен - это защита от нуля
// в сам SnackBar вставляем текст, можно вставить ссылки или кнопки, задать время показа
// в конце обязательна ;
                  _messengerKey.currentState!.showSnackBar(
                      const SnackBar(content: Text ('Переход в Каталог')));
                }, // когда пустой обработчик, ставить заглушку () {}
              ),
              ListTile( // строка с иконкой
                leading: const Icon(Icons.two_k),
                title: const Text('Корзина'),
                onTap: () {
                  _messengerKey.currentState!.showSnackBar(
                      const SnackBar(content: Text('Переход в Корзина')));
                },
              ),

              const Divider(), //разделитель без параметров - просто прямая полоса

              Padding(
                padding: const EdgeInsets.only(left: 15,),
                child: const Text('Профиль'),
              ), // Просто текст без кнопок

              ListTile( // строка с иконкой
                leading: const Icon(Icons.settings),
                title: const Text('Настройки'),
                onTap: () {
                  _messengerKey.currentState!.showSnackBar(
                      const SnackBar(content: Text('Переход в Настройки')));
                },
              ),
            ],
          ),
        ),

// Обозначили главный экран
        body: Center(child: Text('Содержимое экрана')),

      ),
    );
  }
}
