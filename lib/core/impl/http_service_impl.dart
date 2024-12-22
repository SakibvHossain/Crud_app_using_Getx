import 'dart:convert';
import 'package:curd_practice/core/http_service.dart';
import 'package:curd_practice/feature/data/model/item.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

class HttpServiceImpl implements HttpService {
  final String _baseUrl = 'http://localhost:8083/api/task';

  Uri _buildUri(String endpoint) => Uri.parse('$_baseUrl/$endpoint');

  @override
  Future<void> getTodos(List<Item> items) async {
    try {
      final response = await http.get(_buildUri('all_task'));
      if (response.statusCode == 200) {
        final decodeJson = jsonDecode(response.body);
        final data = decodeJson['data'] as List;
        items.addAll(data.map((item) => Item.fromJson(item)).toList());
        print(items); // For debugging
      } else {
        print('${response.statusCode}');
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Future<void> createTodos(Item item) {
    // TODO: implement createTodos
    throw UnimplementedError();
  }

  @override
  Future<void> deleteTodos(int id) {
    // TODO: implement deleteTodos
    throw UnimplementedError();
  }

  @override
  Future<void> updateTodos(Item item, int id) {
    // TODO: implement updateTodos
    throw UnimplementedError();
  }

}
