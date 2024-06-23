import "package:flutter/material.dart";
import "package:todo_app/home_screen.dart";
import "package:hive_flutter/hive_flutter.dart";
import "package:todo_app/person.dart";
import './our_box.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(PersonAdapter());
  ourBox = await Hive.openBox<Person>("mybox");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp ({ super.key });
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(useMaterial3: true),
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
    );
  }
}