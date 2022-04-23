import 'package:clean_architecture_01/src/app/pages/home/home_presenter.dart';
import 'package:clean_architecture_01/src/domain/entities/todo_model.dart';
import 'package:clean_architecture_01/src/domain/repositories/todo_repository.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class HomeController extends Controller {
  final HomePresenter _presenter;

  HomeController(TodoRepository _toDoRepository)
      : _presenter = HomePresenter(_toDoRepository);

  List<TodoModel>? todos;

  @override
  void onInitState() {
    _presenter.getTodos();
    super.onInitState();
  }

  @override
  void initListeners() {
    _presenter.getTodosOnNext = (List<TodoModel>? response) {
      todos = response;
      refreshUI();
    };

    _presenter.getTodosOnError = (e) {};

    _presenter.removeTodoOnComplete = () {};

    _presenter.removeTodoOnError = (e) {};
  }

  void removeTodo(String todoId) {
    _presenter.removeTodo(todoId);
    refreshUI();
  }

  @override
  void dispose() {
    _presenter.dispose();
    super.dispose();
  }
}
