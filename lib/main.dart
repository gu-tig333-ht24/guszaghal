import 'package:flutter/material.dart';
import 'package:todo_first_steg/add_page.dart';

void main() {
  runApp(const MyApp());
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

List<String> lst = [
  "Gym",
  "Call a friend ",
  "Besikta bilen",
  "Learn more about flutter",
  "Create a database"
];

class toDo extends StatelessWidget {
  const toDo({super.key});

  @override
  Widget build(BuildContext context) {
    final scsize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade800,
        title: Text(
          "TIG333 TODO",
          style: TextStyle(color: Colors.yellow.shade300),
        ),
        actions: [
          Icon(
            Icons.more_vert,
            color: Colors.yellow.shade300,
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
                itemCount: lst.length,
                itemBuilder: (context, index) {
                  final get_item = lst[index];
                  return Container(
                    height: 50,
                    width: scsize.width,
                    child: Row(
                      children: [
                        Checkbox(value: false, onChanged: (bool? value) {}),
                        Expanded(
                            child: Text(
                                get_item)), // Texten tar upp tillgängligt utrymme
                        Padding(
                          padding: const EdgeInsets.only(right: 17),
                          child: Icon(Icons.cancel),
                        )
                      ],
                    ),
                  );
                }),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddPage()));
        },
        backgroundColor: Colors.green.shade900,
        child: Icon(
          Icons.add,
          color: Colors.yellow.shade300,
        ),
      ),
    );
  }
}
