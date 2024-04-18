import 'package:example/showcase/showcase_view_content.dart';
import 'package:flutter/material.dart';

class ShowcaseView extends StatefulWidget {
  final String title;

  const ShowcaseView({super.key, required this.title});


  @override
  State<ShowcaseView> createState() => _ShowcaseViewState();
}

class _ShowcaseViewState extends State<ShowcaseView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: const ShowcaseViewContent(),
        ),
      )
    );
  }
}
