import 'package:flutter/material.dart';
// Expanded - удобный механизм для создания виджетов, которые могут занимать
// доступное пространство или расширяться
// набираем st, вибираем StatelessWidget, добавляем ExpandedDemoScreen
class ExpandedDemoScreen extends StatelessWidget {
  const ExpandedDemoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold( // "Скелет приложения" размещаем в доме
        appBar: AppBar(), // добавили панель AppBar, чтобы автоматически шёл отступ сверху

        // Чтобы регулировать колонку по нужной нам ширине по которой будет работать Expanded
        // создаём Container
        body: Container( // и здесь уже через padding: задаём нам нужные значения
          padding: EdgeInsets.symmetric(horizontal: 20),

          child: Column( // Для организации сетки элементов нашу строку оборачиваем колонкой
            children: [

// Организация виджетов строкой
              Row(
                children: [ // в Начале текст, потом его обернули виджетом Expanded,
                  // который текст трансформирует под экран
                  Expanded(child: Text("Очень, очень, очень, очень, очень, очень длинный длинный текст",
                  style: TextStyle(fontSize: 18), // Добавили стиль: размер шрифта
                  )),
                ],
              ),

// ещё 1 строка, только в ней организуем 3 контейнера, сразу прописываем Expanded
              Row (
                children: [
                  Expanded (
                    flex: 1, // Виджет для распределения доступного пространства
                    // суммирует значения и каждому распределяет свою долю
                    child: Container( // 1 контейнер
                    height: 100, // высота контейнера
                    color: Colors.red, // цвет берем стандартный из AS
                  ),),
                  Expanded (
                    flex: 2,
                    child: Container( // 2 контейнер
                    height: 100,
                    color: Colors.green,
                  ),),
                  Expanded (
                    flex: 1,
                    child: Container( // 3 контейнер
                    height: 100,
                    color: Colors.blue,
                  ),),
                ],
              ),

// Пример построения строки с текстовым полем по ширине и кнопкой,
// изменение размеров и добавление иконок
              Padding( // можно сделать отступы по краям строки для красоты
                padding: const EdgeInsets.symmetric(horizontal: 10),
// Наша строка с текстовым полем, иконками и кнопкой
                child: Row (
                  children: [
                    Icon (Icons.add_box_outlined), // Добавляем иконку перед текстовым полем
                    Expanded(
                      flex: 2, // распределяем занимаемое пространство внутри строки
                      child: TextField(
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.account_box_rounded), // добавили иконку внутрь TextField
                        ),
                      ),),
                    // На кнопке ElevatedButton обработчик onPressed: пока оставляем пустым () {}
                    Expanded(
                        flex: 1, // распределяем занимаемое пространство внутри строки
                        child: ElevatedButton(onPressed: () {}, child: Text("Войти"))),
                    // Кнопка у нас тоже динамичсески изменяется
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
