import 'package:flutter/material.dart';
import 'package:flutterapprepaso/ui/movie_list.dart';

void main() {
  runApp(MyApp());
}

//Aqui llamen a MovieList
class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: MovieList(),
    );
  }
}