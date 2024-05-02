import 'package:flutter/material.dart';

import '../core.dart';

class ListViewShimmerLoading extends StatelessWidget {
  const ListViewShimmerLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ShimmerLoading(
      verticalPading: 5,
      horizontalPading: 10,
      shimmerWidget: ListView.separated(
        itemCount: 3,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (ct, idx) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 180,
                  color: Colors.grey,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 4.0),
                ),
                Container(
                  height: 20,
                  width: 140,
                  color: Colors.white,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 4.0),
                ),
                Container(height: 20, color: Colors.grey),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 4.0),
                ),
                Container(height: 40, color: Colors.grey),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 4.0),
                ),
                Row(
                  children: [
                    Container(height: 30, width: 120, color: Colors.grey),
                    const Expanded(child: SizedBox()),
                    Container(height: 30, width: 120, color: Colors.grey),
                  ],
                )
              ],
            ),
          );
        },
        separatorBuilder: (ct, idx) => const Padding(
          padding: EdgeInsets.symmetric(vertical: 8.0),
        ),
      ),
    );
  }
}
