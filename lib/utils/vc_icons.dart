// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vc_product_widgets/utils/color_constant.dart';

class VCIcons {

  String? baseAPIURL;

  static final VCIcons instance = VCIcons._();

  factory VCIcons() {
    return instance;
  }

  VCIcons._();

  void init(String baseUrl){
    baseAPIURL = baseUrl;
  }

  Widget getIcon(String path, {Color? color, double? width, double? height}) => SvgPicture.network(
      "${baseAPIURL}dist/images/$path.svg",
      width: width,
      height: height,
      colorFilter: color!=null? ColorFilter.mode(color, BlendMode.srcIn):null
  );
  
  Widget getImage(String path, {double? width, double? height, BoxFit? boxFit}) => Image.network(
      "${baseAPIURL}dist/images/$path.png",
      width: width,
      height: height,
      fit: boxFit,
  );

  static final Widget ic_check_white = SvgPicture.asset(
      "assets/icons/ic_check.svg",
      width: 12,
      height: 10.79,
      colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn));

  ///width and height given according to figma

  static final Widget ic_vector = SvgPicture.asset("assets/icons/ic_vector.svg",
      width: 21.33,
      height: 17.33,
      colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn));

  ///width and height given according to figma

  static final Widget ic_circle_check = SvgPicture.asset(
    "assets/icons/ic_circle_check.svg",
    width: 21.33,
    height: 17.33,
  );

  ///width and height given according to figma

  static final Widget ic_check_circular = SvgPicture.asset(
    "assets/icons/ic_check_circular.svg",
  );

  ///width and height given according to figma

  static final Widget ic_error_circular = SvgPicture.asset(
    "assets/icons/ic_error_circular.svg",
  );

  ///width and height given according to figma

  static final Widget ic_warning_circular =
      SvgPicture.asset("assets/icons/ic_warning_circular.svg");

  ///width and height given according to figma

  static final Widget ic_export = SvgPicture.asset("assets/icons/ic_export.svg",
      width: 24,
      height: 24,
      colorFilter: const ColorFilter.mode(Colors.black, BlendMode.srcIn));

  ///width and height given according to figma

  static final Widget ic_favorite = SvgPicture.asset(
      "assets/icons/ic_favorite.svg",
      width: 24,
      height: 24,
      colorFilter: const ColorFilter.mode(Colors.black, BlendMode.srcIn));

  ///width and height given according to figma

  static final Widget ic_support = SvgPicture.asset(
      "assets/icons/ic_support.svg",
      width: 24,
      height: 24,
      colorFilter: const ColorFilter.mode(Colors.black, BlendMode.srcIn));

  ///width and height given according to figma

  static final Widget ic_tags = SvgPicture.asset("assets/icons/ic_tags.svg",
      width: 24,
      height: 24,
      colorFilter: const ColorFilter.mode(Colors.black, BlendMode.srcIn));

  ///width and height given according to figma

  static final Widget ic_favorite_active = SvgPicture.asset(
      "assets/icons/ic_favorite_active.svg",
      width: 24,
      height: 24,
      colorFilter: ColorFilter.mode(
          VCProductColors.instance.activeTileColor, BlendMode.srcIn));

  ///width and height given according to figma

  static final Widget vcLogo = SvgPicture.asset(
    "assets/icons/vc_logo.svg",
    width: 162.82,
    height: 53.85,
  );

  ///width and height given according to figma

  static final Widget pinkCard = SvgPicture.asset(
    "assets/images/pink_card.svg",
    width: 170.95,
    height: 127.39,
  );

  ///width and height given according to figma

  static final Widget faceIDImage = SvgPicture.asset("assets/icons/faceid.svg");

  static final Widget fingerprintImage =
      SvgPicture.asset("assets/icons/fingerprint.svg");
  static final Widget deleteCrossCircular = SvgPicture.asset(
    "assets/icons/ic_cross_circle.svg",
    width: 24.0,
    height: 24.0,
  );

  ///width and height given according to figma

  static final Widget icCloseCircle = SvgPicture.asset(
    "assets/icons/ic_close_circle.svg",
  );

  static final Widget emptyContainerIcon = SvgPicture.asset(
    "assets/icons/icon_empty_container.svg",
  );

  static final Widget icAtm = SvgPicture.asset(
    "assets/icons/ic_atm.svg",
  );

  static final Widget ic_repeat_finance = SvgPicture.asset(
    "assets/icons/ic_repeat_finance.svg",
    width: 15.01,
    height: 13.5,
  );

  ///width and height given according to figma
  static final Widget icNoCard = SvgPicture.asset(
    "assets/icons/ic_no_card.svg",
  );

  static final Widget icBranch = SvgPicture.asset(
    "assets/icons/ic_branch.svg",
  );

  static final Widget icLocation = SvgPicture.asset(
    "assets/icons/ic_location.svg",
  );

  static final Widget icCallCalling = SvgPicture.asset(
    "assets/icons/ic_call_calling.svg",
  );
  static final Widget icEmail = SvgPicture.asset(
    "assets/icons/ic_email.svg",
  );

  static final Widget icTicket = SvgPicture.asset(
    "assets/icons/ic_ticket.svg",
  );

  static final Widget icTrash = SvgPicture.asset(
    "assets/icons/icon-isys-folder-trash.svg",
  );

  static final Widget icLock = SvgPicture.asset(
    "assets/icons/icon-isys-login-lock-2.svg",
  );

  static final Widget icUnlock = SvgPicture.asset(
    "assets/icons/icon-isys-login-unlock.svg",
  );

  static final Widget icNotificationStatus = SvgPicture.asset(
    "assets/icons/notification-status.svg",
    width: 24,
    height: 24,
  );

  static final Widget icEdit = SvgPicture.asset(
    "assets/icons/icon-isys-folder-edit-2.svg",
  );

  static final Widget icCheck = SvgPicture.asset("assets/icons/ic_check.svg",
      width: 12,
      height: 10.79,
      colorFilter: ColorFilter.mode(
          VCProductColors.instance.iconColor, BlendMode.srcIn));

  static final Widget icClose = SvgPicture.asset(
    "assets/icons/ic_close.svg",
    width: 12,
    height: 10.79,
  );

  static final Widget icPerson = SvgPicture.asset(
    "assets/icons/ic_person.svg",
  );
  static final Widget icInfo = SvgPicture.asset("assets/icons/ic_info.svg");

  static final Widget health = SvgPicture.asset(
    "assets/icons/ic_health.svg",
  );

  static final Widget doc = SvgPicture.asset(
    "assets/icons/ic_doc.svg",
  );
  static final Widget icCard = SvgPicture.asset("assets/icons/ic_card.svg");

  static final Widget icRepayment =
      SvgPicture.asset("assets/icons/ic_repayment.svg");

  static final Widget icHoliday =
      SvgPicture.asset("assets/icons/ic_holiday.svg");

  static final Widget icClosure =
      SvgPicture.asset("assets/icons/ic_closure.svg");

  static final Widget icPersonalLoanPrefix =
      SvgPicture.asset("assets/icons/ic_personal_loan_prefix.svg");

  static final Widget icAutoLoanPrefix =
      SvgPicture.asset("assets/icons/ic_auto_loan_prefix.svg");

  static final Widget icMortgageLoanPrefix =
      SvgPicture.asset("assets/icons/ic_mortgage_loan_prefix.svg");

  static final Widget bgSupport =
      SvgPicture.asset("assets/images/bg-support.svg");

  static final Widget icCommunicationCallPrimary =
      SvgPicture.asset("assets/icons/icon-isys-communication-call-primary.svg");

  static final Widget icCommunicationInboxPrimary = SvgPicture.asset(
      "assets/icons/icon-isys-communication-inbox-primary.svg");

  static final Widget icDanger = SvgPicture.asset("assets/icons/ic_danger.svg");

  static final Widget icUser = SvgPicture.asset(
    "assets/icons/ic_user.svg",
    fit: BoxFit.none,
  );
  static final Widget icBranchWhite = SvgPicture.asset(
    "assets/icons/ic_branch_white.svg",
    fit: BoxFit.none,
  );
  static final Widget icOffice = SvgPicture.asset(
    "assets/icons/ic_office.svg",
    fit: BoxFit.none,
  );

  static final Widget icExchangePrimary =
      SvgPicture.asset("assets/icons/ic_exchange_primary.svg");

  static final Widget icArrowLeft = SvgPicture.asset(
    "assets/icons/ic_arrow_left.svg",
  );

  static final Widget icCommunicationCallCenter = SvgPicture.asset(
    "assets/icons/communication-call-center.svg",
  );

  static final Widget termsAndConditions =
      SvgPicture.asset("assets/images/terms-and-conditions.svg");

  static final Widget confirmFinanceWallet =
      SvgPicture.asset("assets/icons/confirm-finance-wallet-2-money.svg");

  static final Widget icAccountSaving =
      SvgPicture.asset("assets/icons/icon-accountsavings.svg");

  static final Widget icEmptyCountrites = SvgPicture.asset(
    "assets/icons/ic_empty_countries.svg",
  );

  static final Widget icCountryUnlock = SvgPicture.asset(
    "assets/icons/ic_country_unlock.svg",
    width: 18,
    height: 18,
  );

  static final Widget icCountryLock = SvgPicture.asset(
    "assets/icons/ic_country_lock.svg",
    width: 18,
    height: 18,
  );
}
