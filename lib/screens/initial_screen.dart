import 'package:flutter/material.dart';
import 'package:flutter_app_tasks/data/task_dao.dart';
import 'package:flutter_app_tasks/data/task_inherited.dart';
import 'package:flutter_app_tasks/screens/form_screen.dart';

import '../components/task.dart';

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
        actions: [
          IconButton(
              onPressed: (){
                setState((){});},
              icon: Icon(
                Icons.refresh,
                color: Colors.white,
                size: 28,

              ),
          )
        ],
        backgroundColor: Colors.blue,
        title: Text(
          "Tarefas",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 8, bottom: 70),
        child: FutureBuilder<List<Task>>(
          future: TaskDao().findAll(),
          builder: (context, snapshot) {
            List<Task>? items = snapshot.data;
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return Center(
                  child: Column(
                    children: [CircularProgressIndicator(), Text('Carregando')],
                  ),
                );
              case ConnectionState.waiting:
                return Center(
                  child: Column(
                    children: [CircularProgressIndicator(), Text('Carregando')],
                  ),
                );
              case ConnectionState.active:
                return Center(
                  child: Column(
                    children: [CircularProgressIndicator(), Text('Carregando')],
                  ),
                );
              case ConnectionState.done:
                if (snapshot.hasData && items != null) {
                  if (items.isNotEmpty) {
                    return ListView.builder(
                      itemCount: items.length,
                      itemBuilder: (BuildContext context, int index) {
                        final Task tarefa = items[index];
                        return tarefa;
                      },
                    );
                  }
                  return Center(
                    child: Column(
                      children: [
                        Icon(Icons.error_outline, size: 128),
                        Text(
                          'Não há nenhuma tarefa',
                          style: TextStyle(fontSize: 32),
                        ),
                      ],
                    ),
                  );
                }
                return Text('Erro ao carregar tarefas');
            }
            return Text("Erro desconhecido");
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (contextNew) => FormScreen(taskContext: context),
            ),
          ).then((value) => setState(() => {}));
        },
        backgroundColor: Colors.blue[50],
        child: Icon(Icons.add, color: Colors.black),
      ),
    );
  }
}
