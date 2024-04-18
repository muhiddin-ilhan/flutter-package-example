import 'package:flutter/material.dart';
import 'package:vc_product_widgets/components/info_box/vc_product_info_box.dart';
import 'package:vc_product_widgets/utils/color_constant.dart';
import 'package:vc_product_widgets/vc_product_widgets.dart';



class ForgotPasswordNewPassword extends StatefulWidget {
  const ForgotPasswordNewPassword({super.key}); 

  @override
  State<ForgotPasswordNewPassword> createState() => _ForgotPasswordForgotPasswordSecurityQuestionState();
}

class _ForgotPasswordForgotPasswordSecurityQuestionState extends State<ForgotPasswordNewPassword> {

  @override
  Widget build(BuildContext context) {
    return Container(
      color: VCProductColors.instance.backgroundGray,

      child: Column(
        children: [
          // pass inputbox
          VCPasswordTextField(
            label: "New Password",
            showSecurityPointText: true,
            showViewIcon: true,
          ),
          context.emptySizedHeightBoxNormal,

          //confirm pass inputbox
          VCPasswordTextField(
            label: "Confirm New Password",
            showDeleteIcon: true,
            showViewIcon: false,
          ),
          context.emptySizedHeightBoxNormal,

          const VCProductInfoBox(
            infoTitle: "Password Policy",
            infoText: "• Not be same as user name.\n• Not be less than 6 characters.\n• Not exceed 16 characters.\n• Combination of alpha numeric characters.\n• Different from last 5 passwords.",
          ),
          

          //info
        ],
      )
    );
  }

  
}