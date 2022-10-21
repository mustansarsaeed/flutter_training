import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:news/src/resources/repository.dart';
import 'package:rxdart/rxdart.dart';
import '../models/item_model.dart';

class StoriesBloc {
  final _repository = Repository();
  final _topIds = PublishSubject<List<int>>();
  final _items = BehaviorSubject<int>();

  Stream<List<int>> get topIds => _topIds.stream;

  Function(int) get fetchItem => _items.sink.add;

  late Stream<Map<int, Future<ItemModel>>> items;

  StoriesBloc() {
    items = _items.stream.transform(_itemsTransformer());
  }

  fetchTopIds() async {
    final ids = await _repository.fetchTopIds();
    _topIds.sink.add(ids);
  }

  _itemsTransformer() {
    return ScanStreamTransformer(
        (Map<int, Future<ItemModel>> cache, int id, index) {
      _items.sink.add(id);
      cache[id] = _repository.fetchItem(id);

      return cache;
    }, <int, Future<ItemModel>>{});
  }

  dispose() {
    _topIds.close();
  }
}
