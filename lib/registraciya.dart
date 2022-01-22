import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body:Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 50), // отступ по краям
        child: SingleChildScrollView( // Добавили скроллинг
          child: Column(children: [

            SizedBox(height: 60,), // Отбивка

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: Row (
              children: [
                Icon(Icons.people, color: Color(0xFF5C5C5C), size: 30),
                SizedBox(width: 20,),
                Text('Регистрация',
                  style: TextStyle(color: Color(0xFF5C5C5C), fontSize: 22,
                    fontWeight: FontWeight.bold,),
                ),
              ],
            ),
          ),
            Divider( // Тонкая горизонтальная линия
                color: Color(0xFFC4C4C4),
                height: 20,
                thickness: 2,
            )
      ],
    ),
    ),
   ),),);
  }
}
