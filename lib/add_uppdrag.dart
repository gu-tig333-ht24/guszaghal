import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './api.dart';
import './class_todo.dart';

class Add_toList extends StatefulWidget {
  const Add_toList({super.key});

  @override
  State<Add_toList> createState() => _Add_toListState();
}

class _Add_toListState extends State<Add_toList> {
  TextEditingController textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final provid_2 = Provider.of<toDoList>(context);

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
              await server_add(textEditingController.text);
              List<toDoList> respone = await server_get();
              provid_2.updateList(respone);
              Navigator.pop(context);
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
