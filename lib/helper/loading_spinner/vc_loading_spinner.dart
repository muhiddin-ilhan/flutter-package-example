import 'dart:async';

import 'package:flutter/material.dart';

import '../../components/loading_spinner/vc_loading_double_ring.dart';
import '../../components/loading_spinner/vc_loading_spinner_body.dart';
import '../../components/loading_spinner/vc_loading_spinner_container.dart';
import '../../components/loading_spinner/vc_loading_spinner_overlay_entry.dart';
import '../../utils/color_constant.dart';

/// loading status
enum VCLoadingSpinnerStatus {
  show,
  dismiss,
}

typedef VCLoadingSpinnerStatusCallback = void Function(
    VCLoadingSpinnerStatus status);

class VCLoadingSpinner {
  /// size of indicator, default 40.0.
  late double indicatorSize;

  /// width of indicator, default 4.0,
  late double lineWidth;

  /// animation duration of indicator, default 200ms.
  late Duration animationDuration;

  Widget? _w;

  VCLoadingSpinnerOverlayEntry? overlayEntry;
  GlobalKey<VCLoadingSpinnerContainerState>? _key;

  Widget? get w => _w;
  GlobalKey<VCLoadingSpinnerContainerState>? get key => _key;

  final List<VCLoadingSpinnerStatusCallback> _statusCallbacks =
      <VCLoadingSpinnerStatusCallback>[];

  factory VCLoadingSpinner() => _instance;
  static final VCLoadingSpinner _instance = VCLoadingSpinner._internal();

  VCLoadingSpinner._internal() {
    /// set deafult value
    indicatorSize = 40.0;
    lineWidth = 4.0;
    animationDuration = const Duration(milliseconds: 200);
  }

  static VCLoadingSpinner get instance => _instance;
  static bool get isShow => _instance.w != null;

  static TransitionBuilder init({
    TransitionBuilder? builder,
  }) {
    return (BuildContext context, Widget? child) {
      if (builder != null) {
        return builder(context, VCLoadingSpinnerBody(child: child));
      } else {
        return VCLoadingSpinnerBody(child: child);
      }
    };
  }

  /// show spinner
  static Widget get({
    String? status,
  }) {
    Widget indicator = VCLoadingDoubleRing(
      color1: VCProductColors.instance.loadingIndicatorColor1,
      color2: VCProductColors.instance.loadingIndicatorColor2,
    );
    return indicator;
  }

  /// show spinner
  static Future<void> show({
    String? status,
  }) {
    Widget indicator = VCLoadingDoubleRing(
      color1: VCProductColors.instance.loadingIndicatorColor1,
      color2: VCProductColors.instance.loadingIndicatorColor2,
    );
    return _instance._show(
      status: status,
      w: indicator,
    );
  }

  /// dismiss loading
  static Future<void> dismiss() {
    return _instance._dismiss();
  }

  /// add loading status callback
  static void addStatusCallback(VCLoadingSpinnerStatusCallback callback) {
    if (!_instance._statusCallbacks.contains(callback)) {
      _instance._statusCallbacks.add(callback);
    }
  }

  /// remove single loading status callback
  static void removeCallback(VCLoadingSpinnerStatusCallback callback) {
    if (_instance._statusCallbacks.contains(callback)) {
      _instance._statusCallbacks.remove(callback);
    }
  }

  /// remove all loading status callback
  static void removeAllCallbacks() {
    _instance._statusCallbacks.clear();
  }

  /// show spinner
  Future<void> _show({
    Widget? w,
    String? status,
  }) async {
    if (_key != null) await dismiss();

    _key = GlobalKey<VCLoadingSpinnerContainerState>();
    _w = VCLoadingSpinnerContainer(
      key: _key,
      status: status,
      indicator: w,
    );
    _markNeedsBuild();
  }

  Future<void> _dismiss() async {
    _reset();
  }

  void _reset() {
    _w = null;
    _key = null;
    _markNeedsBuild();
    _callback(VCLoadingSpinnerStatus.dismiss);
  }

  void _callback(VCLoadingSpinnerStatus status) {
    for (final VCLoadingSpinnerStatusCallback callback in _statusCallbacks) {
      callback(status);
    }
  }

  void _markNeedsBuild() {
    overlayEntry?.markNeedsBuild();
  }
}
