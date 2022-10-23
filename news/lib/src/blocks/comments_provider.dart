import 'package:flutter/material.dart';
import 'comments_block.dart';
export 'comments_block.dart';

class CommentsProvider extends InheritedWidget {
  late CommentsBloc bloc;
  CommentsProvider({Key? key, Widget? child})
      : bloc = CommentsBloc(),
        super(key: key!, child: child!);

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => true;

  static CommentsBloc of(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<CommentsProvider>())!
        .bloc;
  }
}
