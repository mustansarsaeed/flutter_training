import 'dart:convert';
import 'package:http/http.dart' show Client;
import 'package:news/src/models/item_model.dart';
import '../models/item_model.dart';
import 'dart:async';
import 'repository.dart';

final _root = 'https://hacker-news.firebaseio.com/v0';

class NewsApiProvider implements Source {
  Client client = Client();

  Future<List<int>> fetchTopIds() async {
    final response = await client.get(Uri.parse('$_root/topstories.json'));
    print('response=$response');
    final ids = json.decode(response.body);
    print('typeof ${ids.runtimeType}');
    return ids.cast<int>();
  }

  Future<ItemModel> fetchItem(id) async {
    final response = await client.get(Uri.parse('$_root/item/$id.json'));
    final parsedJson = json.decode(response.body);
    // print('parsedJson $parsedJson');
    return ItemModel.fromJson(parsedJson);
  }
}
