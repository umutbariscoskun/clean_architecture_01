import 'dart:async';

import 'package:clean_architecture_01/src/domain/entities/todo_model.dart';
import 'package:clean_architecture_01/src/domain/repositories/todo_repository.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class GetTodos extends UseCase<List<TodoModel>, void> {
  final TodoRepository _toDoRepository;
  final StreamController<List<TodoModel>> _controller;

  GetTodos(this._toDoRepository) : _controller = StreamController.broadcast();

  @override
  Future<Stream<List<TodoModel>?>> buildUseCaseStream(void params) async {
    try {
      _toDoRepository.getTodos().listen((List<TodoModel> todos) {
        if (!_controller.isClosed) _controller.add(todos);
      });
    } catch (error, stackTrace) {
      print(error);
      print(stackTrace);
      _controller.addError(error, stackTrace);
    }
    return _controller.stream;
  }

  @override
  void dispose() {
    _controller.close();
    super.dispose();
  }
}
