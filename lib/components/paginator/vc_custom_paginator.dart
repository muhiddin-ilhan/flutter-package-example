// ignore_for_file: must_be_immutable

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class VCCustomPaginator extends StatelessWidget {
  VCCustomPaginator({
    super.key,
    required this.currentPage,
    required this.totalPage,
    this.onNewPage,
    this.paginatorHeight = 45,
    this.paginatorBackgroundColor,
    this.paginatorSelectedBackgroundColor,
    this.paginatorTextColor,
    this.paginatorSelectedTextColor,
    this.paginatorBorder,
    this.paginatorSelectedBorder,
    this.paginatorBorderRadius,
    this.spaceBetweenPaginators,
    this.paginatorTextStyle,
    this.paginatorSelectedTextStyle,
  });

  final int currentPage;
  final int totalPage;
  final Function(int)? onNewPage;
  final Color? paginatorBackgroundColor;
  final Color? paginatorSelectedBackgroundColor;
  final Color? paginatorTextColor;
  final Color? paginatorSelectedTextColor;
  final BoxBorder? paginatorBorder;
  final BoxBorder? paginatorSelectedBorder;
  final BorderRadius? paginatorBorderRadius;
  final double? spaceBetweenPaginators;
  final double paginatorHeight;
  final TextStyle? paginatorTextStyle;
  final TextStyle? paginatorSelectedTextStyle;

  ScrollController scrollController = ScrollController();

  _animateToSelectedPage() {
    try {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        double selectedElementPosition = (currentPage - 1) * (paginatorHeight - 8);

        scrollController.animateTo(
          selectedElementPosition,
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeInOut,
        );
      });
    } catch (e, s) {
      debugPrint(e.toString());
      if (kDebugMode) {
        print(s);
      }
    }
  }

  Widget arrowWidget({required bool isLeft}) => InkWell(
        onTap: onNewPage != null
            ? () {
                if (isLeft) {
                  if (currentPage > 1) {
                    onNewPage!(currentPage - 1);
                  }
                } else {
                  if (currentPage < totalPage) {
                    onNewPage!(currentPage + 1);
                  }
                }
              }
            : null,
        borderRadius: paginatorBorderRadius ?? BorderRadius.circular(8),
        child: Container(
          height: paginatorHeight,
          width: paginatorHeight,
          decoration: BoxDecoration(
            color: paginatorBackgroundColor,
            borderRadius: paginatorBorderRadius ?? BorderRadius.circular(8),
            border: paginatorBorder ?? Border.all(width: 1, color: const Color(0xffbdbdbd)),
          ),
          child: Center(
            child: Icon(
              isLeft ? Icons.keyboard_arrow_left_rounded : Icons.keyboard_arrow_right_rounded,
              color: paginatorTextColor ?? Colors.black,
            ),
          ),
        ),
      );

  Widget paginateContainer(int index) => Container(
        height: paginatorHeight,
        width: paginatorHeight - 5,
        margin: EdgeInsets.only(
          left: index == 0 ? paginatorHeight + 5 : (spaceBetweenPaginators ?? 2),
          right: index == totalPage - 1 ? paginatorHeight + 5 : (spaceBetweenPaginators ?? 2),
        ),
        decoration: BoxDecoration(
          color: currentPage == index + 1 ? paginatorSelectedBackgroundColor ?? const Color(0xff316ce2) : paginatorBackgroundColor ?? Colors.white,
          borderRadius: paginatorBorderRadius ?? BorderRadius.circular(8),
          border: currentPage == index + 1 ? paginatorSelectedBorder : paginatorBorder ?? Border.all(width: 1, color: const Color(0xffbdbdbd)),
        ),
        child: InkWell(
          borderRadius: paginatorBorderRadius ?? BorderRadius.circular(8),
          onTap: onNewPage != null
              ? () {
                  if (currentPage != index + 1) {
                    onNewPage!(index + 1);
                  }
                }
              : null,
          child: Center(
            child: Text(
              (index + 1).toString(),
              style: currentPage == index + 1
                  ? paginatorSelectedTextStyle?.copyWith(color: paginatorSelectedTextColor) ??
                      const TextStyle(color: Colors.white, fontWeight: FontWeight.w800)
                  : paginatorTextStyle?.copyWith(color: paginatorTextColor) ?? const TextStyle(color: Colors.black),
            ),
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    if (currentPage < 1 || totalPage < 2) {
      return const SizedBox();
    }

    _animateToSelectedPage();

    return SizedBox(
      height: paginatorHeight,
      child: Stack(
        alignment: Alignment.center,
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            controller: scrollController,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 2.5),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: totalPage,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) => paginateContainer(index),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.min,
            children: [
              arrowWidget(isLeft: true),
              const Spacer(),
              arrowWidget(isLeft: false),
            ],
          ),
        ],
      ),
    );
  }
}
