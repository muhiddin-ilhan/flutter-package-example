import 'package:flutter/material.dart';
import 'package:vc_product_widgets/utils/color_constant.dart';

class UserListItem extends StatefulWidget {
  final Function(dynamic)? onClickItem;
  final Function(dynamic)? onDeleteItem;
  final dynamic item;

  const UserListItem({super.key, this.onClickItem, this.onDeleteItem, required this.item});

  @override
  State<UserListItem> createState() => _UserListItemState();
}

class _UserListItemState extends State<UserListItem> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: VCProductColors.instance.navyBlue,
        foregroundColor: Colors.white,
        child: const Icon(Icons.person),
      ),
      textColor: Colors.black,
      tileColor: Colors.white,
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
      onTap: () {
        if (widget.onClickItem != null) {
          widget.onClickItem!(widget.item);
        }
      },
    );
  }
}
