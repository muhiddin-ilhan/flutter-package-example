import 'package:example/showcase/showcase_view.dart';
import 'package:flutter/material.dart';
import 'package:vc_product_widgets/helper/loading_spinner/vc_loading_spinner.dart';
import 'package:vc_product_widgets/helper/local_storage/local_storage_helper.dart';

void main() {

  LocalStorageHelper.instance.initHive();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFC9D9DD)),
        useMaterial3: true,
      ),
      home: const ShowcaseView(title: 'Showcase'),
      builder: VCLoadingSpinner.init(),
    );
  }
}