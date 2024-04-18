import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vc_product_widgets/components/bottom_navigation_bar/bottom_navbar_icon.dart';
import 'package:vc_product_widgets/components/bottom_navigation_bar/bottom_navigation_bar.dart';

class BottomNavBarExamples extends StatefulWidget {
  const BottomNavBarExamples({Key? key}) : super(key: key);

  @override
  State<BottomNavBarExamples> createState() => _BottomNavBarExamplesState();
}

class _BottomNavBarExamplesState extends State<BottomNavBarExamples> {
  TextEditingController textEditingController = TextEditingController();

  List<BottomSheetBarIcon> bottomNavigationItems = [
    BottomSheetBarIcon(
      icon: Icon(CupertinoIcons.home),
      color: Colors.white,
      menuName: "Home",
    ),
    BottomSheetBarIcon(
      icon: Icon(CupertinoIcons.bag),
      color: Colors.white,
      menuName: "Accounts",
    ),
    BottomSheetBarIcon(
      icon: Icon(CupertinoIcons.arrow_right_arrow_left_square),
      color: Colors.white,
      menuName: "Transfers",
    ),
    BottomSheetBarIcon(
      icon: Icon(CupertinoIcons.creditcard),
      color: Colors.white,
      menuName: "Cards",
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: () {  },child: const Icon(Icons.menu),),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomBarSheet(children: bottomNavigationItems,),
      appBar: AppBar(
          title: const Text(
        "Bottom Navigation Bar",
      )),
      body: SingleChildScrollView(child: Container()),
    );
  }
}
