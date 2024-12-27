import 'package:flutter/material.dart';
import 'package:flutter_app_tasks/data/task_inherited.dart';
import 'package:flutter_app_tasks/screens/form_screen.dart';

class InitialScreen extends StatefulWidget {
  const InitialScreen({super.key});

  @override
  State<InitialScreen> createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(),
        backgroundColor: Colors.blue,
        title: Text(
            "Tarefas",
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold
            )
        ),
      ),
      body: ListView(
        scrollDirection: Axis.vertical,
        children: TaskInherited.of(context).taskList,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(
              context,
              MaterialPageRoute(builder: (contextNew) => FormScreen(taskContext: context)));
        },
        backgroundColor: Colors.blue[50],
        child: Icon(
          Icons.add,
          color: Colors.black,
        ),
      ),
    );
  }
}