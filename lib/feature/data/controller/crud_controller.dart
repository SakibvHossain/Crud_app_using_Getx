import 'dart:convert';

import 'package:curd_practice/feature/data/model/item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../../core/http/impl/http_service_impl.dart';

class CrudController extends GetxController{
  late HttpServiceImpl httpService;

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  RxBool isCompleted = false.obs;

  RxList<dynamic> allTodos = <dynamic>[].obs;
  RxList<dynamic> completedTodos = <dynamic>[].obs;
  RxList<dynamic> pendingTodos = <dynamic>[].obs;

  //For progress indicator
  RxBool isLoading = false.obs;
  RxBool isTodoCreated = false.obs;

  @override
  void onInit() {
    httpService = HttpServiceImpl();
    getTodos();
    super.onInit();
  }

  void getTodos() async{
    try{
      isLoading(true);
      http.Response response = await httpService.getTodos();

      if(response.statusCode == 200){
        Map<String, dynamic> decodedValues = jsonDecode(response.body);

        for(var items in decodedValues['data']){
          allTodos.add(Data.fromJson(items));
        }

        print(allTodos);
      }else{
        print('Failed to fetch data');
      }
    }catch(e){
      print('$e');
    }finally{
      isLoading(false);
    }
  }

  void createTodos(Map<String, dynamic> todos) async{
    try{
      isLoading(true);
      http.Response createdTodoResponse = await httpService.createTodos(todos);
      if(createdTodoResponse.statusCode == 200){
        print(createdTodoResponse.body);
        // Fetch updated list of todos
        allTodos.clear();
        getTodos();
        Get.snackbar('Todos created', 'Todo creation successful');
      }else{
        Get.snackbar('Todo creation failed', "Failed to created todo");
      }
    }catch(e){
      Get.snackbar('Todos creation failed', '$e');
    }finally{
      isLoading(false);
    }
  }

  void updateTodos(Map<String, dynamic> todos, int id) async {
    try{
      isLoading(true);
      http.Response updateTodoResponse = await httpService.updateTodos(todos, id);

      if(updateTodoResponse.statusCode == 200){
        allTodos.clear();
        getTodos();
        Get.snackbar('Todos updated', 'Todo updated successful');
      }else{
        Get.snackbar('Failed to update', 'Todo update failed');
      }
    }catch(e){
      Get.snackbar('Failed to update', '$e');
    }finally{
      isLoading(false);
    }
  }

  void delete(int id) async{
    try{
      isLoading(true);
      http.Response deleteTodoResponse = await httpService.deleteTodos(id);

      if(deleteTodoResponse.statusCode == 200){
        allTodos.clear();
        getTodos();
        Get.snackbar('Todo deleted', 'Todo deletion successful');
      }else{
        Get.snackbar('Failed to delete', 'Todo deletion failed');
      }
    }catch(e){
      Get.snackbar('Failed to delete', '$e');
    }finally{
      isLoading(false);
    }
  }
}