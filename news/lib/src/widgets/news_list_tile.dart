import 'package:flutter/material.dart';
import '../models/item_model.dart';
import '../blocks/stories_provider.dart';

class NewsListTile extends StatelessWidget {
  late int itemId;

  NewsListTile({required this.itemId});

  Widget build(context) {
    final bloc = StoriesProvider.of(context);

    return StreamBuilder(
      stream: bloc.items,
      builder: (context, AsyncSnapshot<Map<int, Future<ItemModel>>> snapshot) {
        if (!snapshot.hasData) {
          return Text('Stream is loading ...');
        }
        return FutureBuilder(
          future: snapshot.data![itemId],
          builder: (context, AsyncSnapshot<ItemModel> itemSnapshot) {
            if (!itemSnapshot.hasData) {
              return Text('Loading item $itemId');
            }

            return Text(itemSnapshot.data!.title);
          },
        );
      },
    );
  }
}
