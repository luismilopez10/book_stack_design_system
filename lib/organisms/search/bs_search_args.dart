import 'package:flutter/widgets.dart';

import '../../book_stack_design_system.dart';

class BsSearchArgs<T> {
  BsSearchArgs({
    required this.searchLabel,
    required this.emptySearchText,
    this.debouncerDuration = const Duration(milliseconds: 300),
    this.emptyState,
    this.onClear,
    this.onBack,
    required this.controller,
    required this.itemBuilder,
    this.onItemSelected,
    this.errorBuilder,
    this.shimmerBuilder,
  });

  final String searchLabel;
  final String emptySearchText;
  final Duration debouncerDuration;
  final Widget? emptyState;
  final VoidCallback? onClear;
  final VoidCallback? onBack;
  final BsSearchController<T> controller;
  final BsItemBuilder<T> itemBuilder;
  final void Function(T item)? onItemSelected;
  final Widget Function(BuildContext context, VoidCallback retry)? errorBuilder;
  final Widget Function(BuildContext context)? shimmerBuilder;
}
