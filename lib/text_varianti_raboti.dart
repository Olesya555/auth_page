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
          child: Column( // Делаем колонку, в которую будем помещать контейнеры с текстом
            children: [ // дети колонки - наши 2 контейнера
              Container(
                // Параметры контейнера и его украшательство
                width: 200, // задали ширину
                height: 200, // задали  высоту
                margin: const EdgeInsets.only(top: 50), // задали отступ только сверху
                decoration: BoxDecoration( // Оформляем контейнер
                  color: Colors.lightBlue, // задали цвет для контейнера
                    border: Border.all(color: Colors.blueAccent, // оформление рамки
                        // задаём ширину рамки
                        width: 5),
                ),
                alignment: Alignment.center, // Нахождение в центре контейнера

                // Текст внутри контейнера
                child: const Text('Просто длинный длинный длинный длинныйтекст',
                  // textDirection: TextDirection.ltr, // Задали направление текста
                  overflow: TextOverflow.clip, // Параметр обрезки текста
                  softWrap: true, // Делает перенос текста по словам обычно стоит по умолчанию true.
                  style: TextStyle(color: Colors.white, fontSize: 18), // сделали цвет текста белым
                ),
              ),

              Container(
                width: 200, // задали ширину
                height: 200, // задали  высоту
                margin: const EdgeInsets.only(top: 50), // задали отступ только сверху
                decoration: BoxDecoration(
                  color: Colors.lightBlue,
                  border: Border.all(color: Colors.blueAccent, // оформление рамки
                      // задаём ширину рамки
                      width: 5),
                ),
                alignment: Alignment.center, // Нахождение в центре контейнера

                // Пример Text.rich - Работа с "богатым" текстом
                child: const Text.rich( // Пример Text.rich
                  TextSpan(text: "Фрагмент", // Родительский элемент, которому мы прописываем общий стиль
                      style: TextStyle(color: Colors.white, fontSize: 18),
                      children: <TextSpan> [ // далее организуем "дочек" с изменениями в стиле
                      TextSpan(text: " стилизованного", style: TextStyle(fontWeight: FontWeight.bold)), // полужирный текст
                      TextSpan(text: " текста", style: TextStyle(fontStyle: FontStyle.italic)), // курсив
                    ]
                  )
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
