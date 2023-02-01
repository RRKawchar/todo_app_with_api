import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:todo_app_with_api/screens/add_todo_page.dart';
import 'package:http/http.dart' as http;
import 'package:todo_app_with_api/services/todo_services.dart';

class TodoListPage extends StatefulWidget {
  const TodoListPage({Key? key}) : super(key: key);

  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  var myMenuItem = <String>["Edit", "Delete"];

  onSelected(item) {
    switch (item) {
      case 'Edit':
        print("Edit");
        break;
      case 'Delete':
        print("Delete");
        break;
    }
  }

  List items = [];
  bool isLoading = true;
  @override
  void initState() {
    fetchTodo();

    setState(() {});

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Todo List"),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: fetchTodo,
        child: items.isEmpty
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Visibility(
          visible: items.isNotEmpty,
              replacement: Center(
                child: Text("No Todo Item",style: Theme.of(context).textTheme.headline3,),
              ),
              child: ListView.builder(
                padding: const EdgeInsets.all(8),
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    final item = items[index] as Map;
                    final id = item['_id'] as String;
                    return Card(
                      child: ListTile(
                        leading: CircleAvatar(child: Text("${index + 1}")),
                        title: Text(item['title']),
                        subtitle: Text(item['description']),
                        trailing: PopupMenuButton(
                          onSelected: (value) {
                            if (value == 'edit') {
                              navigateToEditPage(item);
                            } else if (value == 'delete') {
                              deleteById(id);
                            }
                          },
                          itemBuilder: (BuildContext context) {
                            return [
                              const PopupMenuItem(
                                value: 'edit',
                                child: Text("Edit"),
                              ),
                              const PopupMenuItem(
                                value: 'delete',
                                child: Text("Delete"),
                              ),
                            ];
                          },
                        ),
                      ),
                    );
                  }),
            ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: navigateToAddPage,
        label: const Text("add Todo"),
      ),
    );
  }

  Future<void> deleteById(String id) async {
    final isSuccess=await TodoServices.deleteById(id);
    if (isSuccess) {
      final filtered = items.where((element) => element['_id'] != id).toList();
      setState(() {
        items = filtered;
      });
    } else {}
  }

  Future<void> navigateToAddPage() async {
    final route = MaterialPageRoute(builder: (context) => const AddTodoPage());
    await Navigator.push(context, route);

    setState(() {
      isLoading = true;
    });
    fetchTodo();
  }

 Future<void> navigateToEditPage(Map item) async{
    final route = MaterialPageRoute(builder: (context) => AddTodoPage(todo:item));
    await Navigator.push(context, route);

    setState(() {
      isLoading = true;
    });
    fetchTodo();
  }

  Future<void> fetchTodo() async {
    setState(() {
      isLoading = true;
    });
    const url = "https://api.nstack.in/v1/todos?page=1&limit=20";

    final uri = Uri.parse(url);
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      final result = json['items'];
      setState(() {
        items = result;
      });
      return result;
    }
    setState(() {
      isLoading = false;
    });
  }
}
