import 'package:flutter/material.dart';
import '../blocks/stories_provider.dart';
import '../models/item_model.dart';
import '../widgets/loading_container.dart';

class NewsListTile extends StatelessWidget {
  late int itemId;

  NewsListTile({required int this.itemId});

  Widget build(context) {
    final bloc = StoriesProvider.of(context);

    return StreamBuilder(
      stream: bloc.items,
      builder: (context, AsyncSnapshot<Map<int, Future<ItemModel>>> snapshot) {
        if (!snapshot.hasData) {
          return LoadingContainer();
        }
        return FutureBuilder(
          future: snapshot.data![itemId],
          builder: (context, AsyncSnapshot<ItemModel> itemSnapshot) {
            if (!itemSnapshot.hasData) {
              return LoadingContainer();
            }

            return buildListTile(itemSnapshot.data!);
          },
        );
      },
    );
  }

  Widget buildTile(ItemModel item) {
    return Column(
      children: [
        ListTile(
          title: Text(item.title),
          subtitle: Text('${item.score} points'),
          trailing: Column(
            children: [Icon(Icons.comment), Text('${item.descendants}')],
          ),
        ),
        Divider(
          height: 8.0,
        ),
      ],
    );
  }

  Widget buildListTile(ItemModel item) {
    return buildTile(item);
  }
}
