import 'package:flutter/material.dart';

class ListViewScreen extends StatelessWidget {
  const ListViewScreen({Key? key}) : super(key: key);

  // Описание направленности для виджета списка???
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          body: SimpleList() // сюда вставляем имя нужного списка и запускаем
      ),
    );
  }
}

// Делаем собственный виджет, наследника StatelessWidget - без состояния
class MyListItem extends StatelessWidget {
  // прописываем доп. параметр required this.number - номер элемента в нашем списке
  const MyListItem({Key? key, required this.number}) : super(key: key);

  //final String text;
  final int number; // чтобы номер отображался, объявляем переменную final int number.
  // Она инициализируется в конструкторе

  // Виджет вынесенный из общего кода, который описывает наше оформление списка
  @override
  Widget build(BuildContext context) {
    return Container( // возвращаем контейнер
      padding: EdgeInsets.all(20), // прописываем внутренний отступ
      margin: EdgeInsets.all(5), // прописываем внешний отступ
      decoration: BoxDecoration( // задаём оформление
          color: Colors.lightBlueAccent, // цвет фона
          border: Border.all() // рамка
      ),
      // Создаем текстовый элемент, который б. отображать в т.числе и номер
      child: Text("Элемент # $number", style: Theme.of(context).textTheme.headline6),
    );
  }
}

// Пример формирования класса и скролируемого списка - простой способ
class SimpleList extends StatelessWidget {
  const SimpleList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView( // возвращаем ListView
      scrollDirection: Axis.vertical, // параметр (скроллинг и ориентация будут вертикальными)
      //children: [
        // Пример списка с применением собственного виджета - списка со своей темой оформления и текстом
        //     MyListItem(number: 1),
        //     MyListItem(number: 2),
        //     MyListItem(number: 3),
        //     MyListItem(number: 4),
        //     MyListItem(number: 5),
        //     MyListItem(number: 6),
        //     MyListItem(number: 7),
        //     MyListItem(number: 8),
        //     MyListItem(number: 9),
        //     MyListItem(number: 10),
        //     MyListItem(number: 11),
        //     MyListItem(number: 12),

        // Пример с текстовыми строками
        // Text('первый'),
        // Text('второй'),
        // Text('второй'),

// пример списка с 2 элеметами: иконками и текстом
     //стандартный виджет
      children: const <Widget>[
        ListTile(
          leading: Icon(Icons.map), // иконка
          title: Text('Map'), // текст
        ),
        ListTile(
          leading: Icon(Icons.photo_album),
          title: Text('Album'),
        ),
        ListTile(
          leading: Icon(Icons.phone),
          title: Text('Phone'),
        ),

      ],
    );
  }
}

// Пример формирования класса и скролируемого списка - через генерацию - идет автоформирование
class SimpleListBuilder extends StatelessWidget {
  SimpleListBuilder({Key? key}) : super(key: key);

  //var list = List<int>.generate(50, (i) => i + 1); // генератор. Он использует объект типа List - это параметризированный класс (дженерик).
  // Указываем, что это будет список целочисленных элементов, их будет 50 штук.
  // Задана стрелочная функция каким образом у нас будет вычисляться индекс
  // Этот генератор м. и не использовать, поскольку метод  itemBuilder: на каждом шаге создает элемент MyListItem(number: index);
  // и передаёт ему индекс

  @override
  Widget build(BuildContext context) {
    return ListView.builder(  // Используется не просто виджет ListView, а с методом builder для создания списка
        padding: const EdgeInsets.all(8), // отступы
        itemCount: 20, // задает число элементов - строк списка. если не прописывать, то будет бесконечным список
        itemBuilder: (BuildContext context, int index) { // метод, который принимает 2 параметра: 1. контекст, 2. индекс элемента
          return MyListItem(number: index+1); // возврат список из чисел с индексами
          //в записи index+1 генерируются номера списка с 1, а не с нуля, то есть с этим параметром можно играть)
        }
    );
  }
}

// Пример формирования класса и скролируемого списка с разделителем
class SimpleListSeparated extends StatelessWidget {
  SimpleListSeparated({Key? key}) : super(key: key);

  var list = new List<int>.generate(50, (i) => i + 1); // здесь генератор работает
  //var list = List<int>.generate(50, (i) => i + 1); // генератор. Он использует объект типа List - это параметризированный класс (дженерик).
  // Указываем, что это будет список целочисленных элементов, их будет 50 штук.
  // Задана стрелочная функция каким образом у нас будет вычисляться индекс
  // Этот генератор м. и не использовать, поскольку метод  itemBuilder: на каждом шаге создает элемент MyListItem(number: index);
  // и передаёт ему индекс
  // здесь добавление к i единички не влияет на нумерацию

  @override
  Widget build(BuildContext context) {
    return ListView.separated( // метод separated создаёт список
      padding: const EdgeInsets.all(8), // оформление отступов от экрана
      itemCount: list.length, // длина списка берется из переменной var list
      itemBuilder: (BuildContext context, int index) {  // метод, который принимает 2 параметра: 1. контекст, 2. индекс элемента
        return MyListItem(number: index+1);  // возврат список из чисел с индексами
        // в записи index+1 генерируются номера списка с 1, а не с нуля, то есть с этим параметром можно играть)
      },
      separatorBuilder: (BuildContext context, int index) => const Divider(thickness: 3,), // построение списка, причем разделитель
      // в списке можно самим, или даже вставить туда рекламу
    );
  }
}

// Пример кликабельного списка на основе StatefulWidget
class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10, // количество строк
      itemBuilder: (BuildContext context, int index) { // метод, который принимает 2 параметра: 1. контекст, 2. индекс элемента
        return ListTile( // виджет ListTile - в этом элеенте отображается только текст без значка.
          // ListTile также позволяет отображать 2 элемента, например: текс и значок
          // выделенный элемент в таком списке подсвечивается синим цветом.
          title: Text('Item ${index+1}'), // {index+1} задаём список, чтобы нумерация была с единицы, а не с нуля
          selected: index == _selectedIndex, // логический параметр
          // выделенный элемент в таком списке подсвечивается синим цветом, по идее можно менять цвет подсветки, но нам не говорили как
          onTap: () {
            setState(() {
              _selectedIndex = index; // в обработчике происходит установка состояния - нажато или нет
              // здесь же наверно и прописываются переходы на другие экраны и информацию
            });
          },
        );
      },
    );
  }
}