import 'package:flutter/material.dart';

ThemeData globalTheme() => ThemeData(
  fontFamily: 'Georgia', // шрифт указали
  splashColor: Colors.yellow, // цвет для обозначения нажатия на разные кнопки навигации
// Цветовая тема, задается через спец. метод fromSwatch класса colorScheme
  colorScheme: ColorScheme.fromSwatch(
    brightness: Brightness.light, // задаём яркость, всего 2 режима светлый и темный
    primarySwatch: Colors.orange, // главный, первичный цвет темы
  ).copyWith(
    secondary: Colors.green, // вторичный цвет или цвет акцента
  ),
// Текстовая тема
  textTheme: const TextTheme(
    headline1: TextStyle(fontSize: 60.0, fontWeight: FontWeight.bold),
    headline6: TextStyle(fontSize: 30.0, color: Colors.cyanAccent, fontStyle: FontStyle.italic),
    bodyText2: TextStyle(fontSize: 16.0, fontFamily: 'Hind', color: Colors.pink),
  ),
);