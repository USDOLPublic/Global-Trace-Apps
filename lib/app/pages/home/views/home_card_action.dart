import 'package:flutter/material.dart';
import 'package:usdol/app/core.dart';

class HomeCardAction extends StatelessWidget {
  final String title;
  final String assetPath;
  final double aspectRatio;
  final Function()? onTap;
  final GlobalKey<State<StatefulWidget>>? cardKey;

  const HomeCardAction({
    Key? key,
    this.cardKey,
    required this.title,
    required this.assetPath,
    required this.aspectRatio,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      key: cardKey,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppProperties.circleRadius / 369 * Get.width),
      ),
      shadowColor: Theme.of(context).primaryColor,
      color: AppColors.grey100,
      margin:  EdgeInsets.zero,
      child: InkWell(
        borderRadius: BorderRadius.circular(AppProperties.circleRadius),
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            AspectRatio(
              aspectRatio: aspectRatio,
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(AppProperties.circleRadius),
                ),
                child: Image.asset(
                  assetPath,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    title,
                    style: const TextStyle(
                      color: AppColors.green800,
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
