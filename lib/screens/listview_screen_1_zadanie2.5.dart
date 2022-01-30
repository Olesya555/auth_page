import 'package:flutter/material.dart';

class ListView1Screen extends StatelessWidget {
  const ListView1Screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: ListViewScreen1( // подключаем виджет списка ListViewScreen1
        ),
      ),
    );
  }
}

class ListViewScreen1 extends StatefulWidget { //формируем класс для генерации списка
  const ListViewScreen1({Key? key}) : super(key: key);

  @override
  State<ListViewScreen1> createState() => _ListViewScreen1State();
}

class _ListViewScreen1State extends State<ListViewScreen1> {

  int _selectedIndex = 0;

  @override

  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 20, // количество строк
      itemBuilder: (BuildContext context, int index) { // метод, который принимает 2 параметра: 1. контекст, 2. индекс элемента
        return ListTile( // виджет ListTile - в этом элеенте отображается только текст без значка.
          // ListTile также позволяет отображать 2 элемента, например: текс и значок
          // у меня не получилось (пока не знаю как????) сделать генерацию разных значков
          title: Text('Имя ${index+1}'), // {index+1} задаём список, чтобы нумерация была с единицы, а не с нуля
          selected: index == _selectedIndex, // логический параметр
          selectedTileColor: Colors.green, // Меняем подсветку выбора
          textColor: Colors.red, // Меняем подсветку текста
          selectedColor: Colors.black, // меняем подсветку выбранного текста
          leading: Icon(Icons.accessibility),// иконка, 1 на всех(
          onTap: () {
            setState(() {
              _selectedIndex = index; // в обработчике происходит установка состояния - нажато или нет
              // здесь же наверно и прописываются переходы на другие экраны и информацию
            }
            );
          },
        );
      },
    );
  }
}

