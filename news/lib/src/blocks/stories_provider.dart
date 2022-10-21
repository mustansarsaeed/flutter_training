import 'stories_block.dart';
import 'package:flutter/material.dart';

export 'stories_block.dart';

class StoriesProvider extends InheritedWidget {
  late StoriesBloc bloc;

  StoriesProvider({required Key key, Widget? child})
      : bloc = StoriesBloc(),
        super(key: key, child: child!);

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => true;

  static StoriesBloc of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<StoriesProvider>()!.bloc;
}
