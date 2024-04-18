import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:vc_product_widgets/components/buttons/vc_button/vc_button.dart';
import 'package:vc_product_widgets/components/carousel/vc_carousel.dart';
import 'package:vc_product_widgets/components/information_container/vc_information_container/vc_information_container.dart';
import 'package:vc_product_widgets/components/information_container/vc_information_item/vc_information_item.dart';
import 'package:vc_product_widgets/components/inputs/input_type.dart';
import 'package:vc_product_widgets/components/map/vc_map.dart';
import 'package:vc_product_widgets/utils/color_constant.dart';
import 'package:vc_product_widgets/components/buttons/elevated_button/button_size.dart';
import 'package:vc_product_widgets/components/buttons/elevated_button/button_type.dart';
import 'package:vc_product_widgets/components/buttons/elevated_button/vc_product_elevated_button.dart';
import 'package:vc_product_widgets/components/text/vc_product_text.dart';
import 'package:vc_product_widgets/components/text/typography_type.dart';

import '../helper/carousel_slider/controller/carousel_controller.dart';
import '../helper/carousel_slider/option/carousel_options.dart';
import '../helper/smooth_page_indicator/effects/indicator_effect.dart';
import 'inputs/vc_masked_text_field.dart';
import 'inputs/vc_password_text_field.dart';
import 'inputs/vc_pin_input_field.dart';
import 'list/vc_list_view/vc_list_view.dart';

class VCProductComponents {
  static elevatedButton(
      {required VoidCallback onPressed,
      String? text,
      ButtonType? type,
      Widget? child,
      Color? backgroundColor,
      ButtonSize? size,
      double? fontSize,
      Size? fixedSize,
      final TypographyType? typographyType,
      Color? borderColor}) {
    assert((text != null && child == null) || (text == null && child != null),
        "Text and Child parameters cannot be used at the same time, at least one must be specified.");

    return VCProductElevatedButton(
      borderColor: borderColor,
      fixedSize: fixedSize,
      onPressed: onPressed,
      text: text,
      type: type,
      typogaphyType: typographyType,
      size: size,
      fontSize: fontSize,
      backgroundColor: backgroundColor ?? VCProductColors.instance.navyBlue,
      child: child,
    );
  }

  static Widget text(
      {TypographyType? typographyType,
      required String text,
      Color? textColor,
      TextAlign? textAlign = TextAlign.center,
      TextDecoration? decoration,
      double? fontSize,
      FontWeight? fontWeight,
      int? maxLines}) {
    return VCProductText(
      fontSize: fontSize,
      fontWeight: fontWeight,
      decoration: decoration,
      textAlign: textAlign,
      maxLines: maxLines,
      type: typographyType,
      text: text,
      textColor: textColor,
    );
  }

  static passwordTextField({
    bool? isSecure,
  }) {
    return VCPasswordTextField(
      isSecure: isSecure ?? true,
      label: "Password",
    );
  }

  static cardNumberTextField({
    String? title,
  }) {
    return VCMaskedTextField(
      label: title,
      maskedType: InputType.cardNumber,
    );
  }

  static ibanNumberTextField({
    String? title,
  }) {
    return VCMaskedTextField(
      label: title,
      maskedType: InputType.ibanNumber,
    );
  }

  static expirationDateTextField({
    String? title,
  }) {
    return VCMaskedTextField(
      label: title,
      maskedType: InputType.expirationDate,
    );
  }

  static cvvTextField({
    String? title,
  }) {
    return VCMaskedTextField(
      label: title,
      maskedType: InputType.cvv,
    );
  }

  static maskedTextField({
    String? title,
    String? mask,
  }) {
    return VCMaskedTextField(
      label: title,
      mask: mask,
    );
  }

  static pinTextField({int? pinLength, TextEditingController? pinController}) {
    return VCPinInputTextField(
      pinLength: pinLength ?? 6,
      pinController: pinController,
    );
  }

  static Widget listView<T>({
    GlobalKey? key,
    int currentPageNumber = 1,
    int? totalPageNumber,
    double? containerHeight,
    double? containerWidth,
    EdgeInsets? containerMargin,
    EdgeInsets? containerPadding,
    BoxDecoration? containerBoxDecoration,
    double? marginPaginatorTop,
    double? marginPaginatorBottom,
    Color? paginatorBackgroundColor = Colors.white,
    Color? paginatorSelectedBackgroundColor = const Color(0xff316ce2),
    Color? paginatorTextColor = Colors.black,
    Color? paginatorSelectedTextColor = Colors.white,
    BoxBorder? paginatorBorder,
    BoxBorder? paginatorSelectedBorder,
    BorderRadius? paginatorBorderRadius,
    double? spaceBetweenPaginators = 2,
    double? paginatorHeight = 45,
    TextStyle? paginatorTextStyle,
    TextStyle? paginatorSelectedTextStyle,
    String emptySourceMessage = "No data is available",
    VCPaginateType paginateType = VCPaginateType.none,
    Future<dynamic> Function(int index)? onNewPage,
    List<T>? dataList,
    bool? isLoading = false,
    required Widget Function(int index, T item) onItemBuilder,
    Widget Function(int)? onSeperatorBuilder,
    Function()? buttonOnClick,
    String? buttonText,
    bool isShowButton = false,
    Color? buttonBackgroundColor,
    BorderRadius? buttonBorderRadius,
    BorderSide? buttonBorderSide,
    Color? buttonDisabledBackgrondColor,
    Color? buttonDisabledTextColor,
    double? buttonHeight,
    Color? buttonTextColor,
    bool? isButtonDisabled,
    double? marginButtonBottom,
    double? marginButtonTop,
    bool shrinkWrap = false,
    ScrollPhysics? scrollPhysics,
  }) {
    return VCListView<T>(
      key: key,
      onItemBuilder: onItemBuilder,
      isLoading: isLoading,
      currentPageNumber: currentPageNumber,
      onNewPage: onNewPage,
      totalPageNumber: totalPageNumber,
      marginPaginatorTop: marginPaginatorTop,
      spaceBetweenPaginators: spaceBetweenPaginators,
      paginatorBorderRadius: paginatorBorderRadius,
      paginatorHeight: paginatorHeight,
      paginatorSelectedTextStyle: paginatorSelectedTextStyle,
      paginatorTextStyle: paginatorTextStyle,
      paginatorSelectedTextColor: paginatorSelectedTextColor,
      paginatorTextColor: paginatorTextColor,
      paginatorSelectedBorder: paginatorSelectedBorder,
      paginatorBorder: paginatorBorder,
      paginatorSelectedBackgroundColor: paginatorSelectedBackgroundColor,
      paginatorBackgroundColor: paginatorBackgroundColor,
      marginPaginatorBottom: marginPaginatorBottom,
      containerHeight: containerHeight,
      paginateType: paginateType,
      containerPadding: containerPadding,
      onSeperatorBuilder: onSeperatorBuilder,
      containerBoxDecoration: containerBoxDecoration,
      containerMargin: containerMargin,
      dataList: dataList,
      containerWidth: containerWidth,
      emptySourceMessage: emptySourceMessage,
      buttonOnClick: buttonOnClick,
      buttonText: buttonText,
      isShowButton: isShowButton,
      buttonBackgroundColor: buttonBackgroundColor,
      buttonBorderRadius: buttonBorderRadius,
      buttonBorderSide: buttonBorderSide,
      buttonDisabledBackgrondColor: buttonDisabledBackgrondColor,
      buttonDisabledTextColor: buttonDisabledTextColor,
      buttonHeight: buttonHeight,
      buttonTextColor: buttonTextColor,
      isButtonDisabled: isButtonDisabled,
      marginButtonBottom: marginButtonBottom,
      marginButtonTop: marginButtonTop,
      shrinkWrap: shrinkWrap,
      scrollPhysics: scrollPhysics,
    );
  }

  static Widget vcMap({
    GlobalKey? key,
    required Function(GoogleMapController controller) onMapCreated,
    Function(LatLng latLng)? onTapMap,
    Function(LatLng latLng)? onLongTapMap,
    CameraPosition? initialCameraPosition,
    MapType mapType = MapType.normal,
    List<Marker>? markers,
    bool myLocationButtonEnabled = false,
    bool myLocationEnabled = false,
    bool zoomControlsEnabled = true,
    double? height,
    double? width,
    EdgeInsets padding = EdgeInsets.zero,
    BorderRadius borderRadius = BorderRadius.zero,
  }) {
    return VCMap(
      onMapCreated: onMapCreated,
      onTapMap: onTapMap,
      onLongTapMap: onLongTapMap,
      borderRadius: borderRadius,
      padding: padding,
      width: width,
      height: height,
      zoomControlsEnabled: zoomControlsEnabled,
      myLocationEnabled: myLocationEnabled,
      myLocationButtonEnabled: myLocationButtonEnabled,
      key: key,
      initialCameraPosition: initialCameraPosition,
      mapType: mapType,
      markers: markers,
    );
  }

  static Widget vcCarousel<T>({
    required List<T> items,
    required Widget Function(T item) itemBuilder,
    Function(int pageIndex)? onPageChange,
    double? height,
    double aspectRatio = 16 / 9,
    double viewportFraction = 1,
    int initialPage = 0,
    bool enableInfiniteScroll = true,
    bool animateToClosest = true,
    bool reverse = false,
    bool autoPlay = false,
    Duration autoPlayInterval = const Duration(seconds: 4),
    Duration autoPlayAnimationDuration = const Duration(milliseconds: 800),
    Curve autoPlayCurve = Curves.fastOutSlowIn,
    bool enlargeCenterPage = false,
    bool pageSnapping = true,
    bool pauseAutoPlayOnTouch = true,
    bool pauseAutoPlayOnManualNavigate = true,
    bool pauseAutoPlayInFiniteScroll = false,
    CenterPageEnlargeStrategy enlargeStrategy = CenterPageEnlargeStrategy.scale,
    double enlargeFactor = 0.3,
    bool disableCenter = false,
    bool padEnds = true,
    bool disableGesture = false,
    CarouselController? carouselController,
    IndicatorEffect? indicatorEffect,
    EdgeInsets indicatorMargin = const EdgeInsets.all(8.0),
  }) {
    return VCCarousel<T>(
      itemBuilder: itemBuilder,
      items: items,
      viewportFraction: viewportFraction,
      autoPlay: autoPlay,
      aspectRatio: aspectRatio,
      height: height,
      carouselController: carouselController,
      disableGesture: disableGesture,
      padEnds: padEnds,
      animateToClosest: animateToClosest,
      autoPlayAnimationDuration: autoPlayAnimationDuration,
      autoPlayCurve: autoPlayCurve,
      autoPlayInterval: autoPlayInterval,
      disableCenter: disableCenter,
      enableInfiniteScroll: enableInfiniteScroll,
      enlargeCenterPage: enlargeCenterPage,
      enlargeFactor: enlargeFactor,
      enlargeStrategy: enlargeStrategy,
      indicatorEffect: indicatorEffect,
      indicatorMargin: indicatorMargin,
      initialPage: initialPage,
      onPageChange: onPageChange,
      pageSnapping: pageSnapping,
      pauseAutoPlayInFiniteScroll: pauseAutoPlayInFiniteScroll,
      pauseAutoPlayOnManualNavigate: pauseAutoPlayOnManualNavigate,
      pauseAutoPlayOnTouch: pauseAutoPlayOnTouch,
      reverse: reverse,
    );
  }

  static Widget vcButton({
    required Function() onTap,
    required Widget child,
    bool disabled = false,
    Color? backgroundColor,
    Color? disableBackgroundColor,
    Color? foregroundColor,
    Color? disabledForegroundColor,
    Color? highlightForegroundColor,
    Color? focusColor,
    Color? hoverColor,
    Color? highlightColor,
    Color? splashColor,
    double elevation = 0,
    bool clickElevationEnabled = false,
    BorderRadius borderRadius = const BorderRadius.all(Radius.circular(8)),
    BorderSide? borderSide,
    BorderSide? disableBorderSide,
    VCButtonSize buttonSize = VCButtonSize.medium,
    VCButtonType buttonType = VCButtonType.primary,
    double? width = double.infinity,
    double? height,
    EdgeInsets padding = EdgeInsets.zero,
    Widget? prefixWidget,
    Widget? suffixWidget,
  }) {
    return VCButton(
      onTap: onTap,
      backgroundColor: backgroundColor,
      borderRadius: borderRadius,
      borderSide: borderSide,
      buttonSize: buttonSize,
      buttonType: buttonType,
      clickElevationEnabled: clickElevationEnabled,
      disableBackgroundColor: disableBackgroundColor,
      disableBorderSide: disableBorderSide,
      disabled: disabled,
      disabledForegroundColor: disabledForegroundColor,
      elevation: elevation,
      focusColor: focusColor,
      foregroundColor: foregroundColor,
      height: height,
      highlightColor: highlightColor,
      highlightForegroundColor: highlightForegroundColor,
      hoverColor: hoverColor,
      padding: padding,
      prefixWidget: prefixWidget,
      splashColor: splashColor,
      suffixWidget: suffixWidget,
      width: width,
      child: child,
    );
  }

  static Widget informationContainer({
    required List<VCInformationItem> informationItemList,
    Widget seperatorWidget = const SizedBox.shrink(),
    String? headerText,
    TextStyle headerTextStyle = const TextStyle(),
    EdgeInsets headerTextPadding =
        const EdgeInsets.symmetric(vertical: 6, horizontal: 2),
    HeaderDisplayTypeEnumCustom headerDisplayTypeEnum =
        HeaderDisplayTypeEnumCustom.left,
    BoxDecoration containerDecoration = const BoxDecoration(),
    EdgeInsets containerPadding = EdgeInsets.zero,
    EdgeInsets containerMargin = EdgeInsets.zero,
  }) {
    return VCInformationContainer(
      informationItemList: informationItemList,
      containerDecoration: containerDecoration,
      containerMargin: containerMargin,
      containerPadding: containerPadding,
      headerDisplayTypeEnum: headerDisplayTypeEnum,
      headerText: headerText,
      headerTextPadding: headerTextPadding,
      headerTextStyle: headerTextStyle,
      seperatorWidget: seperatorWidget,
    );
  }
}
