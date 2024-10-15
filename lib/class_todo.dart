import 'package:flutter/material.dart';
import './api.dart';

class Todo {
  String title;
  String id;
  bool isChecked;

  Todo({
    required this.title,
    required this.id,
    this.isChecked = false,
  });

  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      title: json['title'],
      id: json['id'],
      isChecked: json['done'],
    );
  }
}

class TodoListState extends ChangeNotifier {
  String filter = "";
  List<Todo> todoList = [];

  void changeFilter(String newFilter) {
    filter = newFilter;
    notifyListeners();
  }

  List<Todo> get filteredList {
    if (filter == "Done") {
      return todoList.where((item) => item.isChecked).toList();
    } else if (filter == "Undone") {
      return todoList.where((item) => !item.isChecked).toList();
    }
    return todoList;
  }

  void updateList(List<Todo> newList) {
    todoList = newList;
    notifyListeners();
  }

  void deleteTodo(String id) async {
    await server_delete(id);
    todoList.removeWhere((item) => item.id == id);
    notifyListeners();
  }

  void updateTodo(bool isChecked, String id, String title) async {
    await server_update(isChecked, id, title);
    notifyListeners();
  }
}
