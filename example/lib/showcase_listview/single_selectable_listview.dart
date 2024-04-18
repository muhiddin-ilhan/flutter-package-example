import 'package:flutter/material.dart';
import 'package:vc_product_widgets/components/list/selectable_user_list_item/selectable_user_list_item.dart';
import 'package:vc_product_widgets/components/list/vc_list_view/vc_list_view.dart';
import 'package:vc_product_widgets/components/vc_product_components.dart';
import 'package:vc_product_widgets/utils/color_constant.dart';

import 'data/data.dart';

class SingleSelectableListView extends StatefulWidget {
  const SingleSelectableListView({super.key});

  @override
  State<SingleSelectableListView> createState() => _SingleSelectableListViewState();
}

class _SingleSelectableListViewState extends State<SingleSelectableListView> {
  final List<Map<String, dynamic>> _fullData = [];
  Map? _selectedItem;

  @override
  void initState() {
    super.initState();
    _fullData.addAll(fakeUserList);
  }

  _onItemClick(item) {
    if (_selectedItem == item) {
      _selectedItem = null;
    } else {
      _selectedItem = item;
    }
    setState(() {});
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
      body: VCProductComponents.listView(
        containerMargin: const EdgeInsets.all(16),
        containerBoxDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
        ),
        paginateType: VCPaginateType.none,
        dataList: _fullData,
        isShowButton: true,
        buttonText: "Done",
        buttonBackgroundColor: VCProductColors.instance.navyBlue,
        buttonOnClick: () {
          Navigator.pop(context);
        },
        onItemBuilder: (index, item) => SelectableUserListItem(
          item: item,
          selected: _selectedItem == item,
          onClickItem: _onItemClick,
          onDeleteItem: (item) {
            _onDeleteItem(item);
          },
        ),
      ),
    );
  }
}
