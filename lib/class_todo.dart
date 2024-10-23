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

  Future<void> deleteTodo(String id) async {
    try {
      await server_delete(id);
      todoList.removeWhere((item) => item.id == id);
      notifyListeners();
    } catch (ero) {
      print("Fel vid remove av en todo: $ero");
    }
  }

  Future<bool> updateTodo(bool isChecked, String id, String title) async {
    try {
      bool success = await server_update(isChecked, id, title);
      if (success) {
        notifyListeners();
      }
      return success;
    } catch (error) {
      print("Fel vid uppdatea av en todo: $error");
      return false;
    }
  }
}
