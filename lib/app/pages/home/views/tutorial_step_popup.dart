import 'package:flutter/material.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';
import 'package:usdol/app/core.dart';

class TutorialStepPopup extends StatelessWidget {
  final int currentStep;
  final int totalSteps;
  final String message;
  final TutorialCoachMark tutorialController;
  final bool isLeft;
  final bool isTop;
  final Future<void> Function(int step) onSwitchToStep;

  const TutorialStepPopup({
    Key? key,
    required this.currentStep,
    required this.totalSteps,
    required this.message,
    required this.tutorialController,
    this.isLeft = true,
    this.isTop = true,
    required this.onSwitchToStep,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (isTop)
          Align(
            alignment: isLeft ? Alignment.centerLeft : Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: ClipPath(
                clipper: CustomTriangleClipper(isTop: true),
                child: Container(
                  width: 28,
                  height: 20,
                  color: AppColors.white,
                ),
              ),
            ),
          ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppProperties.circleRadius),
            color: AppColors.white,
          ),
          padding: const EdgeInsets.all(8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    S.of(context).stepOfStep(currentStep, totalSteps),
                    style: const TextStyle(
                      color: AppColors.grey700,
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  IconButton(
                    key: const ValueKey('skipTutorialButton'),
                    onPressed: () => tutorialController.skip(),
                    icon: const Icon(Icons.close),
                  )
                ],
              ),
              Text(
                message,
                style: const TextStyle(
                  color: AppColors.grey700,
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (currentStep != 1 && currentStep != totalSteps)
                      TextButton(
                        onPressed: () async {
                          await onSwitchToStep(currentStep - 1);
                          tutorialController.previous();
                        },
                        child: Text(S.of(context).back),
                      ),
                    const SizedBox(width: 16),
                    currentStep == totalSteps
                        ? ElevatedButton(
                            onPressed: () async {
                              await onSwitchToStep(currentStep - 1);
                              tutorialController.previous();
                            },
                            child: Text(S.of(context).back),
                          )
                        : ElevatedButton(
                            onPressed: () async {
                              await onSwitchToStep(currentStep + 1);
                              tutorialController.next();
                            },
                            child: Text(S.of(context).next),
                          )
                  ],
                ),
              )
            ],
          ),
        ),
        if (!isTop)
          Align(
            alignment: isLeft ? Alignment.centerLeft : Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: ClipPath(
                clipper: CustomTriangleClipper(isTop: false),
                child: Container(
                  width: 28,
                  height: 20,
                  color: AppColors.white,
                ),
              ),
            ),
          ),
      ],
    );
  }
}

class CustomTriangleClipper extends CustomClipper<Path> {
  final bool isTop;
  CustomTriangleClipper({this.isTop = true});
  @override
  Path getClip(Size size) {
    final path = Path();
    if (isTop) {
      path.moveTo(size.width / 2, 0);
      path.lineTo(size.width, size.height);
      path.lineTo(0, size.height);
    } else {
      path.lineTo(size.width / 2, size.height);
      path.lineTo(size.width, 0);
      path.lineTo(0, 0);
    }
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
