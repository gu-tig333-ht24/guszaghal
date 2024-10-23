import 'package:http/http.dart' as http;
import './class_todo.dart';
import 'dart:convert';

Future<void> server_add(String uppdrag) async {
  try {
    await http.post(
      Uri.parse(
          "https://todoapp-api.apps.k8s.gu.se/todos?key=cbc8d7d5-f9f4-4207-bb7f-a3cb22360b3b"),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({"title": uppdrag, "done": false}),
    );
  } catch (error) {
    print("gick inte att adda en todo: $error");
  }
}

Future<List<Todo>> server_get() async {
  try {
    final http.Response response = await http.get(Uri.parse(
        "https://todoapp-api.apps.k8s.gu.se/todos?key=cbc8d7d5-f9f4-4207-bb7f-a3cb22360b3b"));

    if (response.statusCode == 200) {
      List<dynamic> listDeco = jsonDecode(response.body);
      return listDeco.map((item) => Todo.fromJson(item)).toList();
    } else {
      print("gick inte att hämta todos: ${response.statusCode}");
      return [];
    }
  } catch (e) {
    print("Failed to get en todos: $e");
    return [];
  }
}

Future<void> server_delete(String id) async {
  try {
    await http.delete(Uri.parse(
        "https://todoapp-api.apps.k8s.gu.se/todos/$id?key=cbc8d7d5-f9f4-4207-bb7f-a3cb22360b3b"));
  } catch (error) {
    print("gick inte att ta bort en todo: $error");
  }
}

Future<bool> server_update(bool check, String id, String title) async {
  try {
    final respons = await http.put(
      Uri.parse(
          "https://todoapp-api.apps.k8s.gu.se/todos/$id?key=cbc8d7d5-f9f4-4207-bb7f-a3cb22360b3b"),
      body: jsonEncode({"title": title, "done": check}),
      headers: {'Content-Type': 'application/json'},
    );

    if (respons.statusCode == 200) {
      return true;
    } else {
      print("gick inte med att uppdatera todo: ${respons.statusCode}");
      return false;
    }
  } catch (e) {
    print("Fel vid uppdatering av en todo: $e");
    return false;
  }
}
