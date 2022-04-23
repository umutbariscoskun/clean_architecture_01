import 'dart:async';

import 'package:clean_architecture_01/src/domain/repositories/todo_repository.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class RemoveToDo extends UseCase<void, RemoveToDoParams> {
  final TodoRepository _toDoRepository;

  RemoveToDo(
    this._toDoRepository,
  );

  @override
  Future<Stream<void>> buildUseCaseStream(RemoveToDoParams? params) async {
    StreamController<void> controller = StreamController();
    try {
      await _toDoRepository.removeTodo(params!.toDoId);
      controller.close();
    } catch (error, stackTrace) {
      print(error);
      print(stackTrace);
      controller.addError(error, stackTrace);
    }
    return controller.stream;
  }
}

class RemoveToDoParams {
  final String toDoId;

  RemoveToDoParams(this.toDoId);
}
