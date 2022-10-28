import 'package:flutter/material.dart';
import 'package:news/src/models/item_model.dart';
import '../widgets/loading_container.dart';

class Comment extends StatelessWidget {
  late int itemId;
  late Map<int, Future<ItemModel>> itemMap;
  late int depth;

  Comment({required this.itemId, required this.itemMap, required this.depth});

  Widget build(BuildContext context) {
    return FutureBuilder(
      future: this.itemMap[this.itemId],
      builder: (context, AsyncSnapshot<ItemModel> snapshot) {
        if (!snapshot.hasData) {
          return LoadingContainer();
        }

        final item = snapshot.data!;
        final children = <Widget>[
          ListTile(
            title: Text(item.text),
            subtitle: Text(item.by),
            contentPadding: EdgeInsets.only(
              right: 16.0,
              left: (depth + 1) * 16.0,
            ),
          ),
          Divider(),
        ];

        item.kids.forEach((kidId) {
          children.add(
            Comment(
              itemId: kidId,
              itemMap: itemMap,
              depth: depth + 1,
            ),
          );
        });

        return Column(
          children: children,
        );
      },
    );
  }
}
