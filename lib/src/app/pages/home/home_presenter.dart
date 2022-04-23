import 'package:clean_architecture_01/src/domain/entities/todo_model.dart';
import 'package:clean_architecture_01/src/domain/repositories/todo_repository.dart';
import 'package:clean_architecture_01/src/domain/usecases/get_todos.dart';
import 'package:clean_architecture_01/src/domain/usecases/remove_todo.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class HomePresenter extends Presenter {
  late Function getTodosOnNext;
  late Function getTodosOnError;

  late Function removeTodoOnComplete;
  late Function removeTodoOnError;

  final GetTodos _getTodos;
  final RemoveToDo _removeTodo;

  HomePresenter(TodoRepository _toDoRepository)
      : _getTodos = GetTodos(_toDoRepository),
        _removeTodo = RemoveToDo(_toDoRepository);

  void getTodos() {
    _getTodos.execute(_GetTodosObserver(this));
  }

  void removeTodo(String todoId) {
    _removeTodo.execute(_RemoveTodoObserver(this), RemoveToDoParams(todoId));
  }

  @override
  void dispose() {
    _getTodos.dispose();
    _removeTodo.dispose();
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

class _RemoveTodoObserver extends Observer<void> {
  final HomePresenter _presenter;
  _RemoveTodoObserver(this._presenter);

  @override
  void onComplete() {
    _presenter.removeTodoOnComplete();
  }

  @override
  void onError(e) {
    _presenter.removeTodoOnError(e);
  }

  @override
  void onNext(_) {}
}
