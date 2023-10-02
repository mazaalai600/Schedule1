class Todo {
  final String day;
  final String title;
  final String description;
  final String startTime;
  final String endTime;

  Todo({
    required this.day,
    required this.title,
    required this.description,
    required this.startTime,
    required this.endTime,
  });

  Map<String, dynamic> toMap() {
    return {
      'day': day,
      'title': title,
      'description': description,
      'startTime': startTime,
      'endTime': endTime,
    };
  }
}
