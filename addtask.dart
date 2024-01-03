import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
//import 'package:taskapp/Themes/local_notification.dart';
import 'package:taskapp/controllers/task_controller.dart';
import 'package:taskapp/models/task.dart';
import 'package:taskapp/utils/inputfield.dart';
import 'package:taskapp/widgets/button.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({super.key});

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  void initState() {
    intialize();
    super.initState();
  }

  final TaskController _taskController = Get.put(TaskController());
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  DateTime _selecteddate = DateTime.now();
  String _startTime = DateFormat("hh:mm a").format(DateTime.now()).toString();
  String _endTime = '9:00 PM';
  int _selectedremind = 5;
  List<int> remindlist = [
    5,
    10,
    15,
    20,
  ];
  String _selectedRepeat = "None";
  List<String> repeatlist = [
    "None",
    "Daily",
    "weekly",
    "Monthly",
  ];
  int _selectedColor = 0;

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.grey.shade100,
            leading: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: const Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
              ),
            )),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 20, left: 16),
                child: Text(
                  'Add Task',
                  style: GoogleFonts.lato(
                      textStyle: const TextStyle(
                          fontSize: 25, fontWeight: FontWeight.bold)),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              MyInputfield(
                title: 'Title',
                hinttext: 'Enter title here',
                controller: _titleController,
              ),
              const SizedBox(
                height: 10,
              ),
              MyInputfield(
                title: 'Note',
                hinttext: 'Enter note here',
                controller: _noteController,
              ),
              const SizedBox(
                height: 10,
              ),
              MyInputfield(
                title: 'Date',
                hinttext: DateFormat.yMd().format(_selecteddate),
                widget: IconButton(
                  icon: const Icon(
                    Icons.calendar_month_outlined,
                    color: Colors.grey,
                  ),
                  onPressed: () {
                    _getDatefromUser();
                  },
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                    child: MyInputfield(
                      title: 'Start Time',
                      hinttext: _startTime,
                      widget: IconButton(
                        onPressed: () {
                          _getTimefromUser(isStartTime: true);
                        },
                        icon: const Icon(
                          Icons.access_time_filled_outlined,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 2,
                  ),
                  Expanded(
                    child: MyInputfield(
                      title: 'End Time',
                      hinttext: _endTime,
                      widget: IconButton(
                        onPressed: () {
                          _getTimefromUser(isStartTime: false);
                        },
                        icon: const Icon(
                          Icons.access_time_filled_outlined,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              MyInputfield(
                title: 'Remind',
                hinttext: '$_selectedremind minutes early',
                widget: DropdownButton(
                  onChanged: (String? newvalue) {
                    setState(() {
                      _selectedremind = int.parse(newvalue!);
                    });
                  },
                  icon: const Icon(
                    Icons.keyboard_arrow_down,
                    color: Colors.grey,
                  ),
                  iconSize: 32,
                  elevation: 4,
                  underline: Container(
                    height: 0,
                  ),
                  items: remindlist.map<DropdownMenuItem<String>>(
                    (int value) {
                      return DropdownMenuItem<String>(
                        value: value.toString(),
                        child: Text(value.toString()),
                      );
                    },
                  ).toList(),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              MyInputfield(
                title: 'Repeat',
                hinttext: _selectedRepeat,
                widget: DropdownButton(
                  onChanged: (String? newvalue) {
                    setState(() {
                      _selectedRepeat = newvalue!;
                    });
                  },
                  icon: const Icon(
                    Icons.keyboard_arrow_down,
                    color: Colors.grey,
                  ),
                  iconSize: 32,
                  elevation: 4,
                  underline: Container(
                    height: 0,
                  ),
                  items: repeatlist.map<DropdownMenuItem<String>>(
                    (String? value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value!,
                          style: const TextStyle(color: Colors.grey),
                        ),
                      );
                    },
                  ).toList(),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                margin: const EdgeInsets.only(left: 16, right: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Color',
                          style: GoogleFonts.lato(
                              textStyle: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold)),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Wrap(
                          children: List<Widget>.generate(3, (int index) {
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  _selectedColor = index;
                                });
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(right: 6),
                                child: CircleAvatar(
                                  radius: 14,
                                  backgroundColor: index == 0
                                      ? Colors.blue.shade600
                                      : index == 1
                                          ? Colors.pink.shade600
                                          : Colors.yellow.shade600,
                                  child: _selectedColor == index
                                      ? const Icon(
                                          Icons.done,
                                          color: Colors.white,
                                        )
                                      : Container(),
                                ),
                              ),
                            );
                          }),
                        )
                      ],
                    ),
                    MyButton(
                        label: 'Create Task',
                        onTap: () async {
                          await showNotification(
                              id: 1,
                              title: "taskphile",
                              body: "Task has created");
                          _validtitleNote();
                        })
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  final _localNotificationservice = FlutterLocalNotificationsPlugin();

  Future<void> intialize() async {
    AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings("flutter_logo");
    InitializationSettings settings =
        InitializationSettings(android: androidInitializationSettings);

    await _localNotificationservice.initialize(settings);
  }

  Future<NotificationDetails> _notificationDetails() async {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      '1',
      'Notifications app',
      channelDescription: 'description',
      importance: Importance.max,
      priority: Priority.max,
    );

    return const NotificationDetails(
      android: androidNotificationDetails,
    );
  }

  Future<void> showNotification(
      {required int id, required String title, required String body}) async {
    final details = await _notificationDetails();
    await _localNotificationservice.show(id, title, body, details);
  }

  _validtitleNote() {
    if (_titleController.text.isNotEmpty && _noteController.text.isNotEmpty) {
      _addTaskToDB();

      Get.back();
    } else if (_titleController.text.isEmpty || _noteController.text.isEmpty) {
      print("if condtion is not working");
      Get.snackbar("Required", "All fields are required",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.white,
          icon: const Icon(
            Icons.warning_amber_rounded,
            color: Colors.red,
          ));
    }
  }

  _getDatefromUser() async {
    DateTime? pickerDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2015),
        lastDate: DateTime(2121));

    if (pickerDate != null) {
      setState(() {
        _selecteddate = pickerDate;
      });
    } else {
      print("Something is wrong");
    }
  }

  _addTaskToDB() async {
    int value = await _taskController.addTask(
        task: Task(
            note: _noteController.text,
            title: _titleController.text,
            date: DateFormat.yMd().format(_selecteddate),
            startTime: _startTime,
            endTime: _endTime,
            remind: _selectedremind,
            repeat: _selectedRepeat,
            color: _selectedColor,
            isCompleted: 0));
    print("my id is" "$value");
  }

  _getTimefromUser({required bool isStartTime}) async {
    var pickedtime = await _showTimePicker();
    String formatedtime = pickedtime.format(context);
    if (pickedtime == null) {
      print('Time cancelled');
    } else if (isStartTime == true) {
      setState(() {
        _startTime = formatedtime;
      });
    } else if (isStartTime == false) {
      setState(() {
        _endTime = formatedtime;
      });
    }
  }

  _showTimePicker() {
    return showTimePicker(
        initialEntryMode: TimePickerEntryMode.input,
        context: context,
        initialTime: TimeOfDay(
            hour: int.parse(_startTime.split(":")[0]),
            minute: int.parse(_startTime.split(":")[1].split(" ")[0])));
  }
}
