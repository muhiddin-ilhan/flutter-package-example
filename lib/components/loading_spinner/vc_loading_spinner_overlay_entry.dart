import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

T? _ambiguate<T>(T? value) => value;

class VCLoadingSpinnerOverlayEntry extends OverlayEntry {

  VCLoadingSpinnerOverlayEntry({
    required WidgetBuilder builder,
  }) : super(builder: builder);

  @override
  void markNeedsBuild() {
    if (_ambiguate(SchedulerBinding.instance)!.schedulerPhase ==
        SchedulerPhase.persistentCallbacks) {
      _ambiguate(SchedulerBinding.instance)!.addPostFrameCallback((_) {
        super.markNeedsBuild();
      });
    } else {
      super.markNeedsBuild();
    }
  }
}