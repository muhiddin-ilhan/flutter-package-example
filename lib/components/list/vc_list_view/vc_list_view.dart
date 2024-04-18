import 'package:flutter/material.dart';

import '../../paginator/vc_custom_paginator.dart';

enum VCPaginateType { infinity, normal, none }

class VCListView<T> extends StatefulWidget {
  // Initial page number and total page number at the beginning
  final int currentPageNumber;
  final int? totalPageNumber;

  // Container parameters that cover the ListView
  final double? containerHeight;
  final double? containerWidth;
  final EdgeInsets? containerMargin;
  final EdgeInsets? containerPadding;
  final BoxDecoration? containerBoxDecoration;

  // Paginator parameters
  final double? marginPaginatorTop;
  final double? marginPaginatorBottom;
  final Color? paginatorBackgroundColor;
  final Color? paginatorSelectedBackgroundColor;
  final Color? paginatorTextColor;
  final Color? paginatorSelectedTextColor;
  final BoxBorder? paginatorBorder;
  final BoxBorder? paginatorSelectedBorder;
  final BorderRadius? paginatorBorderRadius;
  final double? spaceBetweenPaginators;
  final double? paginatorHeight;
  final TextStyle? paginatorTextStyle;
  final TextStyle? paginatorSelectedTextStyle;

  // Action Button parameters
  final bool isShowButton;
  final double? marginButtonTop;
  final double? marginButtonBottom;
  final double? buttonHeight;
  final String? buttonText;
  final Color? buttonBackgroundColor;
  final Color? buttonTextColor;
  final BorderRadius? buttonBorderRadius;
  final BorderSide? buttonBorderSide;
  final Color? buttonDisabledBackgrondColor;
  final Color? buttonDisabledTextColor;
  final bool? isButtonDisabled;
  final Function()? buttonOnClick;

  // If there is no data, the widget to be displayed on the screen.
  final Widget? emptySourceWidget;

  // Message text to be displayed on the screen if there are no items.
  final String? emptySourceMessage;

  // There are 3 types of pagination methods: {infinity, normal, none}
  final VCPaginateType paginateType;

  final Future<dynamic> Function(int)? onNewPage;

  // If we don't paginate, we can manually provide data.
  final List<T>? dataList;

  final bool? isLoading;

  // We can set custom listItem and separator.
  final Widget Function(int index, T item) onItemBuilder;
  final Widget Function(int index)? onSeperatorBuilder;
  final bool shrinkWrap;
  final ScrollPhysics? scrollPhysics;

  final ScrollController? controller;

  const VCListView({
    super.key,
    this.currentPageNumber = 1,
    this.totalPageNumber,
    this.emptySourceMessage,
    this.emptySourceWidget,
    this.onNewPage,
    this.dataList,
    this.paginateType = VCPaginateType.none,
    required this.onItemBuilder,
    this.onSeperatorBuilder,
    this.containerHeight,
    this.containerWidth,
    this.containerMargin,
    this.containerPadding,
    this.containerBoxDecoration,
    this.marginPaginatorTop,
    this.marginPaginatorBottom,
    this.paginatorBackgroundColor = Colors.white,
    this.paginatorSelectedBackgroundColor = const Color(0xff316ce2),
    this.paginatorTextColor = Colors.black,
    this.paginatorSelectedTextColor = Colors.white,
    this.paginatorBorder,
    this.paginatorSelectedBorder,
    this.paginatorBorderRadius,
    this.spaceBetweenPaginators = 2,
    this.paginatorHeight = 45,
    this.paginatorTextStyle,
    this.paginatorSelectedTextStyle,
    this.isLoading = false,
    this.isShowButton = false,
    this.marginButtonTop,
    this.marginButtonBottom,
    this.buttonText,
    this.buttonOnClick,
    this.buttonHeight = 45,
    this.buttonBackgroundColor,
    this.buttonTextColor,
    this.buttonBorderRadius,
    this.buttonBorderSide,
    this.buttonDisabledBackgrondColor,
    this.buttonDisabledTextColor,
    this.isButtonDisabled = false,
    this.shrinkWrap = false,
    this.scrollPhysics,
    this.controller,
  })  : assert(
          currentPageNumber > 0,
          "initialPageNumber must be greater than 0.",
        ),
        assert(
          totalPageNumber == null || totalPageNumber >= currentPageNumber,
          "totalPageNumber must be greater than or equal to initialPageNumber.",
        ),
        assert(
          paginateType == VCPaginateType.none || totalPageNumber != null,
          "If paginateType is not VCPaginateType.none, totalPageNumber must be provided.",
        ),
        assert(
          paginateType == VCPaginateType.none || onNewPage != null,
          'If paginateType is not none, onNewPage must not be null.',
        ),
        assert(
          !(isShowButton && (buttonText == null || buttonOnClick == null)),
          'If isShowButton is true, buttonText and buttonOnClick must not be null.',
        );

  @override
  State<VCListView<T>> createState() => _VCListViewState<T>();
}

class _VCListViewState<T> extends State<VCListView<T>> {
  // Controller to control the scroll event of the ListView.
  late ScrollController _controller = ScrollController();

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? ScrollController();

    if (widget.paginateType == VCPaginateType.infinity) {
      // If infinity scroll is active, add a scroll listener to the ListView,
      // _handleScrollEvent function will be triggered each time the scroll changes.
      _controller.addListener(_handleScrollEvent);
    }
  }

  _handleScrollEvent() {
    // If the ListView is scrolled to the bottom, the if-else code below runs.
    if (_controller.position.pixels == _controller.position.maxScrollExtent) {
      // If the data fetching process is already being done, we don't fetch new data.
      if (widget.isLoading != true) {
        // If we have reached the last page, we do not fetch new data.
        if (widget.currentPageNumber < widget.totalPageNumber!) {
          int newPageNumber = widget.currentPageNumber + 1;
          widget.onNewPage!(newPageNumber);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.paginateType == VCPaginateType.none && !widget.isShowButton) {
      return Container(
        clipBehavior: Clip.hardEdge,
        padding: widget.containerPadding,
        margin: widget.containerMargin,
        height: widget.containerHeight,
        width: widget.containerWidth,
        decoration: widget.containerBoxDecoration ?? const BoxDecoration(),
        child: listView(),
      );
    }
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          flex: widget.containerHeight != null ? 0 : 1,
          child: Container(
            clipBehavior: Clip.hardEdge,
            padding: widget.containerPadding,
            margin: widget.containerMargin,
            height: widget.containerHeight,
            width: widget.containerWidth,
            decoration: widget.containerBoxDecoration ?? const BoxDecoration(),
            child: listView(),
          ),
        ),
        customPaginator(),
        if (widget.isShowButton) actionButton(),
      ],
    );
  }

  Widget actionButton() {
    return Container(
      padding: widget.containerPadding?.copyWith(top: 0),
      margin: widget.containerMargin?.copyWith(
        top: widget.marginButtonTop ?? 0,
        bottom: widget.marginButtonBottom,
      ),
      width: double.infinity,
      child: MaterialButton(
        color: widget.buttonBackgroundColor ?? const Color(0xff316ce2),
        disabledColor:
            widget.buttonDisabledBackgrondColor ?? const Color(0xaa316ce2),
        height: widget.buttonHeight,
        minWidth: widget.containerWidth,
        shape: RoundedRectangleBorder(
          borderRadius: widget.buttonBorderRadius ?? BorderRadius.circular(8),
          side: widget.buttonBorderSide ?? BorderSide.none,
        ),
        textColor: widget.buttonTextColor ?? Colors.white,
        disabledTextColor: widget.buttonDisabledTextColor ?? Colors.white,
        elevation: 0,
        onPressed: (widget.isButtonDisabled ?? false)
            ? null
            : () {
                if (widget.buttonOnClick != null) {
                  widget.buttonOnClick!();
                }
              },
        child: Text(widget.buttonText ?? ""),
      ),
    );
  }

  Widget listView() {
    if ((widget.paginateType != VCPaginateType.infinity) ||
        (widget.dataList ?? []).isEmpty) {
      if (widget.isLoading == true) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
    }
    List tempDataList = widget.dataList ?? [];
    if (tempDataList.isEmpty) {
      return emptySourceWidget();
    }

    int itemCount = widget.paginateType == VCPaginateType.infinity
        ? tempDataList.length + 1
        : tempDataList.length;
    return ListView.separated(
      controller: _controller,
      itemCount: itemCount,
      shrinkWrap: widget.shrinkWrap,
      physics: widget.scrollPhysics,
      itemBuilder: (c, i) {
        if (widget.paginateType == VCPaginateType.infinity) {
          bool isLastItem = i == tempDataList.length;
          if (!isLastItem) {
            return Card(
              margin: EdgeInsets.zero,
              color: Colors.transparent,
              elevation: 0,
              child: widget.onItemBuilder(
                i,
                tempDataList[i],
              ),
            );
          } else {
            if (widget.isLoading == true) {
              return loadingBarWidget();
            }
            if (widget.currentPageNumber < widget.totalPageNumber!) {
              return getNewItemsWidget();
            }
            return const SizedBox();
          }
        } else {
          return Card(
            margin: EdgeInsets.zero,
            color: Colors.transparent,
            elevation: 0,
            child: widget.onItemBuilder(
              i,
              tempDataList[i],
            ),
          );
        }
      },
      separatorBuilder: (c, i) => widget.onSeperatorBuilder != null
          ? widget.onSeperatorBuilder!(i)
          : const SizedBox.shrink(),
    );
  }

  Widget customPaginator() {
    if (widget.paginateType == VCPaginateType.normal) {
      return Container(
        padding: widget.containerPadding?.copyWith(top: 0),
        margin: widget.containerMargin?.copyWith(
          top: widget.marginPaginatorTop ?? 0,
          bottom: widget.marginPaginatorBottom ?? 0,
        ),
        width: widget.containerWidth,
        child: VCCustomPaginator(
          currentPage: widget.currentPageNumber,
          totalPage: widget.totalPageNumber!,
          onNewPage: (int page) {
            if (widget.isLoading == false) {
              widget.onNewPage!(page);
            }
          },
          paginatorBackgroundColor: widget.paginatorBackgroundColor,
          paginatorSelectedBackgroundColor:
              widget.paginatorSelectedBackgroundColor,
          paginatorBorder: widget.paginatorBorder,
          paginatorSelectedBorder: widget.paginatorSelectedBorder,
          paginatorTextColor: widget.paginatorTextColor,
          paginatorSelectedTextColor: widget.paginatorSelectedTextColor,
          paginatorTextStyle: widget.paginatorTextStyle,
          paginatorSelectedTextStyle: widget.paginatorSelectedTextStyle,
          paginatorHeight: widget.paginatorHeight ?? 45,
          paginatorBorderRadius: widget.paginatorBorderRadius,
          spaceBetweenPaginators: widget.spaceBetweenPaginators,
        ),
      );
    } else {
      return const SizedBox();
    }
  }

  Widget loadingBarWidget() => const Padding(
        padding: EdgeInsets.symmetric(vertical: 12.0),
        child: Center(
          child: CircularProgressIndicator(
            color: Color(0xff316ce2),
          ),
        ),
      );

  Widget emptySourceWidget() {
    if (widget.emptySourceWidget != null) {
      return widget.emptySourceWidget!;
    } else {
      return widget.emptySourceMessage != null
          ? Center(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  widget.emptySourceMessage!,
                  style: const TextStyle(fontSize: 16, color: Colors.black),
                ),
              ),
            )
          : const SizedBox.shrink();
    }
  }

  Widget getNewItemsWidget() => IconButton(
        onPressed: () {
          int newPageNumber = widget.currentPageNumber + 1;
          widget.onNewPage!(newPageNumber);
        },
        color: const Color(0xff316ce2),
        icon: const Icon(Icons.download),
      );
}
