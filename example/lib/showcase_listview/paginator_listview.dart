import 'package:flutter/material.dart';
import 'package:vc_product_widgets/components/list/selectable_user_list_item/selectable_user_list_item.dart';
import 'package:vc_product_widgets/components/list/vc_list_view/vc_list_view.dart';
import 'package:vc_product_widgets/components/vc_product_components.dart';
import 'package:vc_product_widgets/utils/color_constant.dart';

import 'data/data.dart';

class PaginatorListView extends StatefulWidget {
  const PaginatorListView({super.key});

  @override
  State<PaginatorListView> createState() => _PaginatorListViewState();
}

class _PaginatorListViewState extends State<PaginatorListView> {
  final List _fullData = [];
  Map? _selectedItem;
  int _sequence = 1;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadData(_sequence);
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

  _onItemClick(item) {
    if (_selectedItem == item) {
      _selectedItem = null;
    } else {
      _selectedItem = item;
    }
    setState(() {});
  }

  _loadData(int sequence) async {
    setState(() {
      _sequence = sequence;
      _isLoading = true;
    });

    await Future.delayed(const Duration(milliseconds: 1500));

    int startIndex = (_sequence - 1) * 10;
    int endIndex = startIndex + 10 > fakeUserList.length ? fakeUserList.length : startIndex + 10;

    _fullData.clear();
    _fullData.addAll(fakeUserList.sublist(startIndex, endIndex));

    setState(() {
      _isLoading = false;
    });
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
        marginPaginatorBottom: 12,
        paginateType: VCPaginateType.normal,
        paginatorSelectedBackgroundColor: VCProductColors.instance.navyBlue,
        currentPageNumber: _sequence,
        totalPageNumber: 11,
        isLoading: _isLoading,
        onNewPage: (seq) async {
          _loadData(seq);
        },
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
