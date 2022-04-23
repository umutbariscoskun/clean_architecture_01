import 'package:clean_architecture_01/src/app/pages/add_todo/add_todo_presenter.dart';
import 'package:clean_architecture_01/src/domain/entities/todo_model.dart';
import 'package:clean_architecture_01/src/domain/repositories/todo_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class AddTodoController extends Controller {
  final AddTodoPresenter _presenter;

  AddTodoController(TodoRepository _toDoRepository)
      : _presenter = AddTodoPresenter(_toDoRepository);

  String title = "";
  String description = "";
  String imageUrl = "";

  @override
  void initListeners() {
    _presenter.addTodoOnComplete = () {
      Navigator.pop(getContext());
      refreshUI();
    };

    _presenter.addTodoOnError = (e) {};
  }

  void onTitleTextFieldChanged(String value) {
    title = value;
    refreshUI();
  }

  void onDescriptionTextFieldChanged(String value) {
    description = value;
    refreshUI();
  }

  void onImageUrlTextFieldChanged(String value) {
    imageUrl = value;
    refreshUI();
  }

  void onAddButtonPressed() {
    final TodoModel todo = TodoModel(
      DateTime.now().millisecondsSinceEpoch.toString(),
      title,
      description,
      imageUrl,
    );
    _presenter.addTodo(todo);
    refreshUI();
  }

  @override
  void dispose() {
    _presenter.dispose();
    super.dispose();
  }
}
