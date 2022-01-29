import 'package:flutter/material.dart';

class AppBarScreen extends StatefulWidget {
  const AppBarScreen({Key? key}) : super(key: key);

  @override
  _AppBarScreenState createState() => _AppBarScreenState();
}

class _AppBarScreenState extends State<AppBarScreen> {
  @override
  Widget build(BuildContext context) {
    // Пропишем стиль текстовой кнопки
    final ButtonStyle buttonStyle =
    TextButton.styleFrom(primary: Theme.of(context).colorScheme.onPrimary);

    return MaterialApp(
      home: Scaffold(
        //Создаем AppBar
        appBar: AppBar(
          // Прописываем заголовок AppBar, можем задать тексту стиль и параметры
          title: const Text('Демо AppBar'),
          actions: <Widget> [  // здесь прописываем "дочек" - наши иконки и
            // текстовые кнопки. Они идут в массиве, списком. Скобки []
            // вставляем кнопки-иконки, пока с заглушками на нажатие () {}
            IconButton( // Иконка-кнопка
                tooltip: 'Баланс', // tooltip: подсказка, срабатывает при "зажатии" на кнопку
                onPressed: () {},
                icon: const Icon(Icons.account_balance)),

            IconButton(onPressed:() {}, icon: const Icon(Icons.settings)),

            //Текстовая кнопка, без иконки
            TextButton(
                onPressed: () {},
                child: Text ('Профиль'),
                style: buttonStyle, // стиль прописан в классе.
            ),

          ],
        ),
        body: const Center(child: Text('Контент')),
      ),
    );
  }
}
