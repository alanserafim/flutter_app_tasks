import 'package:flutter/material.dart';
import 'package:flutter_app_tasks/data/task_inherited.dart';
import 'package:flutter_app_tasks/screens/initial_screen.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Tarefas",
      debugShowCheckedModeBanner: false,
      home: TaskInherited(
          child: InitialScreen()
      ),
    );

  }
}
