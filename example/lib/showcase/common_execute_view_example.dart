import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vc_product_widgets/utils/color_constant.dart';
import 'package:vc_product_widgets/utils/vc_icons.dart';
import 'package:vc_product_widgets/vc_product_widgets.dart';

class CommonExecutePage extends StatefulWidget {
  const CommonExecutePage({super.key});

  @override
  State<CommonExecutePage> createState() => _CommonExecutePageStateState();
}

class _CommonExecutePageStateState extends State<CommonExecutePage> {
  String _executeSuccessTitle = "";

  @override
  void initState() {
    super.initState();
    _initExecuteSuccessTitle();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: VCProductColors.instance.backgroundGray,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Column(
            children: [
              // execute title
              if (_executeSuccessTitle.isNotEmpty) _buildExecuteSuccessTitle(),
              //wrap column -> icon ve altında status iconu
              _buildImageView(),
              //execute success mesaj
              _buildExecuteSuccessMessage(),
              //info kısmı column wrap text ve value  liste halinde - bak
              _buildExecuteInfo(),
              //reference number
              _buildReferenceNumber(),
              //information message text
              _buildInformationMessageText(),
              //row buttons link buttons - favorites
              _buildButtons(),
            ],
          ),
        ),
      ),
    );
  }

  _initExecuteSuccessTitle() {
    // var executeSuccessTitleKey = "SuccessfulTitle.${instance!.flow.currentStep?.transactionName}";
    // _executeSuccessTitle = "executeSuccessTitleKey"; //todo resource //this.resourceHelper.getMessage(executeSuccessTitleKey);
    //   if (_executeSuccessTitle == executeSuccessTitleKey) {
    //       _executeSuccessTitle = 'Confirmation';
    //   }
    _executeSuccessTitle = 'CONFIRMATION';
  }

  Widget _buildExecuteSuccessTitle() {
    return Container(
      padding: const EdgeInsets.only(top: 24),
      child: Text(_executeSuccessTitle, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),),
    ); //todo _executeSuccessTitle view ayarla text
  }

  Widget _buildImageView() {
  final imageContainerDecoration = BoxDecoration(
    color: VCProductColors.instance.white,
    borderRadius: BorderRadius.circular(30),
  );

  return Padding(
    padding: const EdgeInsets.only(top: 40),
    child: SizedBox(
            height: 194,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Container(
            padding: const EdgeInsets.all(40),
            decoration: imageContainerDecoration,
            width: 176,
            height: 176,
            child: SvgPicture.asset(
              "assets/icons/ic_upcoming_payments.svg",
              width: 96,
              height: 96,
            ),
          ),
          Positioned(
            bottom: 0, // Adjusted to half of the container's height
            child: Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: VCProductColors.instance.backgroundGray,
              ),
              padding: const EdgeInsets.all(4),
              // Add your bottom image widget here
              child: SvgPicture.asset(
                "assets/icons/ic_circle_check.svg",
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

  Widget _buildExecuteSuccessMessage() {
    var executeSuccessMessage = "Your mobile money transfer is completed.";
    return Container(
      padding: const EdgeInsets.only(top: 24),
      child: Text(executeSuccessMessage, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),),
    ); //todo executeSuccessMessage view ayarla text
  }
  
  Widget _buildExecuteInfo() {
    
    final List<MyListItem> itemList = [
    MyListItem(items: 'Item 1', value: 'Value 1'),
    MyListItem(items: 'Item 2', value: 'Value 2'),
    MyListItem(items: 'Item 3', value: 'Value 3'),
    // Add more items as needed
  ];

  List<Widget> executeSuccessMessage = [];
  for (var element in itemList) {
    var value = Wrap(
      direction: Axis.vertical,
            crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Text(element.items, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),),
        Text(element.value, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),)
      ],
    );
    executeSuccessMessage.add(value);
  }

    return Padding(
      padding: const EdgeInsets.only(top: 40),
      child: Wrap(
        spacing: 24,
        direction: Axis.vertical,
        children: executeSuccessMessage,
      ),
    ); //todo executeSuccessMessage view ayarla text
  }
  
  Widget _buildReferenceNumber() {
    var refNumber = MyListItem(items: 'Transaction Reference Number', value: '234553');
    return Padding(
      padding: const EdgeInsets.only(top: 40),
      child: Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
        direction: Axis.vertical,
        runSpacing: 10,
        children: [
          Text(refNumber.items, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w400)),
          Text(refNumber.value, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w400))
        ],
      ),
    );
  }
  
  Widget _buildInformationMessageText() {
    //todo ask
    return const SizedBox();
  }
  
  Widget _buildButtons() {
    return Padding(
      padding: const EdgeInsets.only(top: 40, left: 10, right: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildButton("Brand", VCIcons.ic_tags, (){}),
          _buildButton("Support", VCIcons.ic_support, (){}),
          _buildButton("Favorite", VCIcons.ic_favorite, (){}),
          _buildButton("Export", VCIcons.ic_export, (){}),
        ],
      ),
    );
  }

  Widget _buildButton( String text, Widget icon, Function() onTap) {
    return Wrap(
            runSpacing: 10,
            direction: Axis.vertical,
            crossAxisAlignment: WrapCrossAlignment.center,

            children: [
            VCButton(
              onTap: onTap, 
              width: 42,
              height: 42,
              backgroundColor: VCProductColors.instance.white,
              child: icon),
              Text( text,  style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w400)),
              ],
          );
  }
}
class MyListItem {
  final String items;
  final String value;

  MyListItem({required this.items, required this.value});
}