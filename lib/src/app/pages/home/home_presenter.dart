import 'package:clean_architecture_01/src/domain/entities/todo_model.dart';
import 'package:clean_architecture_01/src/domain/repositories/todo_repository.dart';
import 'package:clean_architecture_01/src/domain/usecases/getTodos.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class HomePresenter extends Presenter {
  late Function getTodosOnNext;
  late Function getTodosOnError;

  final GetTodos _getTodos;

  HomePresenter(TodoRepository _toDoRepository)
      : _getTodos = GetTodos(_toDoRepository);

  void getTodos() {
    _getTodos.execute(_GetTodosObserver(this));
  }

  @override
  void dispose() {
    _getTodos.dispose();
  }
}

class _GetTodosObserver extends Observer<List<TodoModel>> {
  final HomePresenter _presenter;

  _GetTodosObserver(this._presenter);

  @override
  void onComplete() {}

  @override
  void onError(e) {
    _presenter.getTodosOnError(e);
  }

  @override
  void onNext(List<TodoModel>? response) {
    _presenter.getTodosOnNext(response);
  }
}
