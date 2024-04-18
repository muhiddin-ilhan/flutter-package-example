import 'package:flutter/material.dart';
import 'package:vc_product_widgets/components/loading_spinner/vc_loading_spinner_overlay_entry.dart';

import '../../helper/loading_spinner/vc_loading_spinner.dart';

class VCLoadingSpinnerBody extends StatefulWidget {
  final Widget? child;

  const VCLoadingSpinnerBody({
    Key? key,
    required this.child,
  })  : assert(child != null),
        super(key: key);

  @override
  VCLoadingSpinnerBodyState createState() => VCLoadingSpinnerBodyState();
}

class VCLoadingSpinnerBodyState extends State<VCLoadingSpinnerBody> {
  late VCLoadingSpinnerOverlayEntry _overlayEntry;

  @override
  void initState() {
    super.initState();
    _overlayEntry = VCLoadingSpinnerOverlayEntry(
      builder: (BuildContext context) => VCLoadingSpinner.instance.w ?? Container(),
    );
    VCLoadingSpinner.instance.overlayEntry = _overlayEntry;
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Overlay(
        initialEntries: [
          VCLoadingSpinnerOverlayEntry(
            builder: (BuildContext context) {
              if (widget.child != null) {
                return widget.child!;
              } else {
                return Container();
              }
            },
          ),
          _overlayEntry,
        ],
      ),
    );
  }
}