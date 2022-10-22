import 'package:flutter/material.dart';
import 'blocks/stories_provider.dart';
import 'screens/news_list.dart';

class App extends StatelessWidget {
  Widget build(context) {
    return StoriesProvider(
      key: ValueKey('StoriesProviderKey'),
      child: MaterialApp(
        title: 'News!',
        home: NewsList(),
      ),
    );
  }
}
