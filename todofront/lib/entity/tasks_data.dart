import 'package:flutter/material.dart';
import 'package:todofront/Services/database_services.dart';
import 'package:todofront/entity/task.dart';

class TasksData extends ChangeNotifier {
  List<Task> tasks = [];

  void addTask(String taskTitle, String taskText) async {
    Task task = await DatabaseService.addTask(taskTitle, taskText);
    tasks.add(task);
    notifyListeners();
  }

  void updateTask(Task task) {
    task.toggle();

    notifyListeners();
  }

  void deleteTask(Task task) {
    DatabaseService.deleteTask(task.id);
    tasks.remove(task);
    notifyListeners();
  }
}
