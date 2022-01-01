import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todofront/Services/database_services.dart';
import 'package:todofront/entity/task.dart';
import 'package:todofront/entity/tasks_data.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String title = "";
  String text = "";

  List<Task>? tasks;

  getTasks() async {
    tasks = await DatabaseService.getTask();
    Provider.of<TasksData>(context, listen: false).tasks = tasks!;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getTasks();
  }

  @override
  Widget build(BuildContext context) {
    return tasks == null
        ? const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          )
        : Scaffold(
            appBar: AppBar(
              title: Text(
                  "TODO-App (${Provider.of<TasksData>(context).tasks.length})"),
            ),
            body: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.fromLTRB(50, 15, 50, 10),
                          child: TextField(
                            autocorrect: true,
                            cursorColor: Colors.amber,
                            decoration: const InputDecoration(
                              hintText: "Title of TODO",
                            ),
                            onChanged: (value) {
                              setState(
                                () {
                                  title = value;
                                },
                              );
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(50, 15, 50, 10),
                          child: TextField(
                            autocorrect: true,
                            cursorColor: Colors.amber,
                            decoration: const InputDecoration(
                              hintText: "Text of TODO",
                            ),
                            onChanged: (value) {
                              setState(
                                () {
                                  text = value;
                                },
                              );
                            },
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () => setState(() {
                            DatabaseService.addTask(title, text);
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const Home()));
                          }),
                          child: const Text("Add"),
                        )
                      ],
                    ),
                  ),
                  SingleChildScrollView(
                    child: Consumer<TasksData>(
                      builder: (context, tasksdata, child) {
                        return ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: tasksdata.tasks.length,
                          itemBuilder: (context, index) {
                            Task task = tasksdata.tasks[index];
                            return ListTile(
                              leading: Checkbox(
                                onChanged: (value) => setState(
                                  () {
                                    tasksdata.updateTask(task);
                                  },
                                ),
                                value: task.completed,
                              ),
                              title: Text(
                                task.title,
                                style: const TextStyle(fontSize: 20),
                              ),
                              subtitle: Text(
                                task.text,
                                style: const TextStyle(fontSize: 15),
                              ),
                              trailing: IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () {
                                  setState(() {
                                    tasksdata.deleteTask(task);
                                  });
                                },
                              ),
                            );
                          },
                        );
                      },
                    ),
                  )
                ],
              ),
            ));
  }
}
