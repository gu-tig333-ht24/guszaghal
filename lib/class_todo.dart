import 'package:flutter/material.dart';
import './api.dart';

class toDoList extends ChangeNotifier {
  String title;
  String id;
  bool check;
  String filter = "";
  List<toDoList> theList = [];

  toDoList({this.title = "", this.id = "", this.check = false});

  void changeFilter(String newfilter) {
    filter = newfilter;
    notifyListeners();
  }

  List<toDoList> get getList {
    if (filter == "Done") {
      return theList.where((item) => item.check == true).toList();
    } else if (filter == "Undone") {
      return theList.where((item) => item.check == false).toList();
    }
    return theList;
  }

  void updateList(List<toDoList> newlist) {
    theList = newlist;
    notifyListeners();
  }

  void deleteTodo(String id) async {
    await server_delete(id);
    theList.removeWhere((item) => item.id == id);
    notifyListeners();
  }

  void uppdateTodO(bool check, String id, String title) async {
    await server_update(check, id, title);
    notifyListeners();
  }

  factory toDoList.fromJson(Map<String, dynamic> json) {
    return toDoList(title: json['title'], id: json['id'], check: json['done']);
  }
}
