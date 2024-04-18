import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:flutter/material.dart';
import 'package:vc_product_widgets/helper/sizer_helper.dart';
import 'package:vc_product_widgets/utils/color_constant.dart';

import '../../helper/smooth_page_indicator/effects/worm_effect.dart';
import '../../helper/smooth_page_indicator/indicator/smooth_page_indicator.dart';

class CarouselDynamicSize extends StatefulWidget {
  final int itemCount;
  final Widget Function(BuildContext context, int index) itemBuilder;
  final Function(int index)? onPageChanged;
  final Widget emptyItemWidget;

  const CarouselDynamicSize({
    super.key,
    required this.itemCount,
    required this.itemBuilder,
    this.onPageChanged,
    required this.emptyItemWidget,
  });

  @override
  State<CarouselDynamicSize> createState() => _CarouselDynamicSizeState();
}

class _CarouselDynamicSizeState extends State<CarouselDynamicSize> {
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    if (widget.itemCount == 0) {
      return widget.emptyItemWidget;
    }

    return Column(
      children: [
        ExpandablePageView.builder(
          controller: _pageController,
          itemCount: widget.itemCount,
          itemBuilder: widget.itemBuilder,
          onPageChanged: widget.onPageChanged,
        ),
        context.emptySizedHeightBoxLow,
        SmoothPageIndicator(
          controller: _pageController,
          count: widget.itemCount,
          effect: WormEffect(
            activeDotColor: VCProductColors.instance.backgroundGradientStart,
            dotColor: VCProductColors.instance.widgetBorderColor,
            type: WormType.thin,
            dotHeight: context.allWidth * .025,
            dotWidth: context.allWidth * .025,
          ),
          onDotClicked: (index) {
            _pageController.jumpToPage(index);
          },
        ),
      ],
    );
  }
}
