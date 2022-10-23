import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import '../models/item_model.dart';
import '../resources/repository.dart';

class CommentsBloc {
  final _repository = Repository();
  final commentsFetcher = PublishSubject<int>();
  final commentsOutput = BehaviorSubject<Map<int, Future<ItemModel>>>();

  Stream<Map<int, Future<ItemModel>>> get commentsStream =>
      commentsOutput.stream;

  Function(int) get getCommentsById => commentsFetcher.sink.add;

  CommentsBloc() {
    commentsFetcher.transform(_commentsTransformer()).pipe(commentsOutput);
  }

  _commentsTransformer() {
    return ScanStreamTransformer(
        (Map<int, Future<ItemModel>> cache, int id, index) {
      print('$index');
      cache[id] = _repository.fetchItem(id);
      cache[id]!.then((item) {
        item.kids.forEach((element) {
          getCommentsById(element);
        });
      });

      return cache;
    }, <int, Future<ItemModel>>{});
  }
}
