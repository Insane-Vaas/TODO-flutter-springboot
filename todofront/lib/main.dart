import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todofront/entity/tasks_data.dart';

import 'Screen/homescreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TasksData(),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Home(),
      ),
    );
  }
}
