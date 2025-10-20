import 'package:flutter/widgets.dart';

abstract class BsSearchController<T> {
  Stream<List<T>> get suggestionsStream;
  bool get isLoadingNextPage;
  Future<void> onQueryChanged(BuildContext context, String query);
  void dispose();
}
