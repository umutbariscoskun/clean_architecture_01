import 'package:clean_architecture_01/src/domain/entities/todo_model.dart';
import 'package:clean_architecture_01/src/domain/repositories/todo_repository.dart';
import 'package:clean_architecture_01/src/domain/usecases/add_todo.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class AddTodoPresenter extends Presenter {
  late Function addTodoOnComplete;
  late Function addTodoOnError;

  final AddToDo _addToDo;

  AddTodoPresenter(TodoRepository _toDoRepository)
      : _addToDo = AddToDo(_toDoRepository);

  @override
  void dispose() {
    _addToDo.dispose();
  }

  void addTodo(TodoModel todo) {
    _addToDo.execute(_AddTodoObserver(this), AddToDoParams(todo));
  }
}

class _AddTodoObserver extends Observer<void> {
  final AddTodoPresenter _presenter;

  _AddTodoObserver(this._presenter);

  @override
  void onComplete() {
    _presenter.addTodoOnComplete();
  }

  @override
  void onError(e) {
    _presenter.addTodoOnError(e);
  }

  @override
  void onNext(_) {}
}
