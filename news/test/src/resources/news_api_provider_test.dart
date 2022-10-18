import 'dart:math';

import 'package:news/src/resources/news_api_provider.dart';
import 'dart:convert';
import 'package:test_api/test_api.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';
import 'dart:developer';

void main() {
  test('FetchTopIds returns a list of IDs', () async {
    final newsApi = NewsApiProvider();
    newsApi.client = MockClient((request) async {
      return Response(json.encode([1, 2, 3, 4]), 200);
    });

    final ids = await newsApi.fetchTopIds();

    expect(ids, [1, 2, 3, 4]);
  });

  test('FetchItem returns an item', () async {
    final newsApi = NewsApiProvider();
    newsApi.client = MockClient((request) async {
      final jsonMap = {
        "by": "dhouston",
        "descendants": 71,
        "id": 99,
        "text": "hello",
        "dead": false,
        "parent": 99,
        "kids": [8952],
        "score": 111,
        "time": 1175714200,
        "title": "My YC app: Dropbox - Throw away your USB drive",
        "type": "story",
        "deleted": false,
        "url": "http://www.getdropbox.com/u/2/screencast.html",
      };
      return Response(json.encode(jsonMap), 200);
    });

    final item = await newsApi.fetchItem(99);
    expect(item.id, 123);
  });
}
