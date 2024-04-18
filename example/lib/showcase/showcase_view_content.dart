import 'dart:async';
import 'package:example/account_item/account_main_showcase.dart';
import 'package:example/bill_showcase/bill_showcase_menu.dart';
import 'package:example/button_showcase/button_showcase.dart';
import 'package:example/carousel_showcase/carousel_showcase.dart';
import 'package:example/information_container_showcase/information_container_showcase.dart';
import 'package:example/qr_showcase/qr_showcase.dart';
import 'package:example/rating_start_showcase/rating_star_showcase.dart';
import 'package:example/recipient_item/recipient_main_showcase.dart';
import 'package:example/showcase/alerts_examples.dart';
import 'package:example/showcase/chart_examples.dart';
import 'package:example/showcase/captcha_example.dart';
import 'package:example/showcase/date_picker_examples.dart';
import 'package:example/showcase/file_picker_examples.dart';
import 'package:example/showcase/input_text_field_examples.dart';
import 'package:example/showcase/slider_examples.dart';
import 'package:example/showcase/radio_selectable_button_examples.dart';
import 'package:example/showcase/security_check_examples.dart';
import 'package:example/showcase/switch_examples.dart';
import 'package:example/showcase/term_and_conditions_examples.dart';
import 'package:example/showcase/timeout_examples.dart';
import 'package:example/showcase_listview/listviews_home.dart';
import 'package:example/stepper_showcase/stepper_showcase.dart';
import 'package:flutter/material.dart';
import 'package:vc_product_widgets/components/vc_product_components.dart';
import 'package:vc_product_widgets/vc_product_widgets.dart';
import '../bottom_nav_bar_showcase/bottom_navbar_showcase.dart';
import '../map_showcase/map_showcase.dart';
import '../menu_showcase/vc_menu_popup.dart';
import '../modal_popup/modal_popup_examples.dart';
import '../sliding_up_panel_showcase/sliding_up_panel_showcase.dart';
import '../text_showcase/text_showcase.dart';
import 'checkbox_examples.dart';
import 'dropdown_examples.dart';
import 'num_pad_field_example.dart';

class ShowcaseViewContent extends StatefulWidget {
  const ShowcaseViewContent({Key? key}) : super(key: key);

  @override
  State<ShowcaseViewContent> createState() => _ShowcaseViewContentState();
}

class _ShowcaseViewContentState extends State<ShowcaseViewContent> {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.center,
      runSpacing: 12,
      children: [
        VCProductComponents.vcButton(
          child: const Text("Bill Items"),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const BillShowcaseMenu(),
              ),
            );
          },
        ),
        VCProductComponents.vcButton(
          child: const Text("Account Items"),
          padding: const EdgeInsets.only(right: 24),
          prefixWidget: const Icon(Icons.account_box),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const AccountMainShowcase(),
              ),
            );
          },
        ),
        VCProductComponents.vcButton(
          child: const Text("Text"),
          padding: const EdgeInsets.only(right: 24),
          prefixWidget: const Icon(Icons.text_fields),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const TextShowcase(),
              ),
            );
          },
        ),
        VCProductComponents.elevatedButton(
          size: ButtonSize.large,
          text: "Text Input Fields",
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const InputTextFieldExamples(),
              ),
            );
          },
        ),
        VCProductComponents.elevatedButton(
          size: ButtonSize.large,
          text: "Numpad",
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const NumPadFieldExamples(),
              ),
            );
          },
        ),
        VCProductComponents.vcButton(
          child: const Text("ListView"),
          padding: const EdgeInsets.only(right: 24),
          prefixWidget: const Icon(Icons.list_alt_outlined),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const ListViewHome(),
              ),
            );
          },
        ),
        VCProductComponents.elevatedButton(
          size: ButtonSize.large,
          text: "Dropdown",
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const DropdownExamples(),
              ),
            );
          },
        ),
        VCProductComponents.elevatedButton(
          size: ButtonSize.large,
          text: "Date Picker",
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const DatePickerExamples(),
              ),
            );
          },
        ),
        VCProductComponents.vcButton(
          child: const Text("Map"),
          padding: const EdgeInsets.only(right: 24),
          prefixWidget: const Icon(Icons.map_rounded),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const MapShowcase(),
              ),
            );
          },
        ),
        VCProductComponents.elevatedButton(
          size: ButtonSize.large,
          text: "Checkbox",
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const CheckBoxExamples(),
              ),
            );
          },
        ),
        VCProductComponents.vcButton(
          child: const Text("Carousel"),
          padding: const EdgeInsets.only(right: 24),
          prefixWidget: const Icon(Icons.view_carousel_outlined),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const CarouselShowcase(),
              ),
            );
          },
        ),
        VCProductComponents.elevatedButton(
          size: ButtonSize.large,
          text: "Modal Popup",
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const ModalPopupExamples(),
              ),
            );
          },
        ),
        VCProductComponents.elevatedButton(
          size: ButtonSize.large,
          text: "Loading Spinner Test (3 seconds)",
          onPressed: () {
            VCLoadingSpinner.show();
            Timer(const Duration(seconds: 3), () {
              VCLoadingSpinner.dismiss();
            });
          },
        ),
        VCProductComponents.elevatedButton(
          size: ButtonSize.large,
          text: "File Picker",
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const FilePickerExamples(),
              ),
            );
          },
        ),
        VCProductComponents.vcButton(
          child: const Text("Buttons"),
          padding: const EdgeInsets.only(right: 24),
          prefixWidget: const Icon(Icons.view_stream_rounded),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const ButtonShowcase(),
              ),
            );
          },
        ),
        VCProductComponents.elevatedButton(
          size: ButtonSize.large,
          text: "Switch",
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const SwitchExamples(),
              ),
            );
          },
        ),
        VCProductComponents.vcButton(
          child: const Text("Menu"),
          padding: const EdgeInsets.only(right: 24),
          prefixWidget: const Icon(Icons.menu),
          onTap: () async {
            await showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              useSafeArea: true,
              useRootNavigator: true,
              barrierColor: Colors.transparent,
              builder: (context) => const VCMenuPopup(),
            );
          },
        ),
        VCProductComponents.vcButton(
          child: const Text("Security Checks"),
          padding: const EdgeInsets.only(right: 24),
          prefixWidget: const Icon(Icons.security),
          onTap: () async {
            await SecurityCheckExamples.securityChecksWidget(context);
          },
        ),
        VCProductComponents.vcButton(
          child: const Text("Information Container"),
          padding: const EdgeInsets.only(right: 24),
          prefixWidget: const Icon(Icons.info_outline),
          onTap: () async {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const InformationContainerShowcase(),
              ),
            );
          },
        ),
        VCProductComponents.vcButton(
          child: const Text("Radio & Selectable Button"),
          padding: const EdgeInsets.only(right: 24),
          onTap: () async {
            await showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              useSafeArea: true,
              useRootNavigator: true,
              barrierColor: Colors.transparent,
              builder: (context) => const RadioSelectableButtonExamples(),
            );
          },
        ),
        VCProductComponents.elevatedButton(
          size: ButtonSize.large,
          text: "Slider",
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const SliderExamples(),
              ),
            );
          },
        ),
        VCProductComponents.elevatedButton(
          size: ButtonSize.large,
          text: "Charts",
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const ChartExamples(),
              ),
            );
          },
        ),
        VCProductComponents.elevatedButton(
          size: ButtonSize.large,
          text: "Captcha",
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const CaptchaExamples(),
              ),
            );
          },
        ),
        VCProductComponents.elevatedButton(
          size: ButtonSize.large,
          text: "Alerts",
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const AlertsExamples(),
              ),
            );
          },
        ),
        VCProductComponents.elevatedButton(
          size: ButtonSize.large,
          text: "Timeout",
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const TimeoutPopupExample(),
              ),
            );
          },
        ),
        VCProductComponents.elevatedButton(
          size: ButtonSize.large,
          text: "Terms & Conditions",
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const TermAndConditionsExamples(),
              ),
            );
          },
        ),
        VCProductComponents.vcButton(
          child: const Text("Recipient"),
          padding: const EdgeInsets.only(right: 24),
          prefixWidget: const Icon(Icons.info_outline),
          onTap: () async {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const RecipientMainShowcase(),
              ),
            );
          },
        ),
        VCProductComponents.elevatedButton(
            size: ButtonSize.large,
            text: "Bottom Navigation Bar",
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const BottomNavBarExamples(),
                ),
              );
            }),
        VCProductComponents.vcButton(
          child: const Text("Qr Scanner"),
          padding: const EdgeInsets.only(right: 24),
          prefixWidget: const Icon(Icons.qr_code_2),
          onTap: () async {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const QrShowcase(),
              ),
            );
          },
        ),
        VCProductComponents.vcButton(
          child: const Text("Sliding Up Panel"),
          padding: const EdgeInsets.only(right: 24),
          prefixWidget: const Icon(Icons.menu_outlined),
          onTap: () async {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const SlidingUpPanelShowcase(),
              ),
            );
          },
        ),
        VCProductComponents.vcButton(
          child: const Text("Stepper"),
          padding: const EdgeInsets.only(right: 24),
          prefixWidget: const Icon(Icons.more_horiz_rounded),
          onTap: () async {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const StepperShowCase(),
              ),
            );
          },
        ),
        VCProductComponents.vcButton(
          child: const Text("Rating Stars"),
          padding: const EdgeInsets.only(right: 24),
          prefixWidget: const Icon(Icons.star),
          onTap: () async {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const RatingStarShowcase(),
              ),
            );
          },
        ),

      ],
    );
  }
}
