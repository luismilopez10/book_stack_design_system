import 'dart:async';

import 'package:flutter/material.dart';

import '../../book_stack_design_system.dart';

typedef BsItemBuilder<T> =
    Widget Function(
      BuildContext context,
      T item,
      int index,
      bool isLoadingNextPage,
      bool isLast,
    );

class BsSearchDelegate<T> extends SearchDelegate<T?> {
  BsSearchDelegate({required this.args});

  final BsSearchArgs<T> args;

  @override
  String? get searchFieldLabel => args.searchLabel;

  @override
  List<Widget>? buildActions(BuildContext context) {
    return <Widget>[
      IconButton(
        onPressed: () {
          query = '';
          args.onClear?.call();
        },
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        args.onBack?.call();
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) => buildSuggestions(context);

  @override
  Widget buildSuggestions(BuildContext context) {
    unawaited(args.controller.onQueryChanged(context, query));

    return ValueListenableBuilder<BsSearchState>(
      valueListenable: args.controller.state,
      builder: (_, BsSearchState state, __) {
        switch (state) {
          case BsSearchState.idle:
            return const SizedBox.shrink();

          case BsSearchState.loading:
            return args.shimmerBuilder?.call(context) ?? const BsSkeletonList();

          case BsSearchState.error:
            return args.errorBuilder?.call(context, () {
                  unawaited(args.controller.retryLastQuery(context));
                }) ??
                BsErrorView(
                  message: 'Ocurrió un error al cargar los resultados.',
                  onRetry: () =>
                      unawaited(args.controller.retryLastQuery(context)),
                );

          case BsSearchState.success:
            return StreamBuilder<List<T>>(
              stream: args.controller.suggestionsStream,
              initialData: <T>[],
              builder: (_, AsyncSnapshot<List<T>> snapshot) {
                final List<T> items = snapshot.data ?? <T>[];
                if (items.isEmpty) {
                  return _emptyContainer();
                }

                return ValueListenableBuilder<bool>(
                  valueListenable: args.controller.isLoadingNextPageListenable,
                  builder: (_, bool isLoadingNextPage, __) {
                    return NotificationListener<ScrollNotification>(
                      onNotification: (ScrollNotification notification) {
                        if (notification.metrics.pixels >=
                            notification.metrics.maxScrollExtent - 150) {
                          unawaited(args.controller.loadMore());
                        }
                        return false;
                      },
                      child: ListView.builder(
                        itemCount: items.length,
                        itemBuilder: (_, int index) {
                          final T item = items[index];
                          final bool isLast = index == items.length - 1;

                          return GestureDetector(
                            onTap: args.onItemSelected == null
                                ? null
                                : () => args.onItemSelected!(item),
                            behavior: HitTestBehavior.opaque,
                            child: Column(
                              children: <Widget>[
                                args.itemBuilder(
                                  context,
                                  item,
                                  index,
                                  isLoadingNextPage,
                                  isLast,
                                ),
                                if (isLoadingNextPage && isLast)
                                  const Padding(
                                    padding: EdgeInsets.all(
                                      BsSpacing.SPACE_MEDIUM,
                                    ),
                                    child: Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                  ),
                              ],
                            ),
                          );
                        },
                      ),
                    );
                  },
                );
              },
            );
        }
      },
    );
  }

  Widget _emptyContainer() => Center(
    child: Padding(
      padding: const EdgeInsets.all(BsSpacing.SPACE_LARGE),
      child:
          args.emptyState ??
          BsText(args.emptySearchText, textAlign: TextAlign.center),
    ),
  );

  @override
  void close(BuildContext context, T? result) {
    args.controller.dispose();
    super.close(context, result);
  }
}
