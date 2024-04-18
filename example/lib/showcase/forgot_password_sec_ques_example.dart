import 'package:flutter/material.dart';
import 'package:vc_product_widgets/components/dropdown/vc_product_dropdown.dart';
import 'package:vc_product_widgets/utils/color_constant.dart';
import 'package:vc_product_widgets/vc_product_widgets.dart';



class ForgotPasswordSecurityQuestion extends StatefulWidget {
  const ForgotPasswordSecurityQuestion({super.key}); 

  @override
  State<ForgotPasswordSecurityQuestion> createState() => _ForgotPasswordForgotPasswordSecurityQuestionState();
}

class _ForgotPasswordForgotPasswordSecurityQuestionState extends State<ForgotPasswordSecurityQuestion> {

  TextEditingController controllerCaptcha = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: VCProductColors.instance.backgroundGray,

      child: Column(
        children: [
          _getSecurityQuestionView(context, 1),
          _getSecurityQuestionView(context, 2),
          _getSecurityQuestionView(context, 3),
        ],
      )
    );
  }

  Widget _getSecurityQuestionView(BuildContext context, int value){
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
      
          Text("SECURITY QUESTION $value",),
          context.emptySizedHeightBoxLow,
          VCProductDropdown(
            dropdownItems: const [], 
            label: "Select Question", 
            isDisabled: false, 
            onChanged: (dynamic value, int index){}, 
            selectedItemWidget:  (dynamic value) {
                      return Text(value.toString());
                    },
            selectableItemWidget:  (dynamic value) {
                      return Text(value.toString());
                    },
            isSearchBoxDisabled: false,
            hasBorderBottom: false,
          ),
        
            VCBaseTextField(
              label: "Answer",
              inputType: TextInputType.number,
              hasBorderTop: false,
              obscureText: true,
            ),
            
      ]),
    );
  }

}