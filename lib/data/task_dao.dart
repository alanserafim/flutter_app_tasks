import 'package:flutter_app_tasks/components/task.dart';
import 'package:flutter_app_tasks/data/database.dart';
import 'package:sqflite/sqflite.dart';

class TaskDao {
  static const String tableSql =
      'CREATE TABLE $_tablename('
      '$_name TEXT, '
      '$_difficulty INTEGER, '
      '$_image TEXT)';

  static const String _tablename = 'tasks';
  static const String _name = 'name';
  static const String _difficulty = 'difficulty';
  static const String _image = 'image';

  save(Task tarefa) async {
    print("Iniciando o save");
    final Database bancoDeDados = await getDatabase();
    var itemExists = await find(tarefa.nome);
    Map<String, dynamic> taskMap = toMap(tarefa);
    if (itemExists.isEmpty) {
      print("Tarefa não existente");
      return await bancoDeDados.insert(_tablename, taskMap);
    } else {
      print("Tarefa existente");
      return bancoDeDados.update(
        _tablename,
        taskMap,
        where: '$_name = ?',
        whereArgs: [tarefa.nome],
      );
    }
  }

  Map<String, dynamic> toMap(Task tarefa) {
    print("Convertendo tarefa em map");
    final Map<String, dynamic> mapaDeTarefas = Map();
    mapaDeTarefas[_name] = tarefa.nome;
    mapaDeTarefas[_difficulty] = tarefa.dificuldade;
    mapaDeTarefas[_image] = tarefa.foto;
    print('Mapa de tarefas: $mapaDeTarefas');
    return mapaDeTarefas;
  }

  Future<List<Task>> findAll() async {
    print("Acessando o findAll");
    final Database bancoDeDados = await getDatabase();
    final List<Map<String, dynamic>> result = await bancoDeDados.query(
      _tablename,
    );
    print("Procurando dados no banco de dados ... encontrado: $result");
    return toList(result);
  }

  List<Task> toList(List<Map<String, dynamic>> mapaDeTarefas) {
    print("Convertendo to List");
    final List<Task> tarefas = [];
    for (Map<String, dynamic> linha in mapaDeTarefas) {
      final Task tarefa = Task(
        nome: linha[_name],
        foto: linha[_image],
        dificuldade: linha[_difficulty],
      );
      tarefas.add(tarefa);
    }
    print("Lista de tarefas: $tarefas");
    return tarefas;
  }

  Future<List<Task>> find(String nomeTarefa) async {
    print("Acessando find: ");
    final Database bancoDeDados = await getDatabase();
    final List<Map<String, dynamic>> result = await bancoDeDados.query(
      _tablename,
      where: '$_name = ?',
      whereArgs: [nomeTarefa],
    );
    print("Tarefa encontrada: ${toList(result)}");
    return toList(result);
  }

  delete(String nomeTarefa) async {
    print("Deletando tarefa");
    final Database bancoDeDados = await getDatabase();
    return bancoDeDados.delete(
      _tablename,
      where: '$_name = ?',
      whereArgs: [nomeTarefa],
    );
  }
}
