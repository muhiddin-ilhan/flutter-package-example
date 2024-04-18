import 'package:flutter/material.dart';

class VCProductColors {
  static final VCProductColors _instance = VCProductColors._init();

  static VCProductColors get instance => _instance;

  VCProductColors._init();

  Color transparent = Colors.transparent;

  Color textColor = const Color(0xFF021D49);

  Color grey = const Color(0xFFD0D4DC);
  Color greyDark = const Color(0xFFA1A9B7);
  Color strokeGray = const Color(0xFFBDBDBD);
  Color lightGrey = const Color(0xFFF5F6F8);
  Color backgroundGray = const Color(0xFFF4F6F7);
  Color shadowGrey = const Color(0xFF061023);

  Color disabledGrey = const Color(0xFFD0D4DB);
  Color white = const Color(0xFFFFFFFF);
  Color white20 = const Color(0xFFFFFFFF).withOpacity(0.2);
  Color white25 = const Color(0xFFFFFFFF).withOpacity(0.25);
  Color white50 = const Color(0xFFFFFFFF).withOpacity(0.50);
  Color white75 = const Color(0xFFFFFFFF).withOpacity(0.75);

  Color black = const Color(0xFF000000);
  Color black25 = const Color(0xFF000000).withOpacity(0.25);
  Color black50 = const Color(0xFF000000).withOpacity(0.50);
  Color black75 = const Color(0xFF000000).withOpacity(0.75);

  Color navyBlue = const Color(0xFF15284B);
  Color navyBlue1 = const Color(0xFF2B3D5C);
  Color navyBlue2 = const Color(0xFF43536F);
  Color navyBlue3 = const Color(0xFF5A6880);
  Color navyBlue4 = const Color(0xFF727E93);
  Color navyBlue5 = const Color(0xFF8993A4);
  Color navyBlue6 = const Color(0xFFA1A9B7);
  Color navyBlue7 = const Color(0xFFB8BEC8);
  Color navyBlue8 = const Color(0xFFD0D4DB);

  Color green = const Color(0xFF00BF55);
  Color green1 = const Color(0xFF00C753);
  Color green2 = const Color(0xFF2FD172);
  Color green3 = const Color(0xFF43CF7E);
  Color green4 = const Color(0xFF62D391);
  Color green5 = const Color(0xFF6FDA9B);
  Color green6 = const Color(0xFF7EE3A7);
  Color green7 = const Color(0xFF99E9BA);
  Color green8 = const Color(0xFFB2EECB);
  Color green9 = const Color(0xFFCCF4DC);

  Color blue = const Color(0xFF02C3FF);
  Color blue1 = const Color(0xFF1AC8FF);
  Color blue2 = const Color(0xFF34CFFF);
  Color blue3 = const Color(0xFF4DD5FF);
  Color blue4 = const Color(0xFF67DBFF);
  Color blue5 = const Color(0xFF80E1FF);
  Color blue6 = const Color(0xFF99E7FF);
  Color blue7 = const Color(0xFFB2EDFF);
  Color blue8 = const Color(0xFFCCF3FF);

  Color lightBlue = const Color(0xFF8FCFFF);
  Color lightBlue1 = const Color(0xFF9AD3FF);
  Color lightBlue2 = const Color(0xFFA5D8FF);
  Color lightBlue3 = const Color(0xFFB0DDFF);
  Color lightBlue4 = const Color(0xFFBCE2FF);
  Color lightBlue5 = const Color(0xFFC7E7FF);
  Color lightBlue6 = const Color(0xFFD2ECFF);
  Color lightBlue7 = const Color(0xFFDDF1FF);
  Color lightBlue8 = const Color(0xFFE9F6FF);
  Color lightBlueIconBg = const Color(0xFFD6E2F9);

  Color orange = const Color(0xFFFF8002);
  Color orange1 = const Color(0xFFFF8C1A);
  Color orange2 = const Color(0xFFFF9934);
  Color orange3 = const Color(0xFFFFA64D);
  Color orange4 = const Color(0xFFFFB367);
  Color orange5 = const Color(0xFFFFBF80);
  Color orange6 = const Color(0xFFFFCC99);
  Color orange7 = const Color(0xFFFFD9B2);
  Color orange8 = const Color(0xFFFFE6CC);

  Color yellow3 = const Color(0xFFFCBB4D);

  Color red = const Color(0xFFFF2442);
  Color red1 = const Color(0xFFFF3954);
  Color red2 = const Color(0xFFEF4444);
  Color red3 = const Color(0xFFFF4F67);
  Color red4 = const Color(0xFFFF657A);
  Color red5 = const Color(0xFFFF7B8D);
  Color red6 = const Color(0xFFFF91A0);
  Color red7 = const Color(0xFFFFA7B3);
  Color red8 = const Color(0xFFFFBCC6);
  Color red9 = const Color(0xFFFFD3D9);

  Color disabledWidgetBackgroundColor = const Color(0xFFE2E6EB);
  Color defaultColor = Colors.white;
  Color errorWidgetColor = const Color(0xFFEF3123);
  Color widgetBorderColor = const Color(0xFFC9D9DD);
  Color labelColor = const Color(0xFF64748B);
  Color widgetTextColor = const Color(0xFF121212);
  Color bottomSheetBGColor = const Color(0xFFF4F4F4);

  Color activeTileColor = const Color(0xFF316CE2);
  Color activeButtonColor = const Color(0xFF183671);

  Color loadingIndicatorColor1 = const Color(0xFFD2F7FF);
  Color loadingIndicatorColor2 = const Color(0xFFF4F4F4);

  Color iconColor = const Color(0xFF316CE2);

  Color backgroundGradientStart = const Color(0xFF316CE2);
  Color backgroundGradientEnd = const Color(0xFF213997);

  Color cardGradientStart = const Color(0xFF5778F0);
  Color cardGradientEnd = const Color(0xFF152D83);
  Color cardGradientBorderEnd = const Color(0xFF01040E);

  /// Alert Colors
  //Success
  Color alertSuccessLightColor = const Color(0xFFC3E6CB);
  Color alertSuccessDarkColor = const Color(0xFF2B9744);
  Color alertSuccessTextColor = const Color(0xFF155724);

  //Error
  Color alertErrorLightColor = const Color(0xFFF8D7DA);
  Color alertErrorDarkColor = const Color(0xFFB91C1C);
  Color alertErrorTextColor = const Color(0xFF7F1D1D);

  //Info
  Color alertInfoLightColor = const Color(0xFFB8DAFF);
  Color alertInfoDarkColor = const Color(0xFF052E4D);
  Color alertInfoTextColor = const Color(0xFF052E4D);

  //Warning
  Color alertWarningLightColor = const Color(0xFFFFEEBA);
  Color alertWarningDarkColor = const Color(0xFFFF9730);
  Color alertWarningTextColor = const Color(0xFF92610E);
  Color alertWarningBackgroundColor = const Color(0xFFFFF3CD);

  /// Snackbar Colors
  Color snackbarBackgroundColor = const Color(0xFF444B5A);

  /// Popup Colors
  Color popupInfoIconColor = const Color(0xFF316CE2);

  //card status colors
  Color statusWarningColor = const Color(0xFFFDD28A);
  Color statusActiveColor = const Color(0xFFBCFAA4);
  Color statusErrorColor = const Color(0xFFEF3123);
  Color statusWeakColor = const Color(0xFFFF5767);

  Color countdownWarningColor = const Color(0xFFFDBC3F);

  //QR Scanner
  Color scannerBorder = const Color(0xFF4E596C);
  Color scannerCorners = const Color(0xFFC9CFD8);

  //Badge
  Color badgeRedTextColor = const Color(0xFF7F1D1D);
  Color badgeRedBgColor = const Color(0xFFF8D7DA);
  Color badgeBlueBgColor = const Color(0xFFCCE5FF);
  Color badgeBlueTextColor = const Color(0xFF052E4D);

  Color yellowCardType = const Color(0xFFFFEEBA);
  Color purpleCardType = const Color(0xFFe2d6fe);
  Color greenCardType = const Color(0xFFd8f4b3);
  Color pinkCardType = const Color(0xFFFDD4C6);

  Color tagNeon30 = const Color(0xFFD7FF59);
}
