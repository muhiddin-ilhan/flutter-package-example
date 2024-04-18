import 'package:flutter/material.dart';
import 'package:vc_product_widgets/components/vc_product_components.dart';
import 'package:vc_product_widgets/utils/color_constant.dart';
import 'package:vc_product_widgets/vc_product_widgets.dart';

class ButtonShowcase extends StatefulWidget {
  const ButtonShowcase({super.key});

  @override
  State<ButtonShowcase> createState() => _ButtonShowcaseState();
}

class _ButtonShowcaseState extends State<ButtonShowcase> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEEEEEE),
      appBar: AppBar(
        backgroundColor: VCProductColors.instance.navyBlue,
        foregroundColor: VCProductColors.instance.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              primaryButtonWithPrefix(),
              space(12),
              primaryButtonWithSuffix(),
              space(12),
              strokeButtonIcon(),
              space(12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  strokeButtonSmallIcon(Icons.arrow_back_ios_new_rounded),
                  strokeButtonSmallIcon(Icons.done),
                  strokeButtonSmallIcon(Icons.close),
                  strokeButtonSmallIcon(Icons.arrow_forward_ios_rounded),
                ],
              ),
              const Divider(height: 48),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        primaryButton(false, VCButtonSize.small),
                        space(12),
                        primaryButton(false, VCButtonSize.medium),
                        space(12),
                        primaryButton(false, VCButtonSize.large),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      children: [
                        primaryButton(true, VCButtonSize.small),
                        space(12),
                        primaryButton(true, VCButtonSize.medium),
                        space(12),
                        primaryButton(true, VCButtonSize.large),
                      ],
                    ),
                  ),
                ],
              ),
              const Divider(height: 48),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        secondaryButton(false, VCButtonSize.small),
                        space(12),
                        secondaryButton(false, VCButtonSize.medium),
                        space(12),
                        secondaryButton(false, VCButtonSize.large),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      children: [
                        secondaryButton(true, VCButtonSize.small),
                        space(12),
                        secondaryButton(true, VCButtonSize.medium),
                        space(12),
                        secondaryButton(true, VCButtonSize.large),
                      ],
                    ),
                  ),
                ],
              ),
              const Divider(height: 48),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        strokeButton(false, VCButtonSize.small),
                        space(12),
                        strokeButton(false, VCButtonSize.medium),
                        space(12),
                        strokeButton(false, VCButtonSize.large),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      children: [
                        strokeButton(true, VCButtonSize.small),
                        space(12),
                        strokeButton(true, VCButtonSize.medium),
                        space(12),
                        strokeButton(true, VCButtonSize.large),
                      ],
                    ),
                  ),
                ],
              ),
              const Divider(height: 48),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        ghostButton(false, VCButtonSize.small),
                        space(12),
                        ghostButton(false, VCButtonSize.medium),
                        space(12),
                        ghostButton(false, VCButtonSize.large),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      children: [
                        ghostButton(true, VCButtonSize.small),
                        space(12),
                        ghostButton(true, VCButtonSize.medium),
                        space(12),
                        ghostButton(true, VCButtonSize.large),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget primaryButton(bool disabled, VCButtonSize size) {
    return VCProductComponents.vcButton(
      onTap: () {},
      disabled: disabled,
      buttonType: VCButtonType.primary,
      buttonSize: size,
      child: Text("Primary ${size == VCButtonSize.small ? 'Small' : size == VCButtonSize.medium ? 'Medium' : 'Large'}"),
    );
  }

  Widget primaryButtonWithPrefix() {
    return VCProductComponents.vcButton(
      onTap: () {},
      buttonType: VCButtonType.primary,
      buttonSize: VCButtonSize.medium,
      prefixWidget: const Icon(Icons.add, size: 24),
      padding: const EdgeInsets.only(right: 24),
      child: const Text("Prefix Icon"),
    );
  }

  Widget primaryButtonWithSuffix() {
    return VCProductComponents.vcButton(
      onTap: () {},
      buttonType: VCButtonType.primary,
      buttonSize: VCButtonSize.medium,
      suffixWidget: const Icon(Icons.add, size: 24),
      padding: const EdgeInsets.only(left: 24),
      child: const Text("Suffix Icon"),
    );
  }

  Widget strokeButtonIcon() {
    return VCProductComponents.vcButton(
      onTap: () {},
      highlightForegroundColor: Colors.white,
      buttonType: VCButtonType.stroke,
      buttonSize: VCButtonSize.medium,
      child: const Icon(Icons.delete),
    );
  }

  Widget strokeButtonSmallIcon(IconData icon) {
    return VCProductComponents.vcButton(
      onTap: () {},
      highlightForegroundColor: Colors.white,
      width: 0,
      buttonType: VCButtonType.stroke,
      buttonSize: VCButtonSize.medium,
      child: Icon(icon),
    );
  }

  Widget secondaryButton(bool disabled, VCButtonSize size) {
    return VCProductComponents.vcButton(
      onTap: () {},
      disabled: disabled,
      buttonType: VCButtonType.secondary,
      buttonSize: size,
      child: Text("Secondary ${size == VCButtonSize.small ? 'Small' : size == VCButtonSize.medium ? 'Medium' : 'Large'}"),
    );
  }

  Widget strokeButton(bool disabled, VCButtonSize size) {
    return VCProductComponents.vcButton(
      onTap: () {},
      disabled: disabled,
      highlightForegroundColor: Colors.white,
      buttonType: VCButtonType.stroke,
      buttonSize: size,
      child: Text("Stroke ${size == VCButtonSize.small ? 'Small' : size == VCButtonSize.medium ? 'Medium' : 'Large'}"),
    );
  }

  Widget ghostButton(bool disabled, VCButtonSize size) {
    return VCProductComponents.vcButton(
      onTap: () {},
      disabled: disabled,
      highlightForegroundColor: Colors.white,
      buttonType: VCButtonType.ghost,
      buttonSize: size,
      child: Text("Ghost ${size == VCButtonSize.small ? 'Small' : size == VCButtonSize.medium ? 'Medium' : 'Large'}"),
    );
  }

  Widget space(double val) {
    return SizedBox(height: val);
  }
}
