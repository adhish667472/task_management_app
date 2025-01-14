import 'dart:math';

import 'package:pinput/pinput.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:task_management_app/common/helpers/db_helper.dart';
import 'package:task_management_app/common/models/task_model.dart';
import 'package:task_management_app/common/utils/constants.dart';
part 'todo_provider.g.dart';

@riverpod
class TodoState extends _$TodoState {
  @override
  List<Task> build() {
    return [];
  }

  void refresh() async {
    final data = await DBHelper.getItems();

    state = data.map((e) => Task.fromJson(e)).toList();
  }

  void addItem(Task task) async {
    await DBHelper.createItem(task);
    refresh();
  }

  dynamic getRandomColor() {
    Random random = Random();
    int randomIndex = random.nextInt(colors.length);
    return colors[randomIndex];
  }

  void updateItem(int id, String title, String description, int isCompleted,
      String date, String startTime, String endTime) async {
    await DBHelper.updateItem(
        id, title, description, isCompleted, date, startTime, endTime);
    refresh();
  }

  Future<void> deleteTodo(int id) async {
    await DBHelper.deleteItem(id);
    refresh();
  }

  void markAsCompleted(int id, String title, String description,
      int isCompleted, String date, String startTime, String endTime) async {
    await DBHelper.updateItem(
        id, title, description, 1, date, startTime, endTime);
    refresh();
  }

//today
  String getToday() {
    DateTime today = DateTime.now();
    return today.toString().substring(0, 10);
  }

  //tomorrow
  String getTomorrow() {
    DateTime tomorrow = DateTime.now().add(Duration(days: 1));
    return tomorrow.toString().substring(0, 10);
  }

  //DayAfterTomorrow
  String getDayAfterTomorrow() {
    DateTime tomorrow = DateTime.now().add(Duration(days: 2));
    return tomorrow.toString().substring(0, 10);
  }

  //completed tasks of last 30 days
  List<String> last30days() {
    DateTime today = DateTime.now();
    DateTime oneMonthAgo = today.subtract(const Duration(days: 30));

    List<String> dates = [];
    for (int i = 0; i < 30; i++) {
      DateTime date = oneMonthAgo.add(Duration(days: i));
      dates.add(date.toString().substring(0, 10));
    }
    return dates;
  }

  bool getStatus(Task data) {
    bool? isCompleted;

    if (data.isCompleted == 0) {
      isCompleted = false;
    } else {
      isCompleted = true;
    }
    return isCompleted;
  }
}
