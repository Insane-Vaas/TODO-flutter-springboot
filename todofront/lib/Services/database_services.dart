import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:todofront/Services/globals.dart';
import 'package:todofront/entity/task.dart';

class DatabaseService {
  static Future<Task> addTask(String title, String text) async {
    Map data = {"title": title, "text": text};
    var body = json.encode(data);
    var url = Uri.parse(baseURL + '/add');

    http.Response response = await http.post(
      url,
      headers: headers,
      body: body,
    );
    print(response.body);
    Map responseMap = jsonDecode(response.body);
    Task task = Task.fromMap(responseMap);
    return task;
  }

  static Future<List<Task>> getTask() async {
    var url = Uri.parse(baseURL);
    http.Response response = await http.get(
      url,
      headers: headers,
    );
    print(response.body);
    List responseList = jsonDecode(response.body);
    List<Task> tasks = [];
    for (Map taskMap in responseList) {
      Task task = Task.fromMap(taskMap);
      tasks.add(task);
    }
    return tasks;
  }

  static Future<void> deleteTask(int id) async {
    String s = id.toString();
    var url = Uri.parse(baseURL + '/delete/$id');
    http.Response response = await http.delete(url, headers: headers);
  }
}
