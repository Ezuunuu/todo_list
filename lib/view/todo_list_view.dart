import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_list/controller/todo_list_controller.dart';
import 'package:todo_list/model/todo_model.dart';
import 'package:todo_list/view/todo_detail_alert.dart';

class TodoListView extends StatelessWidget {
  TodoListView({
    super.key,
    this.width = 1200,
    this.height = 1000,
    this.draggedItem,
    this.targetIndex,
  });

  final double width;
  final double height;

  final TodoListController _todoListController = Get.put(TodoListController());

  late TodoModel? draggedItem;
  late int? targetIndex;

  void _onDrag(dynamic details, int listIndex) {
    final fromList = details.data['fromList'];
    final item = details.data['item'];

    _todoListController.onDrag(item, fromList, listIndex, targetIndex);

    // update를 호출하지 않으면 UI가 refresh되지 않음
    _todoListController.update();

    // targetIndex 초기화
    targetIndex = null;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: GetBuilder<TodoListController>(
          init: TodoListController(),
          builder: (_) {
            return Row(
              children: List.generate(_todoListController.todoGroup.length,
                  (listIndex) {
                return Expanded(
                  child: Container(
                    margin: const EdgeInsets.all(5.0),
                    child: DragTarget<Map>(
                      onWillAcceptWithDetails: (data) {
                        return true;
                      },
                      onAcceptWithDetails: (details) =>
                          _onDrag(details, listIndex),
                      builder: (context, candidateData, rejectedData) {
                        return Column(
                          children: [
                            Text(
                                '${_todoListController.todoGroup[listIndex].title}',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold)),
                            const SizedBox(
                              height: 10,
                            ),
                            Expanded(
                              child: ReorderableListView(
                                onReorder: (oldIndex, newIndex) {
                                  _todoListController.onReorder(
                                      oldIndex, newIndex, listIndex);

                                  // update를 호출하지 않으면 UI가 refresh되지 않음
                                  _todoListController.update();
                                },
                                children: List.generate(
                                    _todoListController.todoGroup[listIndex]
                                            .todoList?.length ??
                                        0, (itemIndex) {
                                  final item = _todoListController
                                      .todoGroup[listIndex]
                                      .todoList?[itemIndex];
                                  return Container(
                                    height: 100,
                                    margin: const EdgeInsets.all(2),
                                    key: Key(item!.pk.toString()),
                                    decoration: BoxDecoration(
                                        shape: BoxShape.rectangle,
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.7),
                                            blurRadius: 5.0,
                                            spreadRadius: 0.0,
                                            offset: const Offset(0, 7),
                                          )
                                        ]),
                                    child: DragTarget<Map>(
                                      onWillAcceptWithDetails: (data) {
                                        // 드래그된 항목이 해당 아이템 위에 위치할 때 인덱스를 저장
                                        targetIndex = itemIndex;
                                        return true;
                                      },
                                      onLeave: (_) {
                                        // 드래그가 떠날 때 인덱스 초기화
                                        targetIndex = null;
                                      },
                                      onAcceptWithDetails: (details) =>
                                          _onDrag(details, listIndex),
                                      builder: (context, candidateData,
                                          rejectedData) {
                                        return Draggable<Map>(
                                          data: {
                                            'item': item,
                                            'fromList': listIndex
                                          },
                                          feedback: Material(
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              color: Colors.blue,
                                              child: Text(item.title ?? '',
                                                  style: const TextStyle(
                                                      color: Colors.white)),
                                            ),
                                          ),
                                          child: ListTile(
                                            onTap: () {
                                              showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    return TodoDetailAlert(
                                                      todo: item,
                                                    );
                                                  });
                                            },
                                            key: ValueKey(item),
                                            title: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  item.title ?? '',
                                                  style: const TextStyle(
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                Container(
                                                  padding:
                                                      const EdgeInsets.all(2.0),
                                                  decoration: BoxDecoration(
                                                      color: item.content !=
                                                              null
                                                          ? Colors.purple
                                                          : Colors
                                                              .transparent, // 내용이 없으면 투명 처리
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              3.0)),
                                                  child: Text(
                                                    item.content ?? '',
                                                    style: const TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 10.0),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      item.manager?.name ?? '',
                                                    ),
                                                    item.manager?.profile ??
                                                        const Icon(Icons.person)
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  );
                                }),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                );
              }),
            );
          }),
    );
  }
}
