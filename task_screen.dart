import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:taskapp/controllers/task_controller.dart';
import 'package:taskapp/models/task.dart';
import 'package:taskapp/pages/addtask.dart';
import 'package:taskapp/pages/login_page.dart';
import 'package:taskapp/pages/task_screen.dart';
import 'package:taskapp/services/notification_services.dart';
import 'package:taskapp/widgets/button.dart';
import 'package:taskapp/widgets/task_tile2.dart';
import 'package:taskapp/widgets/taskt_tile.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({super.key});

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  @override
  DateTime _selectedDate = DateTime.now();
  final _taskController = Get.put(TaskController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        backgroundColor: Colors.amber.shade700,
        title: Center(
            child: Text(
          'Your Task',
          style: GoogleFonts.lato(
              textStyle: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
        )),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 30,
          ),
          _showTasks(),
        ],
      ),
    );
  }

  _showTasks() {
    return Expanded(
      child: Obx(() {
        return ListView.builder(
            itemCount: _taskController.taskList.length,
            itemBuilder: (_, index) {
              Task task = _taskController.taskList[index];
              //if (task.repeat == 'Daily') {
              return AnimationConfiguration.staggeredList(
                position: index,
                child: SlideAnimation(
                  child: FadeInAnimation(
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            // _showBottomSheet(context, task);
                            _taskController.getTasks();
                          },
                          child: TaskTile(task),
                        ),
                      ],
                    ),
                  ),
                ),
              );

              //print(_taskController.taskList.length);
            });
      }),
    );
  }
}
