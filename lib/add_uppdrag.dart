import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './api.dart';
import './class_todo.dart';

class AddToList extends StatefulWidget {
  const AddToList({super.key});

  @override
  State<AddToList> createState() => _Add_toListState();
}

class _Add_toListState extends State<AddToList> {
  TextEditingController textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final provid_2 = Provider.of<TodoListState>(context);

    return Scaffold(
        body: Stack(children: [
      Positioned.fill(
          child: Image.asset(
        "images/4.jpg",
        fit: BoxFit.fill,
      )),
      Column(
        children: [
          Row(
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.yellow,
                    size: 30,
                  )),
            ],
          ),
          SizedBox(
            height: 0,
          ),
          Center(
            child: SizedBox(
              width: 290,
              child: TextField(
                controller: textEditingController,
                decoration: InputDecoration(
                    hintText: "What are you going to do ?",
                    hintStyle: TextStyle(color: Colors.yellow),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12))),
                style: TextStyle(color: Colors.yellow),
              ),
            ),
          ),
          SizedBox(
            height: 18,
          ),
          ElevatedButton(
            onPressed: () async {
              try {
                await server_add(textEditingController.text);
                List<Todo> respone = await server_get();
                provid_2.updateList(respone);
                Navigator.pop(context);
              } catch (error) {
                print("Fel vid uppdraget lades till: $error");
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('fel vid addering av uppdraget'),
                  ),
                );
              }
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Add",
                  style: TextStyle(color: Colors.yellow),
                ),
                SizedBox(
                  width: 4,
                ),
                Icon(
                  Icons.add,
                  color: Colors.yellow,
                  size: 17,
                )
              ],
            ),
            style: ElevatedButton.styleFrom(
                minimumSize: Size(165, 45), backgroundColor: Colors.black),
          )
        ],
      ),
    ]));
  }
}
