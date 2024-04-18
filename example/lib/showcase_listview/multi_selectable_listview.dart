import 'package:flutter/material.dart';
import 'package:vc_product_widgets/components/list/selectable_user_list_item/selectable_user_list_item.dart';
import 'package:vc_product_widgets/components/list/vc_list_view/vc_list_view.dart';
import 'package:vc_product_widgets/components/vc_product_components.dart';
import 'package:vc_product_widgets/utils/color_constant.dart';

import 'data/data.dart';

class MultiSelectableListView extends StatefulWidget {
  const MultiSelectableListView({super.key});

  @override
  State<MultiSelectableListView> createState() => _MultiSelectableListViewState();
}

class _MultiSelectableListViewState extends State<MultiSelectableListView> {
  final List<Map<String, dynamic>> _fullData = [];
  final List<Map> _selectedItem = [];

  @override
  void initState() {
    super.initState();
    _fullData.addAll(fakeUserList);
  }

  _onItemClick(item) {
    if (_selectedItem.contains(item)) {
      _selectedItem.remove(item);
    } else {
      _selectedItem.add(item);
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
          selected: _selectedItem.contains(item),
          onClickItem: _onItemClick,
          onDeleteItem: (item) {
            _onDeleteItem(item);
          },
        ),
      ),
    );
  }
}
