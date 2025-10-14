import 'package:flutter/material.dart';

import '../book_stack_design_system.dart';

class BsAppBar extends StatelessWidget implements PreferredSizeWidget {
  const BsAppBar({
    super.key,
    required this.title,
    this.leftAppBarIcon,
    this.rightAppBarIcon,
    this.midRightAppBarIcon,
    this.onLeftAppBarPressed,
    this.onRightAppBarPressed,
    this.onMidRightAppBarPressed,
  });

  final String title;
  final IconData? leftAppBarIcon;
  final IconData? rightAppBarIcon;
  final IconData? midRightAppBarIcon;
  final VoidCallback? onLeftAppBarPressed;
  final VoidCallback? onRightAppBarPressed;
  final VoidCallback? onMidRightAppBarPressed;

  @override
  Size get preferredSize => const Size(double.infinity, 60);
  @override
  Widget build(BuildContext context) {
    final bool isDarkTheme = Theme.of(context).brightness == Brightness.dark;

    return SafeArea(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: BsSpacing.SPACE_MEDIUM),
        color: isDarkTheme ? BsColors.NEUTRAL_01 : BsColors.NEUTRAL_00,
        child: Stack(
          children: <Widget>[
            if (onLeftAppBarPressed != null)
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: BsSpacing.SPACE_MEDIUM),
                  child: GestureDetector(
                    onTap: onLeftAppBarPressed,
                    child: Icon(
                      leftAppBarIcon,
                      size: BsIconsSize.ICON_SIZE_SMALL,
                      color: isDarkTheme
                          ? BsColors.NEUTRAL_00
                          : BsColors.NEUTRAL_01,
                    ),
                  ),
                ),
              ),
            Align(child: BsText(title, style: BsTypography.HEADER_2)),
            Positioned(
              right: 0.0,
              child: Row(
                children: <Widget>[
                  if (onMidRightAppBarPressed != null)
                    Padding(
                      padding: const EdgeInsets.only(
                        right: BsSpacing.SPACE_MEDIUM,
                      ),
                      child: GestureDetector(
                        onTap: onMidRightAppBarPressed,
                        child: Icon(
                          midRightAppBarIcon,
                          size: BsIconsSize.ICON_SIZE_SMALL,
                          color: isDarkTheme
                              ? BsColors.NEUTRAL_00
                              : BsColors.NEUTRAL_01,
                        ),
                      ),
                    ),
                  if (onRightAppBarPressed != null)
                    Padding(
                      padding: const EdgeInsets.only(
                        right: BsSpacing.SPACE_MEDIUM,
                      ),
                      child: GestureDetector(
                        onTap: onRightAppBarPressed,
                        child: Icon(
                          rightAppBarIcon,
                          size: BsIconsSize.ICON_SIZE_SMALL,
                          color: isDarkTheme
                              ? BsColors.NEUTRAL_00
                              : BsColors.NEUTRAL_01,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
