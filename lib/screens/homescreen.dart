import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:schedule/models/schedule_model.dart';
import 'package:schedule/widgets/grid_view.dart';
import 'package:schedule/widgets/horizontal_day-list.dart';
import 'package:schedule/widgets/popup.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  static const route = '/home';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController startTimeController = TextEditingController();
  TextEditingController endTimeController = TextEditingController();

  List<String> dayDependentTodos = [];

  List<Todo> todoInformation = [];

  String weekday = "";

  void showInSnackBar(String value) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
      value,
      style: const TextStyle(
          fontWeight: FontWeight.bold, fontSize: 20, color: Colors.redAccent),
    )));
  }

  void changeWeekday(String newDay) {
    setState(() {
      weekday = newDay;
    });
    print("changed, $weekday");

    updateList();
  }

  void updateList() {
    dayDependentTodos.clear();
    for (int i = 0; i < todoInformation.length; i++) {
      if (todoInformation[i].day == weekday) {
        dayDependentTodos.add(todoInformation[i].day);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black,
        elevation: 0.0,
        title: const Text("Хичээлийн хуваарь"),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: [
                    Text(
                      DateFormat.yMMMMd().format(DateTime.now()),
                      style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    )
                  ],
                ),
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          HorizontalDayList(
            dayUpdateFunction: changeWeekday,
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30)),
                  boxShadow: [BoxShadow(blurRadius: 10.0)]),
              child: TodoGridView(
                scheduleList: dayDependentTodos,
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return TodoInformationPopup(
                  titleController: titleController,
                  descriptionController: descriptionController,
                  endTimeController: endTimeController,
                  startTimeController: startTimeController,
                );
              }).then((value) {
            setState(() {
              if (descriptionController.text == "" ||
                  titleController.text == "") {
                showInSnackBar("Title or description can't be empty!");
              } else {
                Todo newTodo = Todo(
                  day: weekday,
                  title: titleController.text,
                  description: descriptionController.text,
                  startTime: startTimeController.text,
                  endTime: endTimeController.text,
                );
                FirebaseFirestore.instance
                    .collection('yourFirestoreCollection')
                    .add(newTodo.toMap());
                // todoInformation.add(
                //     "$weekday,${titleController.text},${descriptionController.text},${startTimeController.text},${endTimeController.text}");
                todoInformation.add(newTodo);
                updateList();
                titleController.clear();
                descriptionController.clear();
                startTimeController.clear();
                endTimeController.clear();
              }
            });
          });
        },
        splashColor: Colors.black,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15))),
        backgroundColor: Colors.black,
        child: const Icon(
          Icons.add,
          size: 50,
        ),
      ),
    );
  }
}
