import 'package:flutter/material.dart';
import 'package:schedule/widgets/tile.dart';

class TodoGridView extends StatefulWidget {
  List<String> scheduleList;
  TodoGridView({Key? key, required this.scheduleList}) : super(key: key);

  @override
  _TodoGridViewState createState() => _TodoGridViewState();
}

class _TodoGridViewState extends State<TodoGridView> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemCount: widget.scheduleList.length,
        itemBuilder: (BuildContext context, int index) {
          // final scheduleItem = widget.scheduleList[index];
          // if (scheduleItem.split(",").length >= 5) {
          return ScheduleTile(
              title: widget.scheduleList[index].split(",")[1],
              description: widget.scheduleList[index].split(",")[2],
              startTimeController: widget.scheduleList[index].split(",")[3],
              endTimeController: widget.scheduleList[index].split(",")[4]);
          //}
        });
  }
}
// import 'package:flutter/material.dart';
// import 'package:schedule/widgets/tile.dart';

// class TodoGridView extends StatefulWidget {
//   List<String> todoList;
//   TodoGridView({Key? key, required this.todoList}) : super(key: key);

//   @override
//   _TodoGridViewState createState() => _TodoGridViewState();
// }

// class _TodoGridViewState extends State<TodoGridView> {
//   @override
//   Widget build(BuildContext context) {
//     return GridView.builder(
//       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//         crossAxisCount: 2,
//       ),
//       itemCount: widget.todoList.length,
//       itemBuilder: (BuildContext context, int index) {
//         return TodoTile(
//             title: widget.todoList[index].split(",")[1],
//             description: widget.todoList[index].split(",")[2]);
//       },
//     );
//   }
// }
