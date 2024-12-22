import 'package:curd_practice/core/impl/http_service_impl.dart';
import 'package:curd_practice/feature/data/model/item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class CrudController extends GetxController{
  HttpServiceImpl httpService = HttpServiceImpl();
  
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  RxBool isCompleted = false.obs;

  RxList allTodos = <Item>[].obs;
  RxList completedTodos = <Item>[].obs;
  RxList isCompletedTodos = <Item>[].obs;


  Future<void> getTodos() async{
    print('Entered to get todos');
    try{
     await httpService.getTodos(allTodos as List<Item>);
      print(allTodos.toString());
      print('Todos fetched');
    }catch(e){
      print('$allTodos');
      print('Not fetched fetched');
    }
  }

  void createTodos(){
    //todo: createTodos
  }

  void updateTodos(){
    //todo: updateTodos
  }

  void delete(){
    //todo: deleteTodos
  }
}