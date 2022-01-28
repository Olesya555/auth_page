import 'package:flutter/material.dart';

class AppBarScreen extends StatefulWidget {
  const AppBarScreen({Key? key}) : super(key: key);

  @override
  _AppBarScreenState createState() => _AppBarScreenState();
}

class _AppBarScreenState extends State<AppBarScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        //Создаем AppBar
        appBar: AppBar(
          // Прописываем заголовок AppBar, можем задать тексту стиль и параметры
          title: const Text('Демо AppBar'),
          actions: <Widget> [
            IconButton(onPressed: () {}, icon: const Icon(Icons.account_balance)),
          ],
        ),
        body: const Center(child: Text('Контент')),
      ),
    );
  }
}
