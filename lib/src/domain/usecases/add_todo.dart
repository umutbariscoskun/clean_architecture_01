import 'dart:async';

import 'package:clean_architecture_01/src/domain/entities/todo_model.dart';
import 'package:clean_architecture_01/src/domain/repositories/todo_repository.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class AddToDo extends UseCase<void, AddToDoParams> {
  final TodoRepository _toDoRepository;

  AddToDo(
    this._toDoRepository,
  );

  @override
  Future<Stream<void>> buildUseCaseStream(AddToDoParams? params) async {
    StreamController<void> controller = StreamController();
    try {
      await _toDoRepository.addTodo(params!.toDo);
      controller.close();
    } catch (error, stackTrace) {
      print(error);
      print(stackTrace);
      controller.addError(error, stackTrace);
    }
    return controller.stream;
  }
}

class AddToDoParams {
  final TodoModel toDo;

  AddToDoParams(this.toDo);
}
