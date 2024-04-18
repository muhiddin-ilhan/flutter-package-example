import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

T? _ambiguate<T>(T? value) => value;

class VCLoadingSpinnerContainer extends StatefulWidget {
  final Widget? indicator;
  final String? status;

  const VCLoadingSpinnerContainer({
    Key? key,
    this.indicator,
    this.status,
  }) : super(key: key);

  @override
  VCLoadingSpinnerContainerState createState() =>
      VCLoadingSpinnerContainerState();
}

class VCLoadingSpinnerContainerState extends State<VCLoadingSpinnerContainer>
    with SingleTickerProviderStateMixin {
  String? _status;
  late AlignmentGeometry _alignment;

  bool get isPersistentCallbacks =>
      _ambiguate(SchedulerBinding.instance)!.schedulerPhase ==
      SchedulerPhase.persistentCallbacks;

  @override
  void initState() {
    super.initState();
    if (!mounted) return;
    _status = widget.status;
    _alignment = AlignmentDirectional.center;
  }


  void updateStatus(String status) {
    if (_status == status) return;
    setState(() {
      _status = status;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: _alignment,
      children: <Widget>[
        Opacity(
          opacity: 0.4,
          child: IgnorePointer(
            ignoring: false, //Todo check if not correct
            child: Container(
              width: double.infinity,
              height: double.infinity,
              color: Colors.white,
            ),
          ),
        ),
        _Indicator(
          status: _status,
          indicator: widget.indicator,
        ),
      ],
    );
  }
}

class _Indicator extends StatelessWidget {
  final Widget? indicator;
  final String? status;

  const _Indicator({
    required this.indicator,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.zero,
      child: indicator,
    );
  }
}
