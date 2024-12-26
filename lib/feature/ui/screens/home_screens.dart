import 'package:curd_practice/feature/data/controller/crud_controller.dart';
import 'package:curd_practice/feature/data/model/item.dart';
import 'package:curd_practice/feature/ui/widgets/item_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreens extends StatelessWidget {
  HomeScreens({super.key});

  CrudController controller = Get.put(CrudController());

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Todo APP',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: curdBottomSheet,
        child: const Icon(Icons.add),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
        child: Column(
          children: [
            Expanded(
              child: Obx((){
                if(controller.isLoading.value){
                  return const Center(child: CircularProgressIndicator());
                }else{
                  return ListView.builder(
                    itemCount: controller.allTodos.length,
                    itemBuilder: (context, index) {
                      // Dynamically pass data from the list of todos
                      Data data = controller.allTodos[index];
                      return ItemCard(id: data.id!, title: data.title!, description: data.description!, indexNumber: index,);
                    },
                  );
                }
              }),
            ),
          ],
        ),
      ),
    );
  }

  void curdBottomSheet() {
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
                'Add Todo',
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

                      controller.createTodos(todos); // Call the controller to create the todo

                      // Clear the form fields
                      titleController.clear();
                      descriptionController.clear();
                      controller.isCompleted.value = false; // Reset isCompleted to false

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
