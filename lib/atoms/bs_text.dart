import 'package:flutter/material.dart';

import '../book_stack_design_system.dart';

class BsText extends StatelessWidget {
  const BsText(
    this.text, {
    super.key,
    this.style = BsTypography.BODY_1,
    this.color,
    this.maxLines,
    this.textAlign,
    this.overflow,
  });

  final String text;
  final TextStyle style;
  final Color? color;
  final int? maxLines;
  final TextAlign? textAlign;
  final TextOverflow? overflow;

  @override
  Widget build(BuildContext context) {
    final bool isDarkTheme = Theme.of(context).brightness == Brightness.dark;

    return Text(
      text,
      maxLines: maxLines,
      overflow: overflow,
      textAlign: textAlign,
      style: style.copyWith(
        color:
            color ?? (isDarkTheme ? BsColors.NEUTRAL_00 : BsColors.NEUTRAL_01),
      ),
    );
  }
}
