import 'package:flutter/material.dart';

class TodoInformationPopup extends StatefulWidget {
  final TextEditingController titleController;
  final TextEditingController descriptionController;
  final TextEditingController startTimeController;
  final TextEditingController endTimeController;

  const TodoInformationPopup({
    Key? key,
    required this.titleController,
    required this.descriptionController,
    required this.startTimeController,
    required this.endTimeController,
  }) : super(key: key);

  @override
  _TodoInformationPopupState createState() => _TodoInformationPopupState();
}

class _TodoInformationPopupState extends State<TodoInformationPopup> {
  TimeOfDay selectedStartTime = TimeOfDay.now();
  TimeOfDay selectedEndTime = TimeOfDay.now();

  Future<void> _showTimePicker(BuildContext context, bool isStartTime) async {
    final pickedTime = await showTimePicker(
      context: context,
      initialTime: isStartTime ? selectedStartTime : selectedEndTime,
    );

    if (pickedTime != null) {
      setState(() {
        if (isStartTime) {
          selectedStartTime = pickedTime;
          widget.startTimeController.text =
              "${selectedStartTime.hour}:${selectedStartTime.minute}";
        } else {
          selectedEndTime = pickedTime;
          widget.endTimeController.text =
              "${selectedEndTime.hour}:${selectedEndTime.minute}";
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.black,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 20,
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            const Text(
              "Хичээлийн хуваарь нэмэх",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
            const SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: TextField(
                controller: widget.titleController,
                decoration: const InputDecoration(
                  labelStyle: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                  labelText: "Title",
                  fillColor: Colors.white,
                  filled: true,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: TextField(
                controller: widget.descriptionController,
                decoration: const InputDecoration(
                  labelStyle: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                  labelText: "Description",
                  fillColor: Colors.white,
                  filled: true,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Start Time",
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                      GestureDetector(
                        onTap: () => _showTimePicker(context, true),
                        child: Text(
                          widget.startTimeController.text.isEmpty
                              ? "Select Start Time"
                              : widget.startTimeController.text,
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.blue,
                              decoration: TextDecoration.underline),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "End Time",
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                      GestureDetector(
                        onTap: () => _showTimePicker(context, false),
                        child: Text(
                          widget.endTimeController.text.isEmpty
                              ? "Select End Time"
                              : widget.endTimeController.text,
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.blue,
                              decoration: TextDecoration.underline),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  primary: Colors.deepPurple,
                  textStyle: const TextStyle(fontWeight: FontWeight.bold)),
              child: const Text("Нэмэх"),
              onPressed: () {
                // Perform your save logic here
                Navigator.pop(context, false);
              },
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
// import 'package:flutter/material.dart';

// class TodoInformationPopup extends StatefulWidget {
//   final TextEditingController descriptionController;
//   final TextEditingController titleController;

//   const TodoInformationPopup(
//       {Key? key,
//       required this.titleController,
//       required this.descriptionController})
//       : super(key: key);

//   @override
//   _TodoInformationPopupState createState() => _TodoInformationPopupState();
// }

// class _TodoInformationPopupState extends State<TodoInformationPopup> {
//   @override
//   Widget build(BuildContext context) {
//     return Dialog(
//       backgroundColor: Colors.deepPurpleAccent,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
//       elevation: 20,
//       child: SingleChildScrollView(
//         child: Column(
//           children: [
//             const SizedBox(
//               height: 10,
//             ),
//             const Text(
//               "ADD TODO",
//               style: TextStyle(
//                   color: Colors.white,
//                   fontWeight: FontWeight.bold,
//                   fontSize: 35),
//             ),
//             const SizedBox(
//               height: 40,
//             ),
//             Padding(
//               padding: const EdgeInsets.only(left: 10, right: 10),
//               child: TextField(
//                 controller: widget.titleController,
//                 decoration: const InputDecoration(
//                   labelStyle: TextStyle(
//                       color: Colors.black, fontWeight: FontWeight.bold),
//                   labelText: "Title",
//                   fillColor: Colors.white,
//                   filled: true,
//                 ),
//               ),
//             ),
//             const SizedBox(
//               height: 20,
//             ),
//             Padding(
//               padding: const EdgeInsets.only(left: 10, right: 10),
//               child: TextField(
//                 controller: widget.descriptionController,
//                 decoration: const InputDecoration(
//                   labelStyle: TextStyle(
//                       color: Colors.black, fontWeight: FontWeight.bold),
//                   labelText: "Description",
//                   fillColor: Colors.white,
//                   filled: true,
//                 ),
//               ),
//             ),
//             const SizedBox(
//               height: 20,
//             ),
//             ElevatedButton(
//               style: ElevatedButton.styleFrom(
//                   primary: Colors.red,
//                   textStyle: const TextStyle(fontWeight: FontWeight.bold)),
//               child: const Text("ADD"),
//               onPressed: () => Navigator.pop(context, false),
//             ),
//             const SizedBox(
//               height: 10,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
