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

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var notifyHelper;

  @override
  void initstate() {
    super.initState();
    //notifyHelper = NotifyHelper();
    notifyHelper.requestIOSPermissions();
  }

  @override
  DateTime _selectedDate = DateTime.now();
  final _taskController = Get.put(TaskController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration:
                  BoxDecoration(color: Color.fromARGB(255, 255, 168, 7)),
              child: Row(
                children: [
                  Icon(
                    Icons.calendar_month_outlined,
                    color: Colors.white,
                    size: 30,
                  ),
                  Text('taskphile',
                      style: TextStyle(color: Colors.white, fontSize: 30)),
                ],
              ),
            ),
            ListTile(
              title: const Text('Your Task', style: TextStyle(fontSize: 20)),
              trailing: Icon(
                Icons.arrow_forward,
                color: Colors.black,
              ),
              onTap: () => Get.to(TaskScreen()),
            ),
            ListTile(
              title: const Text('Logout', style: TextStyle(fontSize: 20)),
              trailing: Icon(
                Icons.logout_outlined,
                color: Colors.black,
              ),
              onTap: () => Get.to(LoginScreen()),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.amber.shade700,
        elevation: 0,
        title: Center(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.calendar_month_outlined,
              size: 25,
            ),
            Text(
              'taskphile',
              style: GoogleFonts.lato(
                  textStyle: const TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold)),
            ),
          ],
        )),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: SizedBox(
              height: 35,
              width: 35,
              child: CircleAvatar(
                backgroundColor: Colors.white,
                child: Image.asset(
                  'lib/images/user (1).png',
                  height: 25,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(left: 16, right: 16, top: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      DateFormat.yMMMMd().format(DateTime.now()),
                      style: GoogleFonts.lato(
                          textStyle: TextStyle(
                              color: Colors.grey[500],
                              fontSize: 20,
                              fontWeight: FontWeight.bold)),
                    ),
                    Text(
                      'Today',
                      style: GoogleFonts.lato(
                          textStyle: const TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold)),
                    )
                  ],
                ),
                MyButton(
                  label: '+ Add task',
                  onTap: () async {
                    await Get.to(() => const AddTaskPage());
                    _taskController.getTasks();
                  },
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            margin: const EdgeInsets.only(top: 10, left: 16),
            child: DatePicker(DateTime.now(),
                height: 100,
                width: 80,
                initialSelectedDate: DateTime.now(),
                selectionColor: Colors.green,
                selectedTextColor: Colors.white,
                dateTextStyle: GoogleFonts.lato(
                  textStyle: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey),
                ),
                dayTextStyle: GoogleFonts.lato(
                  textStyle: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey),
                ),
                monthTextStyle: GoogleFonts.lato(
                  textStyle: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey),
                ), onDateChange: (date) {
              setState(() {
                _selectedDate = date;
              });
            }),
          ),
          const SizedBox(
            height: 20,
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
              if (task.repeat == 'Daily') {
                return AnimationConfiguration.staggeredList(
                  position: index,
                  child: SlideAnimation(
                    child: FadeInAnimation(
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              _showBottomSheet(context, task);
                              _taskController.getTasks();
                            },
                            child: TaskTile(task),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }
              if (task.date == DateFormat.yMd().format(_selectedDate)) {
                return AnimationConfiguration.staggeredList(
                  position: index,
                  child: SlideAnimation(
                    child: FadeInAnimation(
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              _showBottomSheet(context, task);
                              _taskController.getTasks();
                            },
                            child: TaskTile(task),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              } else {
                return Container();
              }
              //print(_taskController.taskList.length);
            });
      }),
    );
  }

  _showBottomSheet(BuildContext context, Task task) {
    Get.bottomSheet(Container(
      padding: const EdgeInsets.only(top: 4),
      height: task.isCompleted == 1
          ? MediaQuery.of(context).size.height * 0.24
          : MediaQuery.of(context).size.height * 0.32,
      color: Colors.grey.shade400,
      child: Column(
        children: [
          Container(
            height: 6,
            width: 120,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
          ),
          const Spacer(),
          task.isCompleted == 1
              ? Container()
              : _BottomSheetButton(
                  label: "Task Completed",
                  clr: Colors.deepPurple,
                  context: context,
                  onTap: () {
                    _taskController.TaskCompleted(task.id!);
                    _taskController.getTasks();
                    Get.back();
                  }),
          const SizedBox(
            height: 5,
          ),
          _BottomSheetButton(
              label: "Delete task",
              clr: Colors.red,
              context: context,
              onTap: () {
                _taskController.delete(task);
                _taskController.getTasks();
                Get.back();
              }),
          const SizedBox(
            height: 20,
          ),
          _BottomSheetButton(
              label: "Close",
              clr: Colors.red,
              isClose: true,
              context: context,
              onTap: () {
                Get.back();
              }),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    ));
  }

  _BottomSheetButton(
      {required String label,
      Function()? onTap,
      required Color clr,
      bool isClose = false,
      required BuildContext context}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        height: 55,
        width: MediaQuery.of(context).size.width * 0.9,
        decoration: BoxDecoration(
            border: Border.all(
                width: 2, color: isClose == true ? Colors.grey.shade300 : clr),
            color: isClose == true ? Colors.transparent : clr,
            borderRadius: BorderRadius.circular(20)),
        child: Center(
          child: Text(
            label,
            style: GoogleFonts.lato(
                textStyle: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white)),
          ),
        ),
      ),
    );
  }
}
