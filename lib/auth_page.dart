import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    const borderStyle = OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(36)),
        borderSide: BorderSide(
            color: const Color(0xFFbbbbbb), width: 2));
    const linkTextStyle = TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Color(0xFF0079D0)
    );

    return MaterialApp(
      home: Scaffold(
          body:Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 50), // отступ по краям
            child: SingleChildScrollView( // Добавили скроллинг
              child: Column(children: [
                SizedBox(height: 150,), // Отбивка

                SizedBox(width: 110, height: 84, child: Placeholder(),),

                SizedBox(height: 20,), // Отбивка

                const Text('Введите логин в виде 10 цифр номера телефона',
                  style: TextStyle(fontSize: 18, color: Color.fromRGBO(0, 0, 0, 0.6)),
                    textAlign: TextAlign.center, // Расположение текста по центру
                ),

                SizedBox(height: 20,), // Отбивка

                const TextField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Color(0xffeceff1),
                    enabledBorder: borderStyle,
                    focusedBorder: borderStyle,
                    hintText: '+7', // hintText: текст-подсказка, исчезает при вводе
                    labelText: 'Телефон',
                  ),
                  keyboardType: TextInputType.phone,
                ),

                SizedBox(height: 20,), // Отбивка

                const TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Color(0xffeceff1),
                    enabledBorder: borderStyle,
                    focusedBorder: borderStyle,
                    labelText: 'Пароль',
                  ),
                ),

                SizedBox(height: 28,), // Отбивка

                SizedBox(width: 180, height: 50, child:
                ElevatedButton(onPressed: () {},
                  child: const Text('Войти'),
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

                SizedBox(height: 32,), // Отбивка

                InkWell(child: const Text('Регистрация', style: linkTextStyle,
                ), onTap: () {}),

                SizedBox(height: 20,), // Отбивка

                InkWell(child: const Text('Забыли пароль?', style: linkTextStyle,
                ), onTap: () {}),
              ],),
            ),
          )
      ),
    );
  }
}
