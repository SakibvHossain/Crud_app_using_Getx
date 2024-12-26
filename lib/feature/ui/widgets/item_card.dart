import 'package:curd_practice/feature/data/controller/crud_controller.dart';
import 'package:curd_practice/feature/data/model/item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ItemCard extends StatelessWidget {
  ItemCard({super.key, required this.title, required this.description, required this.indexNumber, required this.id});

  final String title;
  final String description;
  final int indexNumber;
  final int id;

  CrudController controller = Get.put(CrudController());


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(2, 3),
          ),
        ],
      ),
      child: Material(
        borderRadius: BorderRadius.circular(10), // Ensures splash effect respects corners
        color: Colors.transparent, // Avoid overlaying color
        child: InkWell(
          borderRadius: BorderRadius.circular(10), // Constrain ripple to rounded corners
          onTap: () {
            print('Bob tapped');
            curdUpdateBottomSheet(todo: controller.allTodos[indexNumber]);
          },
          child: ListTile(
            // Splash effect
            splashColor: Colors.blue.withOpacity(0.2),

            // Leading avatar icon
            leading: CircleAvatar(
              backgroundColor: Colors.green,
              radius: 20, // Ensures consistent size
              child: Text(
                (indexNumber+1).toString(),
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),

            // Title
            title: Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),

            // Subtitle
            subtitle: Text(
              description,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Colors.grey,
              ),
            ),

            // Trailing delete button
            trailing: IconButton(
              onPressed: () {
                controller.delete(id);
                print('Delete button tapped on index $id');
              },
              icon: const Icon(
                Icons.delete,
                color: Colors.redAccent,
              ),
              tooltip: 'Delete',
            ),
          ),
        ),
      ),
    );
  }

  void curdUpdateBottomSheet({required todo}) {
    Data data = todo;

    // Controllers for TextFields
    TextEditingController titleController = TextEditingController(text: data.title);
    TextEditingController descriptionController = TextEditingController(text: data.description);

    Get.bottomSheet(
      Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const Text(
                'Update Todo',
                style: TextStyle(fontSize: 24, color: Colors.black),
              ),
              const SizedBox(height: 8.0),
              TextFormField(
                controller: titleController,
                autofocus: true,
                decoration: const InputDecoration(
                  labelText: 'Title',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 8.0),
              TextFormField(
                controller: descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 8.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Text(
                        'Is todo completed?',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 4.0),
                      Obx((){
                        return Switch(
                          value: controller.isCompleted.value,
                          onChanged: (value) {
                            controller.isCompleted.value = value; // Update the value of isCompleted when the switch is toggled
                          },
                          activeColor: Colors.blue,
                          inactiveThumbColor: Colors.grey,
                          activeTrackColor: Colors.lightBlue,
                          inactiveTrackColor: Colors.grey[300],
                        );
                      }),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Creating the map for the new todo
                      Map<String, dynamic> todos = {
                        'title': titleController.text,
                        'description': descriptionController.text,
                        'isCompleted': controller.isCompleted.value, // Pass the updated isCompleted value
                      };

                      controller.updateTodos(todos, data.id!); // Call the controller to create the todo

                      // Clear the form fields
                      titleController.clear();
                      descriptionController.clear();

                      // Close the bottom sheet
                      Get.back();
                    },
                    child: const Text('Save'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
