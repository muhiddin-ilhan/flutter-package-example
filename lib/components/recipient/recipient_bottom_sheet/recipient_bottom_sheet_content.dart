import 'package:flutter/material.dart';
import 'package:vc_product_widgets/utils/color_constant.dart';
import 'package:vc_product_widgets/vc_product_widgets.dart';

// The `RecipientBottomSheetContent` widget is a StatefulWidget designed to be used
// as the content of a draggable bottom sheet. It contains various customization
// options for the appearance and behavior of the sheet.
class RecipientBottomSheetContent<T> extends StatefulWidget {
  // The title of the page displayed at the top of the bottom sheet.
  final String pageTitle;

  // The info section visibility
  final bool infoVisibility;

  // The title of the info displayed at the top of the info section.
  final String? infoTitle;

  // The text of the info section
  final String? infoText;

  // A callback function triggered when the search bar text changes.
  final Function(String? searchText)? onChangeSearchBar;

  // A function responsible for building each item in the list.
  final Widget Function(int index, T item) onItemBuilder;

  // A callback function triggered when the bottom sheet is closed.
  final Function()? onClose;

  // The list of items to be displayed in the bottom sheet.
  final List<T> items;

  // Padding for the entire content of the bottom sheet.
  final EdgeInsets? padding;

  // Decoration for the container wrapping the list of items.
  final BoxDecoration? listContainerBoxDecoration;

  // A function responsible for building the separator between list items.
  final Widget Function(int index)? onSeperatorBuilder;

  // Constructor for the `RecipientBottomSheetContent` widget.
  const RecipientBottomSheetContent({
    Key? key,
    required this.pageTitle,
    this.onChangeSearchBar,
    required this.onItemBuilder,
    required this.items,
    this.onClose,
    this.padding,
    this.listContainerBoxDecoration,
    this.onSeperatorBuilder,
    this.infoVisibility = false,
    this.infoText,
    this.infoTitle,
  }) : super(key: key);

  @override
  State<RecipientBottomSheetContent<T>> createState() =>
      _RecipientBottomSheetContentState<T>();
}

// The state class for the `RecipientBottomSheetContent` widget.
class _RecipientBottomSheetContentState<T>
    extends State<RecipientBottomSheetContent<T>> {
  // Dispose method to handle any necessary cleanup when the widget is disposed.
  @override
  void dispose() {
    super.dispose();
    if (widget.onClose != null) {
      widget.onClose!();
    }
  }

  // Build method to define the UI structure of the bottom sheet.
  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      maxChildSize: 1,
      minChildSize: 0.6,
      initialChildSize: 0.6,
      expand: false,
      builder: (BuildContext context, ScrollController scrollController) =>
          Padding(
        padding: widget.padding ?? context.paddingNormal.copyWith(bottom: 0),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: context.normalValue),
              child: titleWidget(),
            ),
            if (widget.infoVisibility) ...[
              infoBox,
              context.emptySizedHeightBoxNormal,
            ],
            if (widget.onChangeSearchBar != null)
              VCBaseTextField(
                label: "Search",
                suffixIcon: const Icon(Icons.search),
                onChanged: (text) {
                  widget.onChangeSearchBar!(text);
                },
              ),
            if (widget.onChangeSearchBar != null)
              context.emptySizedHeightBoxNormal,
            Expanded(
              child: SingleChildScrollView(
                controller: scrollController,
                child: VCListView<T>(
                  shrinkWrap: true,
                  containerBoxDecoration: widget.listContainerBoxDecoration ??
                      BoxDecoration(
                        color: VCProductColors.instance.white,
                        borderRadius: context.lowBorderRadius,
                      ),
                  dataList: widget.items,
                  onSeperatorBuilder: widget.onSeperatorBuilder ??
                      (index) => Divider(
                            height: context.semiLowValue,
                            endIndent: context.normalValue,
                            indent: context.normalValue,
                            color: VCProductColors.instance.black
                                .withOpacity(0.07),
                          ),
                  onItemBuilder: widget.onItemBuilder,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget to display the title at the top of the bottom sheet.
  SizedBox titleWidget() {
    return SizedBox(
      width: double.infinity,
      child: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            child: InkWell(
              child: const VCProductText(
                text: "Close",
                type: TypographyType.smallText,
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ),
          Center(
            child: VCProductText(
              text: widget.pageTitle,
              type: TypographyType.bodyBold16,
              maxLines: 1,
            ),
          )
        ],
      ),
    );
  }

  Container get infoBox => Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Icon(Icons.info,
                    color: VCProductColors.instance.popupInfoIconColor),
                VCProductText(
                  text: widget.infoTitle ?? '',
                  type: TypographyType.bodyBold14,
                ),
              ],
            ),
            context.emptySizedHeightBoxLow,
            VCProductText(
              text: widget.infoText ?? "",
              type: TypographyType.bodyRegular14,
              textAlign: TextAlign.start,
            ),
          ],
        ),
      );
}
