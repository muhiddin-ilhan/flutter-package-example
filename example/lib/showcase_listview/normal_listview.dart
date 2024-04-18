import 'package:flutter/material.dart';
import 'package:vc_product_widgets/components/list/user_list_item/user_list_item.dart';
import 'package:vc_product_widgets/components/vc_product_components.dart';
import 'package:vc_product_widgets/utils/color_constant.dart';

import 'data/data.dart';

class NormalListView extends StatefulWidget {
  const NormalListView({super.key});

  @override
  State<NormalListView> createState() => _NormalListViewState();
}

class _NormalListViewState extends State<NormalListView> {
  final List<Map<String, dynamic>> _fullData = [];

  @override
  void initState() {
    super.initState();
    _fullData.addAll(fakeUserList);
  }

  _onDeleteItem(item) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Text("${item["name"]} ${item["surname"]} adlı kişiyi silmek istediğinize emin misiniz?"),
        title: const Text("Kişi Sil"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("Vazgeç"),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                _fullData.remove(item);
              });
              Navigator.pop(context);
            },
            child: const Text("Sil"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFeeeeee),
      appBar: AppBar(
        backgroundColor: VCProductColors.instance.navyBlue,
        foregroundColor: Colors.white,
      ),
      body: VCProductComponents.listView<Map<String, dynamic>>(
        containerMargin: const EdgeInsets.all(16),
        containerBoxDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
        ),
        dataList: _fullData,
        isShowButton: true,
        buttonText: "Done",
        buttonBackgroundColor: VCProductColors.instance.navyBlue,
        buttonOnClick: () {
          Navigator.pop(context);
        },
        onItemBuilder: (index, item) => UserListItem(
          item: item,
          onClickItem: (item) {
            debugPrint("$item tıklandı");
          },
          onDeleteItem: _onDeleteItem,
        ),
      ),
    );
  }
}
