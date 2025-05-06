import 'package:flutter/material.dart';

import 'shimmer.dart';

class Loadinglist extends StatelessWidget {
  final int itemCount;
  const Loadinglist({super.key, this.itemCount = 5});

  @override
  Widget build(BuildContext context) {
    return Shimmer(
      child: ListView(
        physics: const NeverScrollableScrollPhysics(),
        children: [
          for (int i = 0; i < itemCount; i++)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ShimmerLoading(
                isLoading: true,
                child: Container(
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 4,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
