import 'package:flutter/material.dart';
import 'package:vc_product_network/vc_product_network.dart';
import 'package:vc_product_widgets/components/chat/chat_bot.dart';
import 'package:vc_product_widgets/components/vc_product_components.dart';
import 'package:vc_product_widgets/vc_product_widgets.dart';

import '../../utils/vc_icons.dart';

class BottomMenuSheet extends StatefulWidget {
  final List<MenuItem?>? childMenuItems;
  final List<MenuItem?>? additionalMenuItems;
  final bool? hasDescription;
  final bool isPreLogin;
  const BottomMenuSheet({super.key, required this.childMenuItems,this.additionalMenuItems,this.hasDescription =false,this.isPreLogin =false});

  @override
  State<BottomMenuSheet> createState() => _BottomMenuSheetState();
}

class _BottomMenuSheetState extends State<BottomMenuSheet> {
  final String defaultMenuTitle = "Menu";
  String menuTitle = "Menu";

  int currentPage = 0;
  List<Widget> pages = [];


  @override
  void initState() {
    super.initState();
    pages.add(buildPage(widget.childMenuItems ?? [], context, hasDescription: widget.hasDescription??false));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEEEEEE),
      appBar: appBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: pages[currentPage],
      ),
    );
  }

  Widget buildPage(List<MenuItem?> childMenuItems, BuildContext context,
      {bool hasDescription = false}){
    return Column(
      children: [
        !hasDescription ?
          menuBasicItemList(childMenuItems, context):
          menuItemList(childMenuItems, context),
        if(widget.isPreLogin!=true && currentPage == 0 && widget.additionalMenuItems?.isNotEmpty == true)...[
          const SizedBox(height: 16),
          menuBasicItemList(widget.additionalMenuItems ?? [], context)
        ],
        const SizedBox(height: 16),
      ]
      ,
    );
  }

  Widget menuItemList(List<MenuItem?> childMenuItems, BuildContext context) {
    return VCProductComponents.listView(
      shrinkWrap: true,
      dataList: childMenuItems,
      onSeperatorBuilder: (index) => const SizedBox(height: 16),
      onItemBuilder: (index, item) => MenuItemWithDescription(
        prefix: VCIcons.instance.getIcon(item?.cssClass ?? "icon-isys-menu-dots-primary"),
        title:item?.title ?? "",
        description: item?.description ?? "",
        onClick: () {
          menuItemOnClick(item!, context);
        },
      ),
    );
  }

  Widget menuBasicItemList(List<MenuItem?> childMenuItems, BuildContext context) {
    return VCProductComponents.listView<MenuItem?>(
      shrinkWrap: true,
      containerBoxDecoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      containerPadding: const EdgeInsets.symmetric(vertical: 8),
      dataList: childMenuItems,
      onItemBuilder: (index, item) => MenuItemBasic(
        prefix: VCIcons.instance.getIcon(item?.cssClass ?? "icon-isys-menu-dots-primary"),
        title: item?.title ?? "",
        onClick: () {
          menuItemOnClick(item!, context);
        },
      ),
    );
  }

  menuItemOnClick(MenuItem item, BuildContext context) async {
    if(item.childMenuItems?.isNotEmpty == true){
      currentPage+=1;
      menuTitle = item.title ?? defaultMenuTitle;
      pages.add(buildPage(item.childMenuItems!, context, hasDescription: true));
      setState(() {});
    }else if(item.title?.toLowerCase() == "Chat".toLowerCase() && (item.uRL ?? "").isEmpty){
      try{
        await showDialog(context: context, builder: 
        (context) => ChatBotComponent());
      }
      catch(e,s){
        debugPrint("ERROR->  $e STACKTRACE->  $s");
      }
    }else{
      debugPrint(item.uRL);
      Navigator.pop(context);
      await AppTransactioner.instance.navigateToTransaction(item.uRL);
    } 
  }


  AppBar appBar() {
    return AppBar(
      backgroundColor: const Color(0xFFEEEEEE),
      title: Text(currentPage == 0? defaultMenuTitle: menuTitle),
      elevation: 0,
      scrolledUnderElevation: 0,
      automaticallyImplyLeading: false,
      leading: currentPage != 0
          ? IconButton(
        onPressed: () {
          currentPage-=1;
          pages.removeLast();
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