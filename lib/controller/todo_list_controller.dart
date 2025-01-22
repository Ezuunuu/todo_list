import 'package:get/get.dart';
import 'package:todo_list/model/manager_model.dart';
import 'package:todo_list/model/todo_group_model.dart';
import 'package:todo_list/model/todo_model.dart';

class TodoListController extends GetxController {
  RxList<TodoGroupModel> todoGroup =
      RxList<TodoGroupModel>.empty(growable: true);

  @override
  void onInit() {
    setTodoGroupModel();
    super.onInit();
  }

  setTodoGroupModel() {
    ManagerModel manager1 = ManagerModel(
        pk: 0,
        name: '매니저 1',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now());
    ManagerModel manager2 = ManagerModel(
        pk: 1,
        name: '매니저 2',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now());
    ManagerModel manager3 = ManagerModel(
        pk: 2,
        name: '매니저 3',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now());

    todoGroup.assignAll([
      TodoGroupModel(
        pk: 0,
        title: '할 일',
        description: '할 일을 정리해둔 TODO 리스트입니다.',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        todoList: [
          TodoModel(
              pk: 0,
              title: '사용자별 접근 데이터 제한',
              content: '시스템 전반',
              date: DateTime.now(),
              manager: manager1),
          TodoModel(
              pk: 1,
              title: '신랑신부님 연락처 뒷번호로 검색 가능',
              content: '시스템 전반',
              date: DateTime.now(),
              manager: manager2),
          TodoModel(
              pk: 2,
              title: '상담 견적서 발행',
              content: '상담',
              date: DateTime.now(),
              manager: manager2),
          TodoModel(
              pk: 3,
              title: '견적서 양식 등룩',
              content: '견적서 설정',
              date: DateTime.now(),
              manager: manager1),
          TodoModel(
              pk: 4,
              title: '상담카드 수정 가능하게 열어두기',
              date: DateTime.now(),
              manager: manager3),
        ],
      ),
      TodoGroupModel(
        pk: 1,
        title: '급한 일',
        description: '급한 일을 정리해둔 TODO 리스트입니다.',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        todoList: [
          TodoModel(
              pk: 5,
              title: 'Wedding cuesheet',
              date: DateTime.now(),
              manager: manager1),
          TodoModel(
              pk: 6,
              title: '직급 세분화 (부장, 실장, 대리, 수석 부장....)',
              date: DateTime.now(),
              manager: manager2),
          TodoModel(
              pk: 7,
              title: 'help button 옆에 사용법 webview로 구현',
              content: '시스템 전반',
              date: DateTime.now(),
              manager: manager2),
          TodoModel(
              pk: 8,
              title: '회원 탈퇴 기능 점검',
              content: '로그인&회원가입',
              date: DateTime.now(),
              manager: manager1),
          TodoModel(
              pk: 9,
              title: 'SMS 전송',
              content: '고객관리',
              date: DateTime.now(),
              manager: manager3),
        ],
      ),
      TodoGroupModel(
        pk: 2,
        title: '진행 중',
        description: '진행 중인 일을 정리해둔 TODO 리스트입니다.',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        todoList: [
          TodoModel(
              pk: 10,
              title: 'firebase 구조 파악 및 칼럼 추출',
              date: DateTime.now(),
              manager: manager1),
        ],
      ),
      TodoGroupModel(
        pk: 3,
        title: '완료',
        description: '완료된 이슈 리스트입니다.',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        todoList: [],
      ),
    ]);
  }

  onReorder(int oldIndex, int newIndex, int listIndex) {
    if (newIndex > oldIndex) newIndex -= 1;
    final item = todoGroup[listIndex].todoList?[oldIndex];
    todoGroup[listIndex].todoList?.remove(item);
    todoGroup[listIndex].todoList?.insert(newIndex, item!);
    todoGroup.refresh();
  }

  onDrag(TodoModel item, int fromIndex, int toIndex, int? targetIndex) {
    todoGroup[fromIndex].todoList?.remove(item);
    if (targetIndex != null) {
      todoGroup[toIndex].todoList?.insert(targetIndex, item);
    } else {
      todoGroup[toIndex].todoList?.add(item);
    }

    todoGroup.refresh();
  }

  create(TodoModel item, int groupIndex) {
    todoGroup[groupIndex].todoList?.add(item);
  }

  TodoGroupModel get first => todoGroup.first;
  TodoGroupModel get last => todoGroup.last;
  at(int index) => todoGroup[index];

  int get length =>
      todoGroup.fold(0, (sum, list) => sum + list.todoList!.length);
}
