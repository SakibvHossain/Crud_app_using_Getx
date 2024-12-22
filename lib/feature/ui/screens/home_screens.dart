import 'package:curd_practice/feature/data/controller/crud_controller.dart';
import 'package:curd_practice/feature/ui/widgets/item_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreens extends StatefulWidget {
  final CrudController controller = Get.put(CrudController());
  HomeScreens({super.key});

  @override
  _HomeScreensState createState() => _HomeScreensState();
}

class _HomeScreensState extends State<HomeScreens> {

  @override
 initState() {
    super.initState();
    setState(() {
      widget.controller.allTodos.clear();
    });

    fetchData();

  }

  Future<void> fetchData() async{
    await widget.controller.getTodos();  // Call the function once the widget is initialized
    print('Nothing found');
    print(widget.controller.allTodos.length);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'CRUD APP',
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
              child: ListView.builder(
                itemCount: 8,
                itemBuilder: (context, index) {
                  return ItemCard();
                },
              ),
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
                autofocus: true,
                decoration: const InputDecoration(
                  labelText: 'Title',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 8.0),
              TextFormField(
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
                      Switch(
                        value: false,
                        onChanged: (value) {
                          //todo: Implement pending or complete operation
                        },
                        activeColor: Colors.blue,
                        inactiveThumbColor: Colors.grey,
                        activeTrackColor: Colors.lightBlue,
                        inactiveTrackColor: Colors.grey[300],
                      ),
                    ],
                  ),
                  ElevatedButton(onPressed: () {}, child: const Text('Save'))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
