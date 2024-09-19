import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/main.dart';

class AddUppdrag extends StatefulWidget {
  const AddUppdrag({super.key});

  @override
  State<AddUppdrag> createState() => _AddUppdragState();
}

class _AddUppdragState extends State<AddUppdrag> {
  TextEditingController textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final uppdrag_3 = Provider.of<toDoList>(context);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green.shade900,
          title: Text(
            "TIG333 TODO",
            style: TextStyle(color: Colors.yellow.shade300),
          ),
        ),
        body: Column(
          children: [
            SizedBox(
              height: 40,
            ),
            Center(
              child: SizedBox(
                width: 350,
                child: TextField(
                  controller: textEditingController,
                  decoration: InputDecoration(
                      hintText: "What are you going to do ?",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () {
                  uppdrag_3.addUppdrag(textEditingController.text);
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green.shade900,
                    minimumSize: Size(150, 50)),
                child: Text(
                  "Add",
                  style: TextStyle(color: Colors.yellow.shade300),
                ))
          ],
        ));
  }
}
