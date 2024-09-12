import 'package:flutter/material.dart';

class AddPage extends StatelessWidget {
  const AddPage({super.key});

  @override
  Widget build(BuildContext context) {
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
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 90, right: 50),
            child: SizedBox(
              width: 400,
              child: TextField(
                decoration: InputDecoration(
                    hintText: "what are you going to do ?",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          ElevatedButton(
            onPressed: () {},
            child: Text(
              "Add",
              style: TextStyle(color: Colors.yellow.shade300),
            ),
            style: ElevatedButton.styleFrom(
                minimumSize: Size(140, 50),
                backgroundColor: Colors.green.shade900),
          )
        ],
      ),
    );
  }
}
