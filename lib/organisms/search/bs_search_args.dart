import 'package:flutter/widgets.dart';

class BsSearchArgs<T> {
  BsSearchArgs({
    required this.searchLabel,
    required this.emptySearchText,
    this.debouncerDuration = const Duration(milliseconds: 300),
    this.emptyState,
    this.onClear,
    this.onBack,
  });

  final String searchLabel;
  final String emptySearchText;
  final Duration debouncerDuration;
  final Widget? emptyState;
  final VoidCallback? onClear;
  final VoidCallback? onBack;
}
