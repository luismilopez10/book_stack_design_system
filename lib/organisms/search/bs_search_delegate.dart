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
  BsSearchDelegate({
    required BsSearchArgs<T> args,
    required BsSearchController<T> controller,
    required BsItemBuilder<T> itemBuilder,
    this.onItemSelected,
  }) : _args = args,
       _controller = controller,
       _itemBuilder = itemBuilder {
    _debouncer = BsDebouncer<String>(duration: _args.debouncerDuration);
  }

  final BsSearchArgs<T> _args;
  final BsSearchController<T> _controller;
  final BsItemBuilder<T> _itemBuilder;
  final void Function(T item)? onItemSelected;

  late final BsDebouncer<String> _debouncer;

  @override
  String? get searchFieldLabel => _args.searchLabel;

  @override
  List<Widget>? buildActions(BuildContext context) {
    return <Widget>[
      IconButton(
        onPressed: () {
          query = '';
          _args.onClear?.call();
        },
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        _args.onBack?.call();
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) => buildSuggestions(context);

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return _emptyContainer();
    }

    _scheduleQuery(context, query);

    return StreamBuilder<List<T>>(
      stream: _controller.suggestionsStream,
      builder: (BuildContext _, AsyncSnapshot<List<T>> snapshot) {
        if (!snapshot.hasData) {
          return _emptyContainer();
        }

        final List<T> items = snapshot.data!;
        if (items.isEmpty) {
          return _emptyContainer();
        }

        return ListView.builder(
          itemCount: items.length,
          itemBuilder: (BuildContext _, int index) {
            final T item = items[index];
            final bool isLast = index == items.length - 1;

            return GestureDetector(
              onTap: onItemSelected == null
                  ? null
                  : () => onItemSelected!(item),
              behavior: HitTestBehavior.opaque,
              child: Column(
                children: <Widget>[
                  _itemBuilder(
                    context,
                    item,
                    index,
                    isLast,
                    _controller.isLoadingNextPage,
                  ),
                  if (_controller.isLoadingNextPage && isLast)
                    const Padding(
                      padding: EdgeInsets.all(BsSpacing.SPACE_MEDIUM),
                      child: Center(child: CircularProgressIndicator()),
                    ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _emptyContainer() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(BsSpacing.SPACE_LARGE),
        child:
            _args.emptyState ??
            BsText(_args.emptySearchText, textAlign: TextAlign.center),
      ),
    );
  }

  void _scheduleQuery(BuildContext context, String query) {
    _debouncer.value = '';
    _debouncer.onValue = (String value) async {
      await _controller.onQueryChanged(context, value);
    };

    final Timer timer = Timer.periodic(const Duration(milliseconds: 150), (_) {
      _debouncer.value = query;
    });

    unawaited(
      Future<void>.delayed(const Duration(milliseconds: 151)).then((_) {
        timer.cancel();
      }),
    );
  }

  @override
  void close(BuildContext context, T? result) {
    _debouncer.dispose();
    _controller.dispose();
    super.close(context, result);
  }
}
