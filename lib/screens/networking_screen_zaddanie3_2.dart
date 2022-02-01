import 'dart:async'; // Работа с сетевыми запросами осуществляется асинхронно, нужен пакет для асинхронной работы
import 'dart:convert'; // Пакет для конвертирования данных, потому что мы б. конвертировать из формата json в объект Dart

import 'package:auth_page/screens/expanded_demo_screen.dart';
import 'package:flutter/material.dart';
import'package:http/http.dart' as http; // Прописываем обязательно пакет http и псевдоним данного пакета as http
// - это для работы с сетью.
// еще не забудь прописать новую зависимость (dependencies:) http: ^0.13.4 (сейчас версия такая, но проверяй обновления
// для работы с  http в файле pub  spec.yaml

// пример загрузки данных 1 объекта из набора альбом

// Делаем сетевой запрос через параметризированный класс Future через асинхронный механизм, когда мы в будущем получим данные типа <...>
Future<Post> fetchPost() async {
  final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts/1')); // здесь интерент-адрес указан учебный
  //final response - получение ответа от сервера, после него мы проверяем статус или результат после выполнения запроса,
  // потому что не всегда данные м.б. получены успешно

  if (response.statusCode == 200) { // у ответов response есть определённый статус , статусы разделяются на несколько групп
    // If the server did return a 200 OK response,      // различные группы статусов есть,например,  200 групппа - это успешные ответы
    // then parse the JSON.           // 300 - это переадрессации redirectiry, 400 статусы - это ошибки,
    return Post.fromJson(jsonDecode(response.body)); // если статус 200, т. е. был успешно получен ответ, то функция Album.fromJson
    // возвращает объект Album сконвертированный из формата json. В качестве ответа мы передам объект body из ответа response
  } else { // если произошла ошибка
    // If the server did not return a 200 OK response,
    // then throw an exception.          // то тогда мы выбрасываем исключение ('Failed to load album') - невозможно загрузить альбом
    throw Exception('Failed to load album');
  }
}   // *** Делаем сетевой запрос через параметризированный класс Future через асинхронный механизм, когда мы в будущем получим данные типа <...>


// Для конвертирования полученных данным мы создаём класс по структуре совпадающий с данными, получаемыми из сети.
// У нас запрос идёт по набору Album, у него 3 поля: userId; id; и title;
class Post { // создаём класс с нужными полями
  final int userId;
  final int id;
  final String title;
  final String body;

  const Post({ // у есть конструктор класса (имя такое же), который принимает 3 поля
    required this.userId, // все поля - обязательны, помечены ключевым словом  required
    required this.id,
    required this.title,
    required this.body,
  });
  // Фабричный метод класса Album, который порождает объекты factory Album
  factory Post.fromJson(Map<String, dynamic> json) { // конвертация идет из формата Json - fromJson(Map<String, dynamic> json)
    // он принимает строковые динамические поля из массива json и вытаскивает из них соответствующие поля и помещает их в
    // поля объекта класса Album
    // Конвертация идет автоматически dart, для этого мы подключали import 'dart:convert';
    return Post( //
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
      body: json['body'],
    );
  }
}  // *** Для конвертирования полученных данным мы создаём класс по структуре совпадающий с данными, получаемыми из сети.

// Создаем класс из StatefulWidget
class NetworkingScreen1 extends StatefulWidget {
  const NetworkingScreen1({Key? key}) : super(key: key);

  @override
  _NetworkingScreen1State createState() => _NetworkingScreen1State();
}

class  _NetworkingScreen1State extends State<NetworkingScreen1> {
  late Future<Post> futurePost; // Описываем наш будущий futureAlbum, здесь есть ключевое слово late - отложенная загрузка
// используется стандартный механизм работы с отложенными операциями Future<Album>

  @override // переопределение метода из родительского класса
  void initState() { // делаем загрузку данных  // т.е. инициализируем или первично настраиваем наш виджет состояния (_...)
    super.initState();  // супер метод initState - позволит нам не загружать данные многократно, а однократно загрузили и инициализировали
    futurePost = fetchPost(); // происходит вызов метода загрузки наших данных из сети
  }

// в начале стандартно строим наш виджет отображения на экране информации
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fetch Data Example',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: Scaffold(
        appBar: AppBar(
          title:  const Text('Fetch Data Example'),
        ),
        body: Center(

          // специальный класс FutureBuilder для построения данных, получаемых из интернета - это ОТЛОЖЕННАЯ  ОТРИСОВКА
          child: FutureBuilder<Post>(  // указываем тип данных <Album>
            future: futurePost, // указываем источник данных, откуда будут они загружены через метод fetchAlbum, который возвращает
            // объект Future<Album> (параметризированный классом альбом)
            builder: (context, snapshot) { // метод builder, который принимает 2 параметра context и snapshot - он позволяет
              // нам обратиться к данным, полученным из сети
              if (snapshot.hasData) {  // Обязательно проверяем, были ли загружены данные, через булевый параметр hasData (да/нет)
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(snapshot.data!.title,
                  style: const TextStyle(color: Colors.purple, fontSize: 30),),
                );
                // // возврат ответа, например, по полю наших данных .title.
                // (если делать по другим полям - смотри внимательно тип данных!!!!)
                // data у нас имеет тип <Album>
                // Так же мы може обратиться к полям (в нашем случае) userId и id;
                // Обязателен ! (восклицательный знак) - это синтаксис защиты nullSafety, чтобы не было ошибки при null
              } else if (snapshot.hasError) {  // если ошибка, то
                return Text('${snapshot.error}'); // вытаскиваем текст ошибки из snapshot.error
              }
// Иначе, по умолчанию, если у нас еще данные не были загружены,
// то тогда возвращается круговой индикатор прогресса (крутилка загрузки данных - loading spinner)
// By default, show a loading spinner.
              return const CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}