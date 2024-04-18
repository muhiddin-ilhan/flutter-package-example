import 'package:flutter/material.dart';

enum TypographyType {
  bodyLight14(fontSize: 14, fontWeight: FontWeight.w300),
  bodyRegular14(fontSize: 14, fontWeight: FontWeight.w400),
  bodyMedium14(fontSize: 14, fontWeight: FontWeight.w500),
  bodySemiBold14(fontSize: 14, fontWeight: FontWeight.w600),
  bodyBold14(fontSize: 14, fontWeight: FontWeight.w700),
  bodyBlack14(fontSize: 14, fontWeight: FontWeight.w900),

  bodyLight16(fontSize: 16, fontWeight: FontWeight.w300),
  bodyRegular16(fontSize: 16, fontWeight: FontWeight.w400),
  bodyMedium16(fontSize: 16, fontWeight: FontWeight.w500),
  bodySemiBold16(fontSize: 16, fontWeight: FontWeight.w600),
  bodyBold16(fontSize: 16, fontWeight: FontWeight.w700),
  bodyBlack16(fontSize: 16, fontWeight: FontWeight.w900),

  bodyBlackBold22(fontSize: 22, fontWeight: FontWeight.w700),

  label(fontSize: 15, fontWeight: FontWeight.w400),  
  label500(fontSize: 15, fontWeight: FontWeight.w500),
  placeholder(fontSize: 15, fontWeight: FontWeight.w600),
  placeholderAmount(fontSize: 15, fontWeight: FontWeight.w700),
  placeholderAmountLarge(fontSize: 32, fontWeight: FontWeight.w700),
  smallText(fontSize: 12, fontWeight: FontWeight.w400),
  validation(fontSize: 12, fontWeight: FontWeight.w400),

  btnLarge(fontSize: 18, fontWeight: FontWeight.w600),
  btnMedium(fontSize: 16, fontWeight: FontWeight.w600),
  btnSmall(fontSize: 13, fontWeight: FontWeight.w500),
  btnSmall400w(fontSize: 13, fontWeight: FontWeight.w400),
  btnSmall700w(fontSize: 13, fontWeight: FontWeight.w700),
  btnTab(fontSize: 12, fontWeight: FontWeight.w600),
  btnTab500w(fontSize: 12, fontWeight: FontWeight.w500),

  hyperlinkXLarge(fontSize: 14, fontWeight: FontWeight.w600),
  hyperlinkSmall(fontSize: 10, fontWeight: FontWeight.w700),

  allCapsSmall(fontSize: 8, fontWeight: FontWeight.w700, allCaps: true),
  allCapsMedium(fontSize: 10, fontWeight: FontWeight.w500, allCaps: true),
  allCapsLarge(fontSize: 12, fontWeight: FontWeight.w500, allCaps: true),
  allCapsXLarge(fontSize: 14, fontWeight: FontWeight.w500, allCaps: true);

  final double? fontSize;
  final FontWeight? fontWeight;
  final bool? allCaps;

  const TypographyType({this.fontSize, this.fontWeight, this.allCaps});
}