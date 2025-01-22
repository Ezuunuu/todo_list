import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_list/controller/todo_list_controller.dart';
import 'package:todo_list/model/manager_model.dart';
import 'package:todo_list/model/todo_model.dart';

class AddTodoAlert extends StatefulWidget {
  AddTodoAlert({super.key});

  @override
  State<AddTodoAlert> createState() => _AddTodoAlertState();
}

class _AddTodoAlertState extends State<AddTodoAlert> {
  final TodoListController _todoListController = Get.find<TodoListController>();

  final TextEditingController _titleController = TextEditingController();

  final TextEditingController _contentController = TextEditingController();

  late DateTime selectedDate = DateTime.now();

  int? groupIndex;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Row(
        children: [
          Icon(Icons.add),
          SizedBox(width: 15),
          Text('Add Todo'),
        ],
      ),
      content: SizedBox(
          width: 500,
          height: 550,
          child: Column(
            children: [
              Table(
                children: [
                  TableRow(children: [
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('Group'),
                    ),
                    Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: DropdownMenu(
                            enableSearch: false,
                            requestFocusOnTap: false,
                            onSelected: (int? value) => groupIndex = value ?? 0,
                            dropdownMenuEntries: List.generate(
                                _todoListController.todoGroup.length,
                                (int index) {
                              return DropdownMenuEntry(
                                  value: index,
                                  label: _todoListController
                                          .todoGroup[index].title ??
                                      '');
                            }))),
                  ]),
                  TableRow(
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('Title'),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          controller: _titleController,
                          onChanged: (value) {
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('Content'),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          controller: _contentController,
                          onChanged: (value) {
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                  TableRow(children: [
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('Date'),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () async {
                            // 일자를 정하는 DatePicker
                            final DateTime? picked = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2101),
                            );

                            // 시간을 정하는 TimePicker
                            final pickedTime = await showTimePicker(
                                context: context, initialTime: TimeOfDay.now());

                            if (picked != null && pickedTime != null) {
                              setState(() {
                                selectedDate = DateTime(
                                    picked.year,
                                    picked.month,
                                    picked.day,
                                    pickedTime.hour,
                                    pickedTime.minute,
                                    picked.second);
                              });
                            }
                          },
                          child: Row(
                            children: [
                              const Icon(Icons.calendar_month),
                              const SizedBox(
                                width: 4,
                              ),
                              SizedBox(
                                width: 100,
                                child: Center(child: Text(
                                    '${selectedDate.year}-${selectedDate.month.toString().padLeft(2, '0')}-${selectedDate.day.toString().padLeft(2, '0')} ${selectedDate.hour.toString().padLeft(2, '0')}:${selectedDate.minute.toString().padLeft(2, '0')}'),),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ])
                ],
              )
            ],
          )),
      actions: [
        SizedBox(
          width: 200,
          height: 50,
          child: ElevatedButton(
            onPressed: groupIndex != null &&
                    _titleController.text != '' &&
                    _contentController.text != ''
                ? () {
                    _todoListController.create(
                      TodoModel(
                        pk: _todoListController.length +
                            1, // db 연동하여 auto-increment가 되어야 하지만 불가하니 임의로 넣어준다.
                        title: _titleController.text,
                        content: _contentController.text,
                        date: selectedDate,
                        manager: ManagerModel(
                            pk: 3, name: '매니저 4'), // db와 연동하여 담당자를 골라야 함.
                      ),
                      groupIndex!,
                    );

                    _todoListController.update();
                  }
                : null,
            child: const Text('Create'),
          ),
        ),
        const SizedBox(width: 20),
        SizedBox(
          width: 200,
          height: 50,
          child: ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Close'),
          ),
        ),
      ],
    );
  }
}
