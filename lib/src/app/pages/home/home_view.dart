import 'package:clean_architecture_01/src/app/pages/add_todo/add_todo_view.dart';
import 'package:clean_architecture_01/src/app/pages/home/home_controller.dart';
import 'package:clean_architecture_01/src/data/repositories/data_todo_repository.dart';
import 'package:clean_architecture_01/src/domain/entities/todo_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class HomeView extends View {
  @override
  State<StatefulWidget> createState() {
    return _HomeViewState(
      HomeController(DataTodoRepository()),
    );
  }
}

class _HomeViewState extends ViewState<HomeView, HomeController> {
  _HomeViewState(HomeController controller) : super(controller);
  @override
  Widget get view {
    EdgeInsets padding = MediaQuery.of(context).padding;
    return Scaffold(
      floatingActionButton: ControlledWidgetBuilder<HomeController>(
        builder: (context, controller) {
          return FloatingActionButton(
            child: Icon(
              Icons.add,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddTodoView(),
                  ));
            },
          );
        },
      ),
      key: globalKey,
      body: Column(
        children: [
          Expanded(
            child: Column(
              children: [
                SizedBox(height: padding.top + 20),
                ControlledWidgetBuilder<HomeController>(
                  builder: (context, controller) {
                    if (controller.todos != null &&
                        controller.todos!.isNotEmpty) {
                      return Column(
                        children: [
                          for (int i = 0; i < controller.todos!.length; i++)
                            _TodoCard(
                              controller.todos![i],
                              controller.removeTodo,
                            ),
                        ],
                      );
                    } else {
                      return Center(
                        child: CircularProgressIndicator(
                          color: Colors.blue,
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _TodoCard extends StatelessWidget {
  final TodoModel todoModel;
  final Function(String todoId) removeTodo;

  _TodoCard(this.todoModel, this.removeTodo);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 17),
      width: size.width,
      decoration: BoxDecoration(
        border: Border.all(),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.network(
            todoModel.imageUrl,
            width: 100,
            height: 100,
          ),
          Column(
            children: [
              Text(
                todoModel.title,
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                todoModel.description,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          GestureDetector(
            onTap: () {
              removeTodo(todoModel.id);
            },
            child: Icon(
              Icons.delete,
            ),
          ),
        ],
      ),
    );
  }
}
