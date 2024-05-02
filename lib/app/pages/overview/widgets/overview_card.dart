import 'package:flutter/material.dart';
import 'package:usdol/app/core.dart';

class OverviewCard extends StatelessWidget {
  const OverviewCard({
    super.key,
    required this.child,
    required this.title,
    this.topLeftIcon,
  });
  final Widget child;
  final Widget? topLeftIcon;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppProperties.circleRadius),
        color: Colors.white,
      ),
      width: double.infinity,
      padding: const EdgeInsets.all(AppProperties.contentMargin),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style:
                      AppTextStyles.title().copyWith(color: AppColors.grey600),
                ),
              ),
              topLeftIcon ?? const SizedBox.shrink(),
            ],
          ),
          const SizedBox(
            height: AppProperties.contentMargin,
          ),
          child,
        ],
      ),
    );
  }
}
