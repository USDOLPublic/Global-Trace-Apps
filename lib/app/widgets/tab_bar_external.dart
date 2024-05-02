import 'package:flutter/material.dart';

class TabBarExternal extends Container implements PreferredSizeWidget {
  TabBarExternal({Key? key, required this.tabBar}) : super(key: key);

  final TabBar tabBar;

  @override
  Size get preferredSize => tabBar.preferredSize;

  @override
  Widget build(BuildContext context) => Row(
    children: <Widget>[
      Container(
        width: 20,
        alignment: Alignment.centerRight,
        child: Icon(
          Icons.arrow_left,
          color: Theme.of(context).scaffoldBackgroundColor,
        ),
      ),
      Expanded(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 5),
          padding: const EdgeInsets.symmetric(horizontal: 3),
          decoration: BoxDecoration(
            // boxShadow: [
            //   BoxShadow(
            //     color: Colors.black.withAlpha(250),
            //     blurRadius:
            //         20.0, // has the effect of softening the shadow
            //     spreadRadius:
            //         2.0, // has the effect of extending the shadow
            //     offset: Offset(
            //       0.0, // horizontal, move right 10
            //       0.0, // vertical, move down 10
            //     ),
            //   )
            // ],
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(48),
              bottom: Radius.circular(48),
            ),
            color: Theme.of(context).scaffoldBackgroundColor,
          ),
          child: ClipRRect(
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(40),
              bottom: Radius.circular(40),
            ),
            child: tabBar,
          ),
        ),
      ),
      Container(
        width: 20,
        alignment: Alignment.centerLeft,
        child: Icon(
          Icons.arrow_right,
          color: Theme.of(context).scaffoldBackgroundColor,
        ),
      ),
    ],
  );
}
