import 'package:flutter/material.dart';

import '../book_stack_design_system.dart';

class BsInfoItem extends StatelessWidget {
  const BsInfoItem({
    super.key,
    required this.boldText,
    required this.normalText,
  });

  final String boldText;
  final String normalText;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        BsText(boldText, style: BsTypography.SUBTITLE_2),
        Padding(
          padding: const EdgeInsets.only(left: BsSpacing.SPACE_SMALL),
          child: BsText(normalText, style: BsTypography.BODY_2),
        ),
      ],
    );
  }
}
