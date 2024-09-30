import 'package:http/http.dart' as http;
import './class_todo.dart';
import 'dart:convert';

Future<void> server_add(String uppdrag) async {
  await http.post(
      Uri.parse(
          "https://todoapp-api.apps.k8s.gu.se/todos?key=7cbb8647-2ab3-463c-85f7-7470dc552d14"),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({"title": uppdrag, "done": false}));
}

Future<List<toDoList>> server_get() async {
  final http.Response response = await http.get(Uri.parse(
      "https://todoapp-api.apps.k8s.gu.se/todos?key=7cbb8647-2ab3-463c-85f7-7470dc552d14"));
  List<dynamic> listDeco = jsonDecode(response.body);
  return listDeco.map((item) => toDoList.fromJson(item)).toList();
}

Future<void> server_delete(String id) async {
  await http.delete(Uri.parse(
      "https://todoapp-api.apps.k8s.gu.se/todos/$id?key=7cbb8647-2ab3-463c-85f7-7470dc552d14"));
}

Future<void> server_update(bool check, String id, String title) async {
  await http.put(
    Uri.parse(
        "https://todoapp-api.apps.k8s.gu.se/todos/$id?key=7cbb8647-2ab3-463c-85f7-7470dc552d14"),
    body: jsonEncode({"title": title, "done": check}),
    headers: {'Content-Type': 'application/json'},
  );
}
