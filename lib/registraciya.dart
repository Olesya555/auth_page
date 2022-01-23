import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const borderStyle = OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(36)),
        borderSide: BorderSide(
            color: const Color(0xFFbbbbbb), width: 2));

    const linkTextStyle = TextStyle(
        fontSize: 16, color: Color(0xFFC4C4C4),);

    const linkTextStyle1 = TextStyle(
          fontSize: 20,
          color: Color.fromRGBO(0, 0, 0, 0.6));

    return MaterialApp(
      home: Scaffold(
        body:Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 50), // отступ по краям
        child: SingleChildScrollView( // Добавили скроллинг
          child: Column(children: [

            SizedBox(height: 60,), // Отбивка

            // Верхушка. Заголовок страницы
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: Row (
              children: [
                Icon(Icons.people, color: Color(0xFF5C5C5C), size: 30),
                SizedBox(width: 20,),
                Text('Регистрация',
                  style: linkTextStyle,
                  textAlign: TextAlign.center,),
              ],
              ),
            ),

            Divider( // Тонкая горизонтальная линия
                color: Color(0xFFC4C4C4),
                height: 20,
                thickness: 2,
            ),

            const Text('Чтобы зарегистрироваться введите свой номер телефона и почту',
              style: linkTextStyle,
              textAlign: TextAlign.center, // Расположение текста по центру
            ),

            SizedBox(height: 14,), // Отбивка

            const Text('Телефон',
              style: linkTextStyle1,),

            SizedBox(height: 6,), // Отбивка

            // Текстовое поле для ввода телефона
            const TextField(
              decoration: InputDecoration(
                filled: true,
                fillColor: Color(0xffeceff1),
                enabledBorder: borderStyle,
                focusedBorder: borderStyle,
                hintText: '+7', // hintText: текст-подсказка, исчезает при вводе
              ),
              keyboardType: TextInputType.phone,
            ),

            SizedBox(height: 14,), // Отбивка

            const Text('Почта',
              style: linkTextStyle1,),

            SizedBox(height: 6,), // Отбивка

            // Текстовое поле для ввода почты
            const TextField(
              decoration: InputDecoration(
                filled: true,
                fillColor: Color(0xffeceff1),
                enabledBorder: borderStyle,
                focusedBorder: borderStyle,
              ),
            ),

            SizedBox(height: 24,),  // Отбивка

            const Text('Вам придет четырехзначный код, который будет вашим паролем',
              style: linkTextStyle,
              textAlign: TextAlign.center, // Расположение текста по центру
            ),

            SizedBox(height: 14,),  // Отбивка

            const Text('Изменить пароль можно будет в личном кабинете после регистрации',
              style: linkTextStyle,
              textAlign: TextAlign.center, // Расположение текста по центру
            ),

            SizedBox(height: 32,),  // Отбивка

            // Кнопка отправить код
            SizedBox(width: 180, height: 50, child:
            ElevatedButton(onPressed: () {},
              child: const Text('Отправить код'),
              style: ElevatedButton.styleFrom(
                // Изменить размер текста внутри кнопки textStyle: const TextStyle(fontSize: 20),
                  textStyle: const TextStyle(fontSize: 20),
                  primary: Color(0xFF0079D0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(36.0),
                  )
              ),
            )
            ),
      ],
    ),
    ),
   ),),);
  }
}
