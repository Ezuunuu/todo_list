import 'package:flutter/material.dart';
import 'package:todo_list/view/add_todo_alert.dart';
import 'package:todo_list/view/todo_list_view.dart';

class Application extends StatelessWidget {
  const Application({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: TodoListView(),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            showDialog(
                context: context,
                builder: (context) {
                  return AddTodoAlert();
                });
          }),
    );
  }
}
