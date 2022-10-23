import 'package:flutter/material.dart';
import '../blocks/comments_provider.dart';
import '../models/item_model.dart';

class NewsListDetail extends StatelessWidget {
  late int itemId;

  NewsListDetail({required this.itemId});

  Widget build(context) {
    final commentsBloc = CommentsProvider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Details'),
      ),
      body: buildBody(commentsBloc),
    );
  }

  buildBody(CommentsBloc commentsBloc) {
    return StreamBuilder(
      stream: commentsBloc.commentsOutput,
      builder: (context, AsyncSnapshot<Map<int, Future<ItemModel>>> snapshot) {
        if (!snapshot.hasData) {
          return Text('Loading ...');
        }

        final itemFuture = snapshot.data![itemId];

        return FutureBuilder(
          future: itemFuture,
          builder: (context, AsyncSnapshot<ItemModel> itemSnapshot) {
            if (!itemSnapshot.hasData) {
              return Text('Item Loading ...');
            }

            return Text(itemSnapshot.data!.title);
          },
        );
      },
    );
  }
}
