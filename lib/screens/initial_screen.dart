import 'package:flutter/material.dart';
import 'package:flutter_app_tasks/components/task.dart';

class InitialScreen extends StatefulWidget {
  const InitialScreen({super.key});

  @override
  State<InitialScreen> createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  bool opacidade = true;
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
      body: AnimatedOpacity(
        opacity: opacidade ? 1 : 0,
        duration: Duration(milliseconds: 800),
        child: ListView(
          scrollDirection: Axis.vertical,
          children: [
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
            SizedBox(
              height: 80,
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          setState(() {
            opacidade = !opacidade;
          });
        },
        backgroundColor: Colors.blue[50],
        child: Icon(
          opacidade ? Icons.remove_red_eye : Icons.visibility_off,
          color: Colors.black,
        ),
      ),
    );
  }
}