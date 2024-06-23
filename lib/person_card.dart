import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:todo_app/our_box.dart';
import 'package:todo_app/person.dart';

class PersonCard extends StatefulWidget {
  const PersonCard({super.key});

  @override
  State<PersonCard> createState() => _PersonCardState();
}

class _PersonCardState extends State<PersonCard> {
  final TextEditingController name_controller = TextEditingController();

  final TextEditingController age_controller = TextEditingController();
  Box newBox = ourBox;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const SizedBox(
            height: 50,
          ),
          Container(
            height: 220,
            width: 350,
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Person Details",
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  height: 50,
                  width: 280,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: TextField(
                    controller: name_controller,
                    style: const TextStyle(
                      color: Colors.black,
                    ),
                    decoration: InputDecoration(
                      hintStyle: TextStyle(
                        color: Colors.black.withOpacity(0.5),
                      ),
                      hintText: "Enter Name..",
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Container(
                  height: 50,
                  width: 280,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: TextField(
                    controller: age_controller,
                    style: const TextStyle(
                      color: Colors.black,
                    ),
                    decoration: InputDecoration(
                      hintStyle: TextStyle(
                        color: Colors.black.withOpacity(0.5),
                      ),
                      hintText: "Enter Age..",
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: ElevatedButton(
              onPressed: () {
                if (name_controller.text.isEmpty ||
                    age_controller.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      showCloseIcon: true,
                      content: Text(
                        "Please fill all the fields",
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ),
                  );
                }
                setState(() {
                  newBox.put(
                    "Key_${name_controller.text}",
                    Person(
                      name: name_controller.text,
                      age: int.parse(age_controller.text),
                    ),
                  );
                });
                name_controller.clear();
                age_controller.clear();
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(200, 50)),
              child: const Row(
                children: [
                  Icon(Icons.add),
                  Text(
                    "   Add Person details.",
                    style: TextStyle(
                      fontSize: 17,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: MediaQuery.sizeOf(context).height,
            width: MediaQuery.sizeOf(context).width * 0.87,
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: newBox.length,
                  itemBuilder: (context, index) {
                    Person person = newBox.getAt(index);
                    return ListTile(
                      leading: GestureDetector(
                        onLongPress: () {
                          setState(() {
                            newBox.deleteAt(index);
                          });
                        },
                        child: const CircleAvatar(
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.grey,
                            child: Icon(Icons.close_rounded)),
                      ),
                      title: Text(
                        person.name,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        person.age.toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
