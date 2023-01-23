import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:todo_app_with_api/screens/add_todo_page.dart';
import 'package:http/http.dart' as http;

class TodoListPage extends StatefulWidget {
  const TodoListPage({Key? key}) : super(key: key);

  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  List items=[];
  @override
  void initState() {
    fetchTodo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Todo List"),
        centerTitle: true,
      ),
        body: ListView.builder(
            itemCount:items.length,
            itemBuilder: (context,index){
              final item=items[index]as Map;
          return ListTile(
            title: Text(item['title']),
            subtitle: Text(item['description']),
          );
        }),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: navigateToAddPage,
        label: const Text("add Todo"),
      ),
    );
  }
  void navigateToAddPage(){
   final route=MaterialPageRoute(builder: (context)=>const AddTodoPage());
   Navigator.push(context, route);
  }

  Future<void> fetchTodo()async{

    const url="https://api.nstack.in/v1/todos?page=1&limit=10";

    final uri=Uri.parse(url);
    final response=await http.get(uri);
     if(response.statusCode==200){

       final json=jsonDecode(response.body) as Map;
       final result=json['items'] as List;
       setState(() {
         items=result;
       });

     }else{

     }
    print(response.statusCode);
    print(response.body);
  }


}
