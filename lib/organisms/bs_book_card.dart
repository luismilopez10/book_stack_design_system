import 'package:flutter/material.dart';

import '../book_stack_design_system.dart';

enum BookCardState { loading, error, success }

class BsBookCard extends StatelessWidget {
  const BsBookCard({
    super.key,
    required this.id,
    required this.title,
    required this.subtitle,
    required this.extraText,
    required this.imageUrl,
    required this.url,
    required this.placeHolderPath,
    required this.imageNotFoundPath,
    this.thumbWidth = 100.0,
    this.thumbHeight = 80.0,
    this.elevation = 2.0,
    this.clipBehavior = Clip.antiAlias,
  });

  final String id;
  final String title;
  final String subtitle;
  final String extraText;
  final String imageUrl;
  final String url;
  final String placeHolderPath;
  final String imageNotFoundPath;
  final double thumbWidth;
  final double thumbHeight;
  final double elevation;
  final Clip clipBehavior;

  @override
  Widget build(BuildContext context) {
    final bool isDarkTheme = Theme.of(context).brightness == Brightness.dark;

    return Card(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(BsBorderRadius.SMALL),
      ),
      margin: EdgeInsets.zero,
      clipBehavior: clipBehavior,
      elevation: elevation,
      color: isDarkTheme ? BsColors.PRIMARY_00 : BsColors.HABANO,
      child: Column(
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width: thumbWidth,
                height: thumbHeight,
                margin: const EdgeInsets.symmetric(
                  vertical: BsSpacing.SPACE_MEDIUM,
                ),
                child: Hero(
                  tag: id,
                  child: BsImageContainer(
                    imageUrl: imageUrl,
                    placeHolderPath: placeHolderPath,
                    imageNotFoundPath: imageNotFoundPath,
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: BsSpacing.SPACE_MEDIUM,
                    bottom: BsSpacing.SPACE_MEDIUM,
                    right: BsSpacing.SPACE_MEDIUM,
                  ),
                  child: SizedBox(
                    height: thumbHeight,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        BsText(
                          title,
                          style: BsTypography.HEADER_4,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        BsText(
                          subtitle,
                          style: BsTypography.BODY_3,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const Spacer(),
                        BsText(
                          extraText,
                          style: BsTypography.BODY_2,
                          color: BsColors.SECONDARY_01,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
