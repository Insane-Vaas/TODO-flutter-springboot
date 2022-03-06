class Task {
  int id;
  final String? title;
  final String? text;
  bool completed;

  Task({
    required this.id,
    required this.title,
    required this.text,
    this.completed = false,
  });

  factory Task.fromMap(Map taskMap) {
    return Task(
      id: taskMap['id'],
      title: taskMap['title'],
      text: taskMap['text'],
      completed: taskMap['completed'],
    );
  }

  void toggle() {
    completed = !completed;
  }
}
