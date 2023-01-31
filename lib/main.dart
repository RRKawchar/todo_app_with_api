import 'package:flutter/material.dart';
import 'package:todo_app_with_api/screens/todo_list_page.dart';

import 'location_test.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Todo App',
      theme: ThemeData.dark(),
      home: const TodoListPage(),
    );
  }
}
