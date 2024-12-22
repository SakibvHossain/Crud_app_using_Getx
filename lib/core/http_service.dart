import 'package:curd_practice/feature/data/model/item.dart';
import 'package:http/http.dart' as http;

abstract class HttpService{
  Future<void> getTodos(List<Item> items) async {}
  Future<void> createTodos(Item item) async {}
  Future<void> updateTodos(Item item, int id) async{}
  Future<void> deleteTodos(int id) async{}
}