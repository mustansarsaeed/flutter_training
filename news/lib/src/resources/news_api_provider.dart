import 'dart:convert';
import 'dart:io';
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
    final ids = json.decode(response.body);
    return ids.cast<int>();
  }

  Future<ItemModel> fetchItem(id) async {
    final response = await client.get(Uri.parse('$_root/item/$id.json'));
    final parsedJson = json.decode(response.body);
    // print('parsedJson $parsedJson');
    late ItemModel item;
    try {
      item = ItemModel.fromJson(parsedJson);
    } catch (ex, st) {
      print('Exception occured: $ex');
      print('Stacktrace: $st');
      exit(0);
    }

    // print(item.title);
    return item;
  }
}
