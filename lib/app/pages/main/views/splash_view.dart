import 'package:flutter/material.dart';
import '../../../core.dart';

class SplashView extends StatelessWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarOpacity: 0,
        toolbarHeight: 0,
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: SafeArea(
        top: false,
        child: Stack(
          children: [
            Container(color: Theme.of(context).scaffoldBackgroundColor),
            Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Flexible(
                  flex: 1,
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          margin: EdgeInsets.all(Get.width * 0.25),
                          child: Image.asset(AssetsConst.icLaunch),
                        ),
                      ],
                    ),
                  ),
                ),
                Center(
                  child: ThreeBounceLoading(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
