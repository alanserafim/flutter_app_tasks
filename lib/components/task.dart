import 'package:flutter/material.dart';
import 'package:flutter_app_tasks/components/difficulty.dart';

class Task extends StatefulWidget {
  final String nome;
  final String foto;
  final int dificuldade;

  const Task({
    super.key,
    required this.nome,
    required this.foto,
    required this.dificuldade
  });

  @override
  State<Task> createState() => _TaskState();
}

class _TaskState extends State<Task> {
  int nivel = 0;
  int maestria = 1;

  Color getButtonColor() {
    switch (maestria) {
      case 1:
        return Colors.blueAccent;
      case 2:
        return Colors.deepPurple;
      case 3:
        return Colors.red;
      case 4:
        return Colors.amber;
      case 5:
        return Colors.green;
      default:
        return Colors.blueAccent;
    }
  }

  @override
  Widget build(BuildContext context) {
    final ButtonStyle style = ElevatedButton.styleFrom(
      backgroundColor: getButtonColor(),
      iconColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0),
      ),
    );
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: getButtonColor(),
            ),
            height: 140,
          ),
          Column(
            children: [
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(4)
                ),
                height: 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: Colors.black26,
                      ),
                      width: 72,
                      height: 100,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: Image.asset(
                          widget.foto,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 200,
                          child: Text(
                            widget.nome,
                            style: TextStyle(
                                fontSize: 24,
                                overflow: TextOverflow.ellipsis
                            ),
                          ),
                        ),
                        Difficulty(difficultyLevel: widget.dificuldade)
                      ],
                    ),
                    SizedBox(
                      height: 64,
                      width: 64,
                      child: ElevatedButton(
                          style: style,
                          onPressed: (){
                            setState(() {
                              if(maestria <= 5 && (nivel / widget.dificuldade) / 10 < 1) nivel++;
                              if((nivel / widget.dificuldade) / 10 == 1) {
                                if(maestria < 5){
                                  nivel = 0;
                                  maestria++;
                                }
                              }
                            });
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Icon(
                                  Icons.arrow_drop_up
                              ),
                              Text(
                                "UP",
                                style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.white
                                ),
                              )
                            ],
                          )
                      ),
                    )
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                        width: 200,
                        child: LinearProgressIndicator(
                          color: Colors.white,
                          value: (widget.dificuldade > 0) ? (nivel / widget.dificuldade ) / 10 : 1,
                        )
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Nível $nivel",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}