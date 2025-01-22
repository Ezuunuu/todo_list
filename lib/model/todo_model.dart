import 'package:todo_list/model/manager_model.dart';

class TodoModel {
  TodoModel({
    required this.pk, // Database에서 받아올 시 사용할 PK
    this.title,
    this.manager,
    this.content,
    this.date,
  });

  final int pk;
  final String? title;
  final ManagerModel? manager;
  final String? content;
  final DateTime? date;

  factory TodoModel.dummy() {
    return TodoModel(
      pk: -1,
      title: 'Dummy Title',
      manager: ManagerModel.dummy(),
      content: 'Dummy Content',
      date: DateTime.now(),
    );
  }

  TodoModel copyWith({
    int? pk,
    String? title,
    ManagerModel? manager,
    String? content,
    DateTime? date,
  }) {
    return TodoModel(
      pk: pk ?? this.pk,
      title: title ?? this.title,
      manager: manager ?? this.manager,
      content: content ?? this.content,
      date: date ?? this.date,
    );
  }
}
