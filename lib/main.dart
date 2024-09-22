import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/add_uppdrag.dart';

class toDoList extends ChangeNotifier {
  List<String> lst = [];
  List<bool> checkLista = [];
  String filter = "";

  void addUppdrag(String uppdrag) {
    lst.add(uppdrag);
    checkLista.add(false);
    notifyListeners();
  }

  void removeUppdrag(String uppdrag) {
    int index = lst.indexOf(uppdrag);
    lst.remove(uppdrag);
    checkLista.removeAt(index);
    notifyListeners();
  }

  void changeFilter(String newfilter) {
    filter = newfilter;
    notifyListeners();
  }

  List<String> get getList {
    if (filter == "Done") {
      return lst
          .where((item) => checkLista[lst.indexOf(item)] == true)
          .toList();
    } else if (filter == "Undone") {
      return lst
          .where((item) => checkLista[lst.indexOf(item)] == false)
          .toList();
    }
    return lst;
  }
}

void main() {
  toDoList uppdrag = toDoList();

  runApp(ChangeNotifierProvider(
    create: (context) => uppdrag,
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
  @override
  Widget build(BuildContext context) {
    final uppdrag_2 = Provider.of<toDoList>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade900,
        title: Text(
          "TIG333 TODO",
          style: TextStyle(color: Colors.yellow.shade300),
        ),
        actions: [
          PopupMenuButton(
              onSelected: (value) {
                uppdrag_2.changeFilter(value);
              },
              child: Icon(
                Icons.more_vert,
                color: Colors.yellow.shade300,
              ),
              itemBuilder: (value) {
                return [
                  PopupMenuItem(value: "All", child: Text("All")),
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
                itemCount: uppdrag_2.getList.length,
                itemBuilder: (context, index) {
                  final item = uppdrag_2.getList[index];
                  final orginal = uppdrag_2.lst.indexOf(item);
                  return ListTile(
                    leading: Checkbox(
                      activeColor: Colors.green.shade900,
                      checkColor: Colors.yellow.shade300,
                      value: uppdrag_2.checkLista[orginal],
                      onChanged: (bool? value) {
                        setState(() {
                          uppdrag_2.checkLista[orginal] = value!;
                        });
                      },
                    ),
                    title: Text(
                      item,
                      style: TextStyle(
                          decoration: uppdrag_2.checkLista[orginal]
                              ? TextDecoration.lineThrough
                              : TextDecoration.none),
                    ),
                    trailing: IconButton(
                      onPressed: () {
                        uppdrag_2.removeUppdrag(item);
                      },
                      icon: Icon(Icons.cancel),
                    ),
                  );
                }),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green.shade900,
        child: Icon(Icons.add, color: Colors.yellow.shade300),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddUppdrag()));
        },
      ),
    );
  }
}
