import 'package:get/get.dart';
import 'package:taskapp/database/db.dart';
import 'package:taskapp/models/task.dart';

class TaskController extends GetxController {

  var taskList = <Task>[].obs;

  Future<int> addTask({Task? task}) async {
    return await DBHelper.insert(task);
  }

  void getTasks() async {
    List<Map<String, dynamic>> tasks = await DBHelper.query();
    taskList.assignAll(tasks.map((data) => Task.fromJson(data)).toList());
  }

  void delete(Task task) {
    var val = DBHelper.delete(task);
    print(val);
  }

  void TaskCompleted(int id) async {
    await DBHelper.update(id);
  }
}
