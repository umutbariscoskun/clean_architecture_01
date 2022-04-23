import 'package:clean_architecture_01/src/domain/entities/todo_model.dart';

abstract class TodoRepository {
  Stream<List<TodoModel>> getTodos();
  Future<void> addTodo(TodoModel todoModel);
  Future<void> removeTodo(String todoId);
}
