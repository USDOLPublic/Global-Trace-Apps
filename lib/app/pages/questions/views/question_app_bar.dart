import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:usdol/app/core.dart';

class QuestionAppBar extends AppBar {
  QuestionAppBar({
    Key? key,
    required Widget body,
  }) : super(
          key: key,
          backgroundColor: AppColors.grey100,
          flexibleSpace: Container(
            height: Get.height,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: SafeArea(
              child: body,
            ),
          ),
          systemOverlayStyle: SystemUiOverlayStyle.dark,
          elevation: 4,
          automaticallyImplyLeading: false,
        );
}

class QuestionAppBarBody extends StatelessWidget {
  final String title;
  final int length;
  final int indexSelected;
  final Function? onBack;
  final Function(int)? onTapIndicator;

  const QuestionAppBarBody({
    Key? key,
    required this.length,
    this.onBack,
    required this.title,
    required this.indexSelected,
    this.onTapIndicator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
          onTap: () => onBack?.call(),
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          hoverColor: Colors.transparent,
          child: Container(
            alignment: Alignment.centerLeft,
            width: 48,
            child: Center(
              child: SvgPicture.asset(
                AssetsConst.backButton,
                width: 18,
              ),
            ),
          ),
        ),
        const SizedBox(
          width: 8,
        ),
        Expanded(
          child: Column(
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.w800,
                  color: AppColors.green800,
                  fontSize: 16,
                ),
                maxLines: 2,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 4,
              ),
              Container(
                height: 26,
                alignment: Alignment.center,
                margin: const EdgeInsets.symmetric(horizontal: 24),
                child: ListView.builder(
                    itemCount: length,
                    physics: const NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemBuilder: (_, index) {
                      double indicatorWidth = (Get.width - 104 - (length - 1) * 4) / length;
                      if (indicatorWidth > 60) {
                        indicatorWidth = 60;
                      }
                      return InkWell(
                        onTap: () => onTapIndicator?.call(index),
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        child: Center(
                          child: Container(
                            width: indicatorWidth,
                            height: 4,
                            margin: EdgeInsets.only(right: index == length - 1 ? 0 : 4),
                            decoration: BoxDecoration(
                              color: index < indexSelected ? AppColors.green700 : AppColors.grey200,
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      );
                    }),
              ),
            ],
          ),
        ),
        const SizedBox(
          width: 56,
        ),
      ],
    );
  }
}
