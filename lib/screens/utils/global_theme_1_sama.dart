import 'package:flutter/material.dart';

ThemeData globalTheme1() => ThemeData(
  fontFamily: 'Georgia', // шрифт указали
  splashColor: Colors.blueGrey, // цвет для обозначения нажатия на разные кнопки навигации
// Цветовая тема, задается через спец. метод fromSwatch класса colorScheme
  colorScheme: ColorScheme.fromSwatch(
    brightness: Brightness.light, // задаём яркость, всего 2 режима светлый и темный
    primarySwatch: Colors.indigo, // главный, первичный цвет темы
  ).copyWith(
    secondary: Colors.lightBlueAccent, // вторичный цвет или цвет акцента
  ),
// Текстовая тема
  textTheme: const TextTheme(
    headline1: TextStyle(fontSize: 40.0, fontWeight: FontWeight.bold),
    headline6: TextStyle(fontSize: 20.0, color: Colors.purple, fontStyle: FontStyle.italic),
    bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Open Sans', color: Colors.amber),
  ),
);