import 'package:http/http.dart' as http;
import './class_todo.dart';
import 'dart:convert';

Future<void> server_add(String uppdrag) async {
  await http.post(
      Uri.parse(
          "https://todoapp-api.apps.k8s.gu.se/todos?key=cbc8d7d5-f9f4-4207-bb7f-a3cb22360b3b"),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({"title": uppdrag, "done": false}));
}

Future<List<Todo>> server_get() async {
  final http.Response response = await http.get(Uri.parse(
      "https://todoapp-api.apps.k8s.gu.se/todos?key=cbc8d7d5-f9f4-4207-bb7f-a3cb22360b3b"));
  List<dynamic> listDeco = jsonDecode(response.body);
  return listDeco.map((item) => Todo.fromJson(item)).toList();
}

Future<void> server_delete(String id) async {
  await http.delete(Uri.parse(
      "https://todoapp-api.apps.k8s.gu.se/todos/$id?key=cbc8d7d5-f9f4-4207-bb7f-a3cb22360b3b"));
}

Future<void> server_update(bool check, String id, String title) async {
  await http.put(
    Uri.parse(
        "https://todoapp-api.apps.k8s.gu.se/todos/$id?key=cbc8d7d5-f9f4-4207-bb7f-a3cb22360b3b"),
    body: jsonEncode({"title": title, "done": check}),
    headers: {'Content-Type': 'application/json'},
  );
}
