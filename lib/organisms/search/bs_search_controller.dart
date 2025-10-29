import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

enum BsSearchState { idle, loading, success, error }

abstract class BsSearchController<T> {
  Stream<List<T>> get suggestionsStream;
  ValueNotifier<BsSearchState> get state;
  ValueListenable<bool> get isLoadingNextPageListenable;

  Future<void> loadMore();
  Future<void> onQueryChanged(BuildContext context, String query);
  Future<void> retryLastQuery(BuildContext context);

  void dispose();
}
