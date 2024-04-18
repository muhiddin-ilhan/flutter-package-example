import 'package:flutter/material.dart';

import '../../helper/carousel_slider/controller/carousel_controller.dart';
import '../../helper/carousel_slider/option/carousel_options.dart';
import '../../helper/carousel_slider/slider/carousel_slider.dart';
import '../../helper/smooth_page_indicator/effects/indicator_effect.dart';
import '../../helper/smooth_page_indicator/effects/worm_effect.dart';
import '../../helper/smooth_page_indicator/indicator/smooth_page_indicator.dart';

class VCCarousel<T> extends StatefulWidget {
  final List<T> items;
  final Widget Function(T item) itemBuilder;
  final Function(int pageIndex)? onPageChange;
  final bool disableGesture;
  final CarouselController? carouselController;

  // -- Indicator Option -- //
  final IndicatorEffect? indicatorEffect;
  final EdgeInsets indicatorMargin;

  // ---  Carousel Options  --- //
  /// Set carousel height and overrides any existing [aspectRatio].
  final double? height;

  /// Aspect ratio is used if no height have been declared.
  final double aspectRatio;

  /// The fraction of the viewport that each page should occupy.
  final double viewportFraction;

  /// The initial page to show when first creating the [CarouselSlider].
  final int initialPage;

  ///Determines if carousel should loop infinitely or be limited to item length.
  final bool enableInfiniteScroll;

  ///Determines if carousel should loop to the closest occurence of requested page.
  final bool animateToClosest;

  /// Reverse the order of items if set to true.
  final bool reverse;

  /// Enables auto play, sliding one page at a time.
  final bool autoPlay;

  /// Sets Duration to determent the frequency of slides when
  final Duration autoPlayInterval;

  /// The animation duration between two transitioning pages while in auto playback.
  final Duration autoPlayAnimationDuration;

  /// Determines the animation curve physics.
  final Curve autoPlayCurve;

  /// Determines if current page should be larger than the side images,
  final bool? enlargeCenterPage;

  /// Set to false to disable page snapping, useful for custom scroll behavior.
  final bool pageSnapping;

  /// If `true`, the auto play function will be paused when user is interacting with
  /// the carousel, and will be resumed when user finish interacting.
  final bool pauseAutoPlayOnTouch;

  /// If `true`, the auto play function will be paused when user is calling
  /// pageController's `nextPage` or `previousPage` or `animateToPage` method.
  /// And after the animation complete, the auto play will be resumed.
  final bool pauseAutoPlayOnManualNavigate;

  /// If `enableInfiniteScroll` is `false`, and `autoPlay` is `true`, this option
  /// decide the carousel should go to the first item when it reach the last item or not.
  /// If set to `true`, the auto play will be paused when it reach the last item.
  /// If set to `false`, the auto play function will animate to the first item when it was
  /// in the last item.
  final bool pauseAutoPlayInFiniteScroll;

  /// Use [enlargeStrategy] to determine which method to enlarge the center page.
  final CenterPageEnlargeStrategy enlargeStrategy;

  /// How much the pages next to the center page will be scaled down.
  /// If `enlargeCenterPage` is false, this property has no effect.
  final double enlargeFactor;

  /// Whether or not to disable the `Center` widget for each slide.
  final bool disableCenter;

  /// Whether to add padding to both ends of the list.
  /// If this is set to true and [viewportFraction] < 1.0, padding will be added such that
  /// the first and last child slivers will be in the center of the viewport when scrolled
  /// all the way to the start or end, respectively.
  /// If [viewportFraction] >= 1.0, this property has no effect.
  /// This property defaults to true and must not be null.
  final bool padEnds;

  const VCCarousel({
    super.key,
    required this.items,
    required this.itemBuilder,
    this.onPageChange,
    this.height,
    this.aspectRatio = 16 / 9,
    this.viewportFraction = 1,
    this.initialPage = 0,
    this.enableInfiniteScroll = true,
    this.animateToClosest = true,
    this.reverse = false,
    this.autoPlay = false,
    this.autoPlayInterval = const Duration(seconds: 4),
    this.autoPlayAnimationDuration = const Duration(milliseconds: 800),
    this.autoPlayCurve = Curves.fastOutSlowIn,
    this.enlargeCenterPage = false,
    this.pageSnapping = true,
    this.pauseAutoPlayOnTouch = true,
    this.pauseAutoPlayOnManualNavigate = true,
    this.pauseAutoPlayInFiniteScroll = false,
    this.enlargeStrategy = CenterPageEnlargeStrategy.scale,
    this.enlargeFactor = 0.3,
    this.disableCenter = false,
    this.padEnds = true,
    this.disableGesture = false,
    this.carouselController,
    this.indicatorEffect,
    this.indicatorMargin = const EdgeInsets.all(8.0),
  });

  @override
  State<VCCarousel<T>> createState() => _VCCarouselState<T>();
}

class _VCCarouselState<T> extends State<VCCarousel<T>> {
  int _activeIndex = 0;
  CarouselController? carouselController;

  @override
  void initState() {
    super.initState();
    _activeIndex = widget.initialPage;
    if (widget.carouselController != null) {
      carouselController = widget.carouselController!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CarouselSlider(
          carouselController: widget.carouselController,
          disableGesture: widget.disableGesture,
          items: widget.items.map((T item) => widget.itemBuilder(item)).toList(),
          options: CarouselOptions(
            height: widget.height,
            aspectRatio: widget.aspectRatio,
            autoPlay: widget.autoPlay,
            autoPlayAnimationDuration: widget.autoPlayAnimationDuration,
            autoPlayInterval: widget.autoPlayInterval,
            enableInfiniteScroll: widget.enableInfiniteScroll,
            enlargeCenterPage: widget.enlargeCenterPage,
            enlargeStrategy: widget.enlargeStrategy,
            enlargeFactor: widget.enlargeFactor,
            initialPage: widget.initialPage,
            pauseAutoPlayOnManualNavigate: widget.pauseAutoPlayOnManualNavigate,
            pauseAutoPlayOnTouch: widget.pauseAutoPlayOnTouch,
            viewportFraction: widget.viewportFraction,
            animateToClosest: widget.animateToClosest,
            autoPlayCurve: widget.autoPlayCurve,
            disableCenter: widget.disableCenter,
            padEnds: widget.padEnds,
            pageSnapping: widget.pageSnapping,
            pauseAutoPlayInFiniteScroll: widget.pauseAutoPlayInFiniteScroll,
            reverse: widget.reverse,
            onPageChanged: (int page, CarouselPageChangedReason reason) {
              if (widget.onPageChange != null) {
                widget.onPageChange!(page);
              }
              setState(() {
                _activeIndex = page;
              });
            },
          ),
        ),
        Padding(
          padding: widget.indicatorMargin,
          child: AnimatedSmoothIndicator(
            activeIndex: _activeIndex,
            count: widget.items.length,
            effect: widget.indicatorEffect ?? const WormEffect(
              activeDotColor: Color(0xFF15284B),
              dotColor: Color(0xffC9D9DD),
              type: WormType.thin,
              dotHeight: 10,
              dotWidth: 10,
            ),
            onDotClicked: (int index) {
              carouselController?.animateToPage(index);
            },
          ),
        )
      ],
    );
  }
}
