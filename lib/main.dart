import 'package:flutter/material.dart';
import "./components/random_words.dart";

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  // I don't know what this key feature does
  // What to do: Read up on keys
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "Wordpair Generator",
        theme: ThemeData(primarySwatch: Colors.purple),
        home: const RandomWords());
  }
}
