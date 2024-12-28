import 'package:flutter/material.dart';
import 'package:flutter_app_tasks/components/task.dart';

class TaskInherited extends InheritedWidget {
  TaskInherited({
    super.key,
    required super.child
  });

  final List<Task> taskList = [
    Task(
        nome: "Aprender Flutter",
        foto: 'assets/images/dash.png',
        dificuldade: 4
    ),
    Task(
        nome: "Treinar",
        foto:'assets/images/treinar.webp',
        dificuldade: 5
    ),
    Task(
        nome: "Meditar",
        foto: 'assets/images/meditar.jpeg',
        dificuldade: 3
    ),
    Task(
        nome: "Correr",
        foto: 'assets/images/correr.jpg',
        dificuldade: 2
    ),
    Task(
        nome: "Nadar",
        foto: 'assets/images/nadar.jpg',
        dificuldade: 2
    ),
    Task(
        nome: "Jogar PS5",
        foto: 'assets/images/jogar.webp',
        dificuldade: 1
    ),
  ];

  void newTask(String name, String photo, int difficulty){
    taskList.add(Task(nome: name, foto: photo, dificuldade: difficulty));
  }

  static TaskInherited of(BuildContext context) {
    final TaskInherited? result =
        context.dependOnInheritedWidgetOfExactType<TaskInherited>();
    assert(result != null, 'No TaskInherited found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(TaskInherited oldWidget) {
    return oldWidget.taskList.length != taskList.length;
  }
}
