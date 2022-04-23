import 'package:clean_architecture_01/src/app/pages/add_todo/add_todo_controller.dart';
import 'package:clean_architecture_01/src/data/repositories/data_todo_repository.dart';
import 'package:clean_architecture_01/src/domain/entities/todo_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class AddTodoView extends View {
  @override
  State<StatefulWidget> createState() {
    return _AddTodoViewState(AddTodoController(DataTodoRepository()));
  }
}

class _AddTodoViewState extends ViewState<AddTodoView, AddTodoController> {
  _AddTodoViewState(AddTodoController controller) : super(controller);
  @override
  Widget get view {
    EdgeInsets padding = MediaQuery.of(context).padding;

    Size size = MediaQuery.of(context).size;
    return Scaffold(
      key: globalKey,
      body: ControlledWidgetBuilder<AddTodoController>(
        builder: (context, controller) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 17),
            child: Column(
              children: [
                SizedBox(height: padding.top),
                TextFormField(
                  onChanged: (value) =>
                      controller.onTitleTextFieldChanged(value),
                  decoration: InputDecoration(
                    label: Text("Title"),
                  ),
                ),
                TextFormField(
                  onChanged: (value) =>
                      controller.onDescriptionTextFieldChanged(value),
                  decoration: InputDecoration(
                    label: Text("Description"),
                  ),
                ),
                TextFormField(
                  onChanged: (value) =>
                      controller.onImageUrlTextFieldChanged(value),
                  decoration: InputDecoration(
                    label: Text("ImageUrl"),
                  ),
                ),
                SizedBox(height: 50),
                GestureDetector(
                  onTap: () => controller.onAddButtonPressed(),
                  child: Container(
                    height: 50,
                    width: 100,
                    color: Colors.blue,
                    child: Icon(Icons.add),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
