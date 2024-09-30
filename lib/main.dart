import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './add_uppdrag.dart';
import './api.dart';
import './class_todo.dart';

void main() {
  toDoList state = toDoList();
  runApp(ChangeNotifierProvider(
    create: (context) => state,
    child: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: toDo(),
    );
  }
}

class toDo extends StatefulWidget {
  const toDo({super.key});

  @override
  State<toDo> createState() => _toDoState();
}

class _toDoState extends State<toDo> {
  void initState() {
    super.initState();
    _loadTodosFromServer();
  }

  void _loadTodosFromServer() async {
    final provid = Provider.of<toDoList>(context, listen: false);
    List<toDoList> todosFromServer = await server_get();
    provid.updateList(todosFromServer);
  }

  @override
  Widget build(BuildContext context) {
    final provid = Provider.of<toDoList>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "TIG333 TODO",
          style: TextStyle(color: Colors.yellow.shade300),
        ),
        backgroundColor: Colors.green.shade900,
        actions: [
          PopupMenuButton(
              iconColor: Colors.yellow.shade300,
              color: Colors.yellow.shade200,
              onSelected: (value) {
                provid.changeFilter(value);
              },
              itemBuilder: (value) {
                return [
                  PopupMenuItem(
                      value: "All",
                      child: Text(
                        "All",
                      )),
                  PopupMenuItem(value: "Done", child: Text("Done")),
                  PopupMenuItem(value: "Undone", child: Text("Undone")),
                ];
              })
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
                itemCount: provid.getList.length,
                itemBuilder: (context, index) {
                  final item = provid.getList[index];
                  return ListTile(
                    leading: Checkbox(
                      value: item.check,
                      onChanged: (bool? value) {
                        setState(() {
                          provid.getList[index].check = value!;
                          provid.uppdateTodO(value, item.id, item.title);
                        });
                      },
                    ),
                    title: Text(
                      item.title,
                      style: TextStyle(
                          decoration: item.check
                              ? TextDecoration.lineThrough
                              : TextDecoration.none),
                    ),
                    trailing: IconButton(
                        onPressed: () {
                          provid.deleteTodo(item.id);
                        },
                        icon: Icon(Icons.cancel)),
                  );
                }),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green.shade900,
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Add_toList()));
        },
        child: Icon(Icons.add, color: Colors.yellow.shade300),
      ),
    );
  }
}
