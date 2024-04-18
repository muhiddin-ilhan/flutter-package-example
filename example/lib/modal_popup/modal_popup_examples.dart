import 'package:flutter/material.dart';
import 'package:vc_product_widgets/components/vc_product_components.dart';
import 'package:vc_product_widgets/helper/modal_popup/modal_popup_helper.dart';
import 'package:vc_product_widgets/helper/sizer_helper.dart';
import 'package:vc_product_widgets/utils/color_constant.dart';

class ModalPopupExamples extends StatefulWidget {
  const ModalPopupExamples({Key? key}) : super(key: key);

  @override
  State<ModalPopupExamples> createState() => _ModalPopupExamplesState();
}

class _ModalPopupExamplesState extends State<ModalPopupExamples> {
  List menuNames = [
    "Html Popup",
    "Popup with Close Button",
    "Popup with confirm",
    "Popup with cancel&confirm",
    "Popup with custom buttons"
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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            VCProductComponents.listView(
              containerMargin: const EdgeInsets.all(16),
              containerHeight: 350,
              dataList: menuNames,
              onItemBuilder: (index, item) => _button(
                onPressed: () {
                  switch (item) {
                    case "Html Popup":
                      ModalPopupHelper.instance.showHtmlModal(context,
                          "<center><h1>Header 1</h1><br><h2>Header 2</h2><br><h3>Header 3</h3></center>");
                    case "Popup with Close Button":
                      ModalPopupHelper.instance.showWidgetModal(
                          context, type1Carousel,
                          hasCloseButton: true, minHeight: 100);
                    case "Popup with confirm":
                      ModalPopupHelper.instance.showHtmlModal(context,
                          "<center><h1>Header 1</h1><br><h2>Header 2</h2><br><h3>Header 3</h3></center>",
                          hasConfirmButton: true, onConfirm: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Confirm Clicked')),
                        );
                      });
                    case "Popup with cancel&confirm":
                      ModalPopupHelper.instance.showHtmlModal(
                        context,
                        "<center><h1>Header 1</h1><br><h2>Header 2</h2><br><h3>Header 3</h3></center>",
                        hasCancelButton: true,
                        hasConfirmButton: true,
                        minHeight: 500,
                        onConfirm: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Confirm Clicked')),
                          );
                        },
                      );
                    case "Popup with custom buttons":
                      ModalPopupHelper.instance.showHtmlModal(
                        context,
                        "<center><h1>Header 1</h1><br><h2>Header 2</h2><br><h3>Header 3</h3></center>",
                        hasCancelButton: true,
                        hasConfirmButton: true,
                        cancelButtonText: "Disable",
                        confirmButtonText: "Allow",
                        onConfirm: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Allow Clicked')),
                          );
                        },
                        onCancel: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Disable Clicked')),
                          );
                        },
                      );
                  }
                },
                text: menuNames[index],
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(24.0),
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
                      "All examples shown in this menu were created using [ModalPopupHelper].",
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

  Widget _button({required Function() onPressed, required String text}) =>
      Padding(
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

  Widget get type1Carousel => VCProductComponents.vcCarousel<int>(
        aspectRatio: 358 / 140,
        autoPlay: true,
        viewportFraction: 1,
        items: const [2, 3, 4, 5],
        itemBuilder: (item) => Padding(
          padding: const EdgeInsets.all(8.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              "assets/carousel/$item.png",
              fit: BoxFit.contain,
            ),
          ),
        ),
      );
}
