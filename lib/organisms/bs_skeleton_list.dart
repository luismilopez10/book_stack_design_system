import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../book_stack_design_system.dart';

class BsSkeletonList extends StatelessWidget {
  const BsSkeletonList({
    super.key,
    this.items = 6,
    this.itemHeight = 110,
    this.horizontal = BsSpacing.SPACE_MEDIUM,
    this.vertical = BsSpacing.SPACE_SMALL,
  });

  final int items;
  final double itemHeight;
  final double horizontal;
  final double vertical;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items,
      itemBuilder: (_, __) => Padding(
        padding: EdgeInsets.symmetric(
          horizontal: horizontal,
          vertical: vertical,
        ),
        child: Shimmer.fromColors(
          baseColor: BsColors.NEUTRAL_03,
          highlightColor: BsColors.NEUTRAL_04,
          child: Container(
            height: itemHeight,
            decoration: const BoxDecoration(
              color: BsColors.PRIMARY_01,
              borderRadius: BorderRadius.all(BsBorderRadius.SMALL),
            ),
          ),
        ),
      ),
    );
  }
}
