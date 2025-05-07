import 'package:crewmeister/config/theme/theme_mode_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'shimmer.dart';

class Loadinglist extends ConsumerWidget {
  final int itemCount;
  const Loadinglist({super.key, this.itemCount = 5});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ThemeMode theme = ref.watch(themeModeProvider);

    return Shimmer(
      linearGradient:
          theme == ThemeMode.light ? shimmerGradient : shimmerGradientDark,
      child: ListView.separated(
        separatorBuilder: (context, index) => const SizedBox(height: 16),
        itemCount: itemCount,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder:
            (context, index) => ShimmerLoading(
              child: Container(
                height: 100,
                decoration: BoxDecoration(
                  color:
                      theme == ThemeMode.light
                          ? Colors.white
                          : Colors.grey[800],
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
    );
  }
}
