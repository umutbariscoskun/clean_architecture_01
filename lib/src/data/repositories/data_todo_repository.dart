import 'dart:async';

import 'package:clean_architecture_01/src/domain/entities/todo_model.dart';
import 'package:clean_architecture_01/src/domain/repositories/todo_repository.dart';

class DataTodoRepository implements TodoRepository {
  static final _instance = DataTodoRepository._internal();
  DataTodoRepository._internal();
  factory DataTodoRepository() => _instance;

  StreamController<List<TodoModel>> _streamController =
      StreamController.broadcast();

  List<TodoModel> _todos = [];
  @override
  Stream<List<TodoModel>> getTodos() {
    _initTodos();

    return _streamController.stream;
  }

  void _initTodos() {
    Future.delayed(Duration.zero).then((_) => _streamController.add(_todos));
  }

  @override
  Future<void> addTodo(TodoModel todoModel) async {
    try {
      _todos.add(todoModel);

      _streamController.add(_todos);
    } catch (e, st) {
      print(e);
      print(st);
      rethrow;
    }
  }

  @override
  Future<void> removeTodo(String todoId) async {
    try {
      _todos.remove(_todos.firstWhere((todo) => todo.id == todoId));

      _streamController.add(_todos);
    } catch (e, st) {
      print(e);
      print(st);
      rethrow;
    }
  }
}
