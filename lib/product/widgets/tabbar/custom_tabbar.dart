import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

import '../../../core/init/theme/dark_color_scheme/dark_color_scheme.dart';
import '../../constants/product_constants.dart';

class CustomTabbar extends StatelessWidget {
  final Function(int newIndex) onTap;
  final TabController tabController;
  const CustomTabbar(
      {Key? key, required this.onTap, required this.tabController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: context.paddingLow,
      child: Center(
        child: TabBar(
          indicatorPadding: const EdgeInsets.symmetric(vertical: 5),
          indicator: BoxDecoration(
            shape: BoxShape.rectangle,
            color: DarkColorScheme.instance!.chartGreen,
            borderRadius: BorderRadius.circular(20),
          ),
          splashBorderRadius: BorderRadius.circular(20),
          controller: tabController,
          tabs: ProductConstants.tabs,
          onTap: onTap,
        ),
      ),
    );
  }
}
