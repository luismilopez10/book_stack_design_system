import 'package:flutter/material.dart';

import '../book_stack_design_system.dart';

class BsErrorView extends StatelessWidget {
  const BsErrorView({super.key, required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(BsSpacing.SPACE_LARGE),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const Icon(
              Icons.error_outline,
              size: BsIconsSize.ICON_SIZE_EXTRA_LARGE,
              color: BsColors.ERROR,
            ),
            const SizedBox(height: BsSpacing.SPACE_MEDIUM),
            BsText(message, textAlign: TextAlign.center),
            const SizedBox(height: BsSpacing.SPACE_SMALL),
            GestureDetector(
              onTap: onRetry,
              child: BsText(
                'Volver a intentar',
                style: BsTypography.BODY_1.copyWith(
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
