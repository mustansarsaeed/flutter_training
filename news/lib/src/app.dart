import 'package:flutter/material.dart';
import 'blocks/stories_provider.dart';
import 'blocks/comments_provider.dart';
import 'screens/news_list.dart';
import 'screens/news_list_detail.dart';

class App extends StatelessWidget {
  Widget build(context) {
    return CommentsProvider(
        key: ValueKey('CommentsProvider'),
        child: StoriesProvider(
          key: ValueKey('StoriesProviderKey'),
          child: MaterialApp(
            title: 'News!',
            onGenerateRoute: routes,
          ),
        ));
  }

  Route routes(RouteSettings settings) {
    if (settings.name == "/") {
      return MaterialPageRoute(
        builder: (context) {
          return NewsList();
        },
      );
    } else {
      return MaterialPageRoute(
        builder: (context) {
          final itemId = int.parse(settings.name!.replaceFirst("/", ""));
          CommentsBloc commentsBloc = CommentsProvider.of(context);
          commentsBloc.getCommentsById(itemId);
          return NewsListDetail(itemId: itemId);
        },
      );
    }
  }
}
