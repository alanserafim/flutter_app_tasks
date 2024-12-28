import 'package:flutter/material.dart';
import 'package:flutter_app_tasks/components/difficulty.dart';

class Task extends StatefulWidget {
  final String nome;
  final String foto;
  final int dificuldade;

  Task({
    super.key,
    required this.nome,
    required this.foto,
    required this.dificuldade
  });
  int nivel = 0;
  int maestria = 1;

  @override
  State<Task> createState() => _TaskState();
}

class _TaskState extends State<Task> {
  bool assetOrNetwork(){
    if(widget.foto.contains("http")){
      return false;
    }
    return true;
  }

  Color getButtonColor() {
    switch (widget.maestria) {
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
                        child: assetOrNetwork() ? Image.asset(
                          widget.foto,
                          fit: BoxFit.cover,
                        ) : Image.network(
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
                              if(widget.maestria <= 5 && (widget.nivel / widget.dificuldade) / 10 < 1) widget.nivel++;
                              if((widget.nivel / widget.dificuldade) / 10 == 1) {
                                if(widget.maestria < 5){
                                  widget.nivel = 0;
                                  widget.maestria++;
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
                          value: (widget.dificuldade > 0) ? (widget.nivel / widget.dificuldade ) / 10 : 1,
                        )
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Nível ${widget.nivel}",
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