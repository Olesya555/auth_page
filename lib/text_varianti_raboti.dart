import 'package:flutter/material.dart';

class TextDemoScreen extends StatelessWidget {
  const TextDemoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        // Container обернули в начале в Scaffold, а потом в MaterialApp
        // у MaterialApp дочка -  home: Scaffold(
        // а у Scaffold дочка - body: Container(
        body: Center( // помещаем в центр наш контейнер
          child: Container(
            width: 200, // задали ширину
            height: 200, // задали  высоту
            decoration: BoxDecoration(
              color: Colors.lightBlue,
                border: Border.all(color: Colors.blueAccent, // оформление рамки
                    // задаём ширину рамки
                    width: 5),
            ),
            alignment: Alignment.center, // Нахождение в центре контейнера
            child: const Text('Просто длинный длинный длинный длинныйтекст',
              // textDirection: TextDirection.ltr, // Задали направление текста
              overflow: TextOverflow.clip, // Параметр обрезки текста
              softWrap: true, // Делает перенос текста по словам обычно стоит по умолчанию true.
            ),
          ),
        ),
      ),
    );
  }
}
