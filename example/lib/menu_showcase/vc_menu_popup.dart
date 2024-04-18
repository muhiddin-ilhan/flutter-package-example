import 'package:example/data/dummy_data.dart';
import 'package:flutter/material.dart';
import 'package:vc_product_widgets/components/vc_product_components.dart';
import 'package:vc_product_widgets/vc_product_widgets.dart';

class VCMenuPopup extends StatefulWidget {
  const VCMenuPopup({super.key});

  @override
  State<VCMenuPopup> createState() => _VCMenuPopupState();
}

class _VCMenuPopupState extends State<VCMenuPopup> {
  List _displayedItems = [];
  List _staticItems = [];
  List _childItems = [];
  bool _isChildItemShow = false;
  String _appBarTitle = "Menu";

  @override
  void initState() {
    super.initState();
    _displayedItems = DummyData.menuItems();
    _staticItems = DummyData.menuItemsStatic();
    _childItems = DummyData.menuChildItems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEEEEEE),
      appBar: appBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          children: !_isChildItemShow
              ? [
                  menuBasicItemList(_displayedItems),
                  const SizedBox(height: 16),
                  menuBasicItemList(_staticItems),
                ]
              : [
                  menuItemList(_childItems),
                ],
        ),
      ),
    );
  }

  Widget menuItemList(List items) {
    return VCProductComponents.listView(
      shrinkWrap: true,
      dataList: items,
      onSeperatorBuilder: (index) => const SizedBox(height: 16),
      onItemBuilder: (index, item) => MenuItemWithDescription(
        prefix: Icon(item["icon"]),
        title: item["title"],
        description: item["description"],
        onClick: () {},
      ),
    );
  }

  Widget menuBasicItemList(List items) {
    return VCProductComponents.listView(
      shrinkWrap: true,
      containerBoxDecoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      containerPadding: const EdgeInsets.symmetric(vertical: 8),
      dataList: items,
      onItemBuilder: (index, item) => MenuItemBasic(
        prefix: Icon(item["icon"]),
        title: item["title"],
        onClick: () {
          List activeTitles = ["Settings", "Support", "Help & Legal"];
          if (!activeTitles.contains(item["title"])) {
            _isChildItemShow = true;
            _appBarTitle = item["title"];
            setState(() {});
          }
        },
      ),
    );
  }

  AppBar appBar() {
    return AppBar(
      backgroundColor: const Color(0xFFEEEEEE),
      title: Text(_appBarTitle),
      elevation: 0,
      scrolledUnderElevation: 0,
      automaticallyImplyLeading: false,
      leading: _isChildItemShow
          ? IconButton(
              onPressed: () {
                _isChildItemShow = false;
                _appBarTitle = "Menu";
                setState(() {});
              },
              icon: const Icon(Icons.arrow_back_ios_new_rounded),
            )
          : null,
      actions: [
        IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.close),
        ),
      ],
    );
  }
}
