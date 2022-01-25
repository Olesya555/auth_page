import 'package:flutter/material.dart';

// Формирование виджета StatefulWidget автоматом.
// Имя класса SwitchesDemoScreen прописываем сами
class SwitchesDemoScreen extends StatefulWidget {
  const SwitchesDemoScreen({Key? key}) : super(key: key);

  @override // Объект класса состояния, создаётся автоматически
  _SwitchesDemoScreenState createState() => _SwitchesDemoScreenState();
}

// Создаём перечисление для группы Radio
enum SkillLevel { junior, middle, senior }

class _SwitchesDemoScreenState extends State<SwitchesDemoScreen> {

  bool _checked = false;  // переменная состояния типа bool
  bool _confirmAgreement = true;  // переменная состояния типа bool
  SkillLevel? _skillLevel = SkillLevel.junior; // создаём приватную переменную _skillLevel
  // типа SkillLevel в которой по умолчаанию б. храниться значение junior

  // Создаём функцию для обработчика, чтобы не дублировать код в наших виджетах переключения
  void _onCheckedChange(bool? val) {
    setState(() {  // с методом (логикой) изменения состояния
    _checked = !_checked; // если было 1 состояние, то будет другое (противоположное)
  });}

// Создаём функцию для обработчика для РАДИОКНОПОК (название м.б. любым, но лучше делать схожее
  void _onSkillLevelChanged(SkillLevel? value) {
    setState(() {  // обработчик нажатия
       _skillLevel = value; // указываем, что нажатие становится нашим значением value
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold( // сформировали скелет нашего приложения
          appBar: AppBar(), // Добавили AppBar, чтобы не высчитывать расстояние
          body: Center( //
            child: Column( //
              children: [

                Row( // Организация переключателя Checkbox (флажка) строкой
                  children: [
                    Checkbox(value: _checked,  onChanged: _onCheckedChange
                        // Организация логики переключения, конкретно к каждому Checkbox
                        // onChanged: (val) { // сам флажок
                        // setState(() {  // с методом (логикой) изменения состояния
                        // _checked = !_checked;
                        // });
                        //}
                    ),
                    const Text('Выбор'), // подпись
                  ],
                ),

                // Специальный виджет CheckboxListTile для автоматического формирования Checkbox
                CheckboxListTile(
                    title: const Text('Принять условия соглашения'),
                    value: _confirmAgreement, onChanged: (val) {
                  setState(() {  // с методом (логикой) изменения состояния
                    _confirmAgreement = !_confirmAgreement;
                  });
                }),

                // Организация переключателя Switch (ползунок)
                Row( // Организуем строку для совмещения подписи и переключателя
                  children: [
                    Switch(value: _checked, onChanged: _onCheckedChange),
                    const Text('Включить'),
                  ],
                ),

                // Специальный виджет SwitchListTile для автоматического формирования Switch
                SwitchListTile(
                  title: const Text('Включить'),
                    value: _checked, onChanged: _onCheckedChange),

                const Text('Уровень навыков'),

                //Радиокнопки через RadioListTile. Переменная и перечисление к ним прописаны выше
                RadioListTile<SkillLevel>(
                  title: const Text('junior'), // текст
                  value: SkillLevel.junior, // значение
                  groupValue: _skillLevel,  // относится к какой группе
                  onChanged: _onSkillLevelChanged,
                ),
// оригинал кода 1 кнопки выглядел так, теперь иы это вынесли в отдельную функцию:
//                 onChanged: (SkillLevel? value) {  // обработчик нажатия
//                   setState(() {
//                     _skillLevel = value; // указываем, что нажатие становится нашим значением value
//                   });
//                 },

// 2 радиокнопка
                RadioListTile<SkillLevel>(
                  title: const Text('middle'),
                  value: SkillLevel.middle,
                  groupValue: _skillLevel,
                  onChanged: _onSkillLevelChanged,
                ),
// 3 радиокнопка
                RadioListTile<SkillLevel>(
                  title: const Text('senior'),
                  value: SkillLevel.senior,
                  groupValue: _skillLevel,
                  onChanged: _onSkillLevelChanged,
                ),

              ]
            ),
          ),
        ),
    );
  }
}
