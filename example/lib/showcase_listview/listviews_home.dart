import 'package:example/showcase_listview/paginator_listview.dart';
import 'package:example/showcase_listview/single_selectable_listview.dart';
import 'package:flutter/material.dart';
import 'package:vc_product_widgets/components/vc_product_components.dart';
import 'package:vc_product_widgets/utils/color_constant.dart';
import 'package:vc_product_widgets/vc_product_widgets.dart';

import 'infinity_scroll_listview.dart';
import 'multi_selectable_listview.dart';
import 'normal_listview.dart';

class ListViewHome extends StatefulWidget {
  const ListViewHome({super.key});

  @override
  State<ListViewHome> createState() => _ListViewHomeState();
}

class _ListViewHomeState extends State<ListViewHome> {
  List menuNames = [
    "List (Deletable)",
    "Infinity Scroll List",
    "Paginator List",
    "Single Selectable List",
    "Multi Selectable List",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: VCProductColors.instance.navyBlue,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: VCProductComponents.listView(
                containerMargin: const EdgeInsets.all(16),
                dataList: menuNames,
                onItemBuilder: (index, item) => _button(
                  onPressed: () {
                    switch (item) {
                      case "List (Deletable)":
                        return _goPage(const NormalListView());
                      case "Infinity Scroll List":
                        return _goPage(const InfinityScrollListView());
                      case "Paginator List":
                        return _goPage(const PaginatorListView());
                      case "Single Selectable List":
                        return _goPage(const SingleSelectableListView());
                      case "Multi Selectable List":
                        return _goPage(const MultiSelectableListView());
                    }
                  },
                  text: menuNames[index],
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 24),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.warning_amber_sharp,
                    color: Colors.black54,
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      "All lists, including this menu, were created with the [VCListView] component.",
                      style: TextStyle(
                        color: Colors.black87,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _button({required Function() onPressed, required String text}) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          height: 45,
          width: context.screenWidth75,
          child: VCProductComponents.elevatedButton(
            onPressed: () {
              onPressed();
            },
            text: text,
          ),
        ),
      );

  _goPage(Widget page) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => page));
  }
}
