import 'package:flutter/material.dart';
import 'package:to_do_api/pages/todo_list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To Do App Using Api',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(
        
      ),
      home: const ToDoList(),
    );
  }
}
