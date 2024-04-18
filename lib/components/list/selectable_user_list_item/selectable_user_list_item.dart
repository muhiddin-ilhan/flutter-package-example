import 'package:flutter/material.dart';
import 'package:vc_product_widgets/utils/color_constant.dart';

class SelectableUserListItem extends StatefulWidget {
  final Function(dynamic)? onClickItem;
  final Function(dynamic)? onDeleteItem;
  final bool selected;
  final dynamic item;

  const SelectableUserListItem({super.key, this.onClickItem, this.onDeleteItem, required this.item, required this.selected});

  @override
  State<SelectableUserListItem> createState() => _SelectableUserListItemState();
}

class _SelectableUserListItemState extends State<SelectableUserListItem> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: widget.selected ? Colors.green : VCProductColors.instance.navyBlue,
        foregroundColor: widget.selected ? Colors.white : Colors.white,
        child: Icon(widget.selected ? Icons.done_outline_rounded : Icons.person),
      ),
      textColor: Colors.black,
      tileColor: widget.selected ? const Color(0x11316ce2) : Colors.white,
      trailing: IconButton(
        icon: const Icon(
          Icons.delete_forever_rounded,
          color: Colors.grey,
        ),
        onPressed: () {
          if (widget.onDeleteItem != null) {
            widget.onDeleteItem!(widget.item);
          }
        },
      ),
      title: Text("${widget.item["name"]} ${widget.item["surname"]}"),
      subtitle: Text("${widget.item["age"]} Yaşında"),
      onTap: () {
        if (widget.onClickItem != null) {
          widget.onClickItem!(widget.item);
        }
      },
    );
  }
}
