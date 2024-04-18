import 'package:flutter/material.dart';

class BaseComponent extends StatefulWidget {
  final String? id;
  final bool showError;

  final bool checkOthers;

  final String? id1;
  final bool showError1;

  final bool willValidate;

  const BaseComponent({
    super.key,
    this.id,
    this.id1,
    this.showError = true,
    this.showError1 = true,
    this.checkOthers = false,
    this.willValidate = true,
  });

  @override
  State<BaseComponent> createState() => BaseComponentState();
}

class BaseComponentState extends State<BaseComponent> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
