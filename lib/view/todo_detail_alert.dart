import 'package:flutter/material.dart';
import 'package:todo_list/model/todo_model.dart';
import 'package:intl/intl.dart';

class TodoDetailAlert extends StatelessWidget {
  const TodoDetailAlert({
    super.key,
    required this.todo,
  });

  final TodoModel todo;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(children: [
        const SizedBox(width: 10),
        Text(
          todo.title ?? '',
        ),
      ]),
      content: SizedBox(
        height: 100,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('내용: ${todo.content ?? ''}'),
            Text('날짜: ${DateFormat('yyyy-MM-dd kk:mm').format(todo.date!)}'),
            Text('담당자: ${todo.manager?.name ?? '-'}')
          ],
        ),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SizedBox(
              height: 50,
              child: TextButton(
                child: const Text("Close"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            )
          ],
        )
      ],
    );
  }
}
