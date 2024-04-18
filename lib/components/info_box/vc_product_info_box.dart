import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:vc_product_widgets/utils/color_constant.dart';
import 'package:vc_product_widgets/vc_product_widgets.dart';

enum InfoBoxType {
  html,
  string;
}

class VCProductInfoBox extends StatefulWidget {
  final String? infoTitle;
  final String? infoText;
  final String? infoSubTitle;
  final Widget? icon;
  final EdgeInsets? padding;
  final TypographyType? infoTextType;
  final InfoBoxType? infoBoxType;
  final Widget? infoWidget;

  const VCProductInfoBox(
      {super.key,
      this.infoTitle,
      this.infoText,
      this.icon,
      this.padding,
      this.infoTextType,
      this.infoSubTitle,
      this.infoWidget,
      this.infoBoxType = InfoBoxType.string});

  @override
  State<VCProductInfoBox> createState() => _VCProductInfoBoxState();
}

class _VCProductInfoBoxState extends State<VCProductInfoBox> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: widget.padding ?? const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              widget.icon ??
                  Icon(Icons.info,
                      color: VCProductColors.instance.popupInfoIconColor),
              context.emptySizedWidthBoxLow,
              widget.infoWidget ?? (widget.infoTitle != null
                  ? Expanded(
                      child: VCProductText(
                        textAlign: TextAlign.start,
                        text: widget.infoTitle ?? '',
                        type: TypographyType.bodyBold14,
                      ),
                    )
                  : Expanded(
                      child: (widget.infoBoxType == InfoBoxType.string)
                          ? VCProductText(
                              text: widget.infoText ?? "",
                              type: widget.infoTextType ??
                                  TypographyType.bodyRegular14,
                              textAlign: TextAlign.start,
                            )
                          : Html(
                              data: """
                              <style>
                                ul {
                                  margin-left: 0;
                                  padding-left: 0;
                                }
                                li {
                                  margin-left: 0;
                                  padding-left: 0;
                                }
                              </style>
                              ${widget.infoText}
                                """,
                            ),
                    )),
            ],
          ),
          Visibility(
              visible: widget.infoTitle != null && widget.infoText != null,
              child: context.emptySizedHeightBoxLow),
          if(widget.infoSubTitle != null)
           ...[ 
            Padding(
              padding: context.horizontalPaddingLow,
              child: VCProductText(
                text: widget.infoSubTitle ?? "",
                type: TypographyType.bodySemiBold14,
                textAlign: TextAlign.start,
              ),
            )],
          Visibility(
            visible: widget.infoTitle != null && widget.infoText != null,
            child: Padding(
              padding: context.horizontalPaddingLow,
              child: (widget.infoBoxType == InfoBoxType.string)
                  ? VCProductText(
                      text: widget.infoText ?? "",
                      type: TypographyType.bodyRegular14,
                      textAlign: TextAlign.start,
                    )
                  : Html(
                      data: """
                              <style>
                                ul {
                                  margin-left: 0;
                                  padding-left: 0;
                                }
                                li {
                                  margin-left: 0;
                                  padding-left: 0;
                                }
                              </style>
                              ${widget.infoText}
                                """,
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
