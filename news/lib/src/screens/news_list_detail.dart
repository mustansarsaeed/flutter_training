import 'package:flutter/material.dart';
import '../blocks/comments_provider.dart';
import '../models/item_model.dart';
import '../widgets/comment.dart';

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

            return buildList(commentsBloc, itemSnapshot.data!, snapshot.data!);
          },
        );
      },
    );
  }

  Widget buildList(
      CommentsBloc bloc, ItemModel item, Map<int, Future<ItemModel>> itemMap) {
    var children = <Widget>[buildTitle(item)];

    var comments = <Widget>[];
    item.kids.forEach((kidId) {
      comments.add(Comment(
        itemId: kidId,
        itemMap: itemMap,
        depth: 0,
      ));
    });

    children.addAll(comments);

    return ListView(
      children: children,
    );
  }

  Widget buildTitle(ItemModel item) {
    return Container(
      margin: EdgeInsets.all(10.0),
      child: Text(
        item.title,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
