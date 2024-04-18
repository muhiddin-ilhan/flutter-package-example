import 'package:flutter/material.dart';
import 'package:vc_product_network/vc_product_network.dart';
import 'package:vc_product_widgets/components/buttons/selectable_button_list/vc_product_selectable_button_list.dart';
import 'package:vc_product_widgets/components/captcha/vc_product_captcha.dart';
import 'package:vc_product_widgets/components/info_box/vc_product_info_box.dart';
import 'package:vc_product_widgets/components/inputs/input_type.dart';
import 'package:vc_product_widgets/utils/color_constant.dart';
import 'package:vc_product_widgets/vc_product_widgets.dart';

enum ForgotUsernameAccountTypeCheckEnum {
		undefined(title: "Undefined"),
		debitCard(title: "DebitCard"),
		primaryAccount(title: "PrimaryAccount"),;

  final String? title;

  @override
  @override
  String toString() => title ?? "";

  const ForgotUsernameAccountTypeCheckEnum({this.title});
	}

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key}); 

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {

  TextEditingController controllerCaptcha = TextEditingController();
  ForgotUsernameAccountTypeCheckEnum selectedAccountType = ForgotUsernameAccountTypeCheckEnum.debitCard;

  var apiUrl = "https://vcmbibv8newui.demo.veripark.com/";
  @override
  Widget build(BuildContext context) {
    return Container(
      color: VCProductColors.instance.backgroundGray,

      child: Column(
        children: [
          //info text
          const VCProductInfoBox(
            infoText:  "Select either Card or Account to retrieve username"//"Title.ForgotpasswordInformationText".tr(context),
          ),
          //select button
          _buildAccountTypeRadios() ,
          context.emptySizedHeightBoxLow,

          if(selectedAccountType == ForgotUsernameAccountTypeCheckEnum.debitCard) _buildCardTypeWidget()
          else if (selectedAccountType == ForgotUsernameAccountTypeCheckEnum.primaryAccount) _buildAccountTypeWidget(),
          
          context.emptySizedHeightBoxLow,

          //captcha input field 

          VCProductCaptcha(
            apiUrl: apiUrl,
            label: "Security Code",
            errorText: ValidatorService.getErrorMessage("captchaGenerator"),
                  controller: controllerCaptcha,
                  onChanged: (text) {
                    // ValidatorService.validate<String>(
                    //     componentId: "captchaGenerator",
                    //     value: text,
                    //     showError: true);
                  },
          ),
          //continue button
        ],
      )
    );
  }


  final _defaultPadding = const EdgeInsets.only(top: 16.0);
  _buildAccountTypeRadios() {
    return Container(
      padding: _defaultPadding,
      child: VCProductSelectableButtonList(
        fitTheCurrentWidth: true,
        buttons: ForgotUsernameAccountTypeCheckEnum.values
            .where((element) => element != ForgotUsernameAccountTypeCheckEnum.undefined)
            .toList(),
        textAlign: TextAlign.center,
        padding: const EdgeInsets.symmetric(horizontal: 5),
        isRadio: true,
        selectedButtonIndex: 0,
        onSelected: (value, index, selected) {
          setState(() {
            selectedAccountType = value;
            //FlowService.instance.currentRequest.accountTypeCheck = value.title;
            // _selectedDeliveryType = value;
          });
          // debugPrint(value.toString());
        },
      ),
    );
  }

  Widget _buildCardTypeWidget(){
    return Column(
      children: [
      //card number input field 
          VCMaskedTextField(
            label: "Card Number",
            maskedType: InputType.cardNumber,
            hint: "",
            inputType: TextInputType.number,
          ),

          context.emptySizedHeightBoxLow,

          //card pin input field
          VCBaseTextField(
            label: "Card Pin",
            inputType: TextInputType.number,
            obscureText: true,
          ),
          
    ]);
  }

   Widget _buildAccountTypeWidget(){
    return VCBaseTextField(
            label: "Account Number",
            inputType: TextInputType.number,
            obscureText: true,
          );
  }
}