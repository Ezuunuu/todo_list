import 'package:todo_list/model/todo_model.dart';

class TodoGroupModel {
  TodoGroupModel({
    required this.pk, // Database에서 받아올 시 사용할 PK
    this.title,
    this.description,
    this.createdAt,
    this.updatedAt,
    this.todoList,
  });

  final int pk;
  final String? title;
  final String? description;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final List<TodoModel>? todoList;

  factory TodoGroupModel.dummy() {
    return TodoGroupModel(
      pk: -1,
      title: 'Dummy Todo Group',
      description: 'This is Dummy Todo Group.',
      todoList: [
        TodoModel.dummy(),
      ],
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
  }

  TodoGroupModel copyWith({
    int? pk,
    String? title,
    String? description,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<TodoModel>? todoList,
  }) {
    return TodoGroupModel(
      pk: pk ?? this.pk,
      title: title ?? this.title,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      todoList: todoList ?? this.todoList,
    );
  }
}
