import 'package:flutter/material.dart';
import '../blocks/stories_provider.dart';

class Refresh extends StatelessWidget {
  late Widget child;

  Refresh({required this.child});

  Widget build(context) {
    final bloc = StoriesProvider.of(context);

    return RefreshIndicator(
      child: child,
      onRefresh: () async {
        await bloc.clearCache();
        await bloc.fetchTopIds();
      },
    );
  }
}
