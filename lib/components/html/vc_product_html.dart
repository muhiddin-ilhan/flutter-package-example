import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class VCProductHtml extends StatefulWidget {
  /// The label text of the dropdown
  final String text;
  final TextAlign? textAlign;

  const VCProductHtml({
    super.key,
    required this.text,
    this.textAlign,
  });

  @override
  VCProductHtmlState createState() => VCProductHtmlState();
}

class VCProductHtmlState extends State<VCProductHtml> {
  @override
  Widget build(BuildContext context) {
    RenderObject.debugCheckingIntrinsics = true;
    return Html(
      style: {
        'html': Style(textAlign: widget.textAlign ?? TextAlign.center),
      },
      data: widget.text,
    );
  }
}
