import 'dart:math';

import 'package:flutter/material.dart';
import 'package:vc_product_widgets/utils/color_constant.dart';
import 'package:vc_product_widgets/vc_product_widgets.dart';

/// A stepper component widget that displays a sequence of steps with optional icons or numbers.
class VCStepperComponent extends StatefulWidget {
  /// The size of each step box.
  final double? stepBoxSize;

  /// The text displayed as headline.
  final String? headlineText;

  /// Additional information text.
  final String? infoText;

  /// Total number of steps.
  final int? stepCount;

  /// The index of the currently active step.
  final int? activeStep;

  /// Color of active steps.
  final Color? activeStepColor;

  /// Color of inactive steps.
  final Color? inactiveStepColor;

  /// Border color of active steps.
  final Color? activeStepBorderColor;

  /// Border color of inactive steps.
  final Color? inactiveStepBorderColor;

  /// Text color of active steps.
  final Color? activeStepTextColor;

  /// Text color of inactive steps.
  final Color? inactiveStepTextColor;

  /// Constructs a [VCStepperComponent].
  /// Parameters:
  /// - stepBoxSize: The size of each step box. Defaults to 28.
  /// - headlineText: The text displayed as headline.
  /// - infoText: Additional information text.
  /// - stepCount: Total number of steps.
  /// - activeStep: The index of the currently active step.
  /// - activeStepColor: Color of active steps.
  /// - inactiveStepColor: Color of inactive steps.
  /// - activeStepBorderColor: Border color of active steps.
  /// - inactiveStepBorderColor: Border color of inactive steps.
  /// - activeStepTextColor: Text color of active steps.
  /// - inactiveStepTextColor: Text color of inactive steps.
  const VCStepperComponent({
    Key? key,
    this.stepBoxSize,
    this.headlineText,
    this.infoText,
    this.stepCount,
    this.activeStep,
    this.activeStepColor,
    this.inactiveStepColor,
    this.activeStepBorderColor,
    this.inactiveStepBorderColor,
    this.activeStepTextColor,
    this.inactiveStepTextColor,
  }) : super(key: key);

  @override
  State<VCStepperComponent> createState() => _VCStepperComponentState();
}

class _VCStepperComponentState extends State<VCStepperComponent> {
  late double stepBoxSize = widget.stepBoxSize ?? 28;

  late Color activeStepColor;
  late Color inactiveStepColor;
  late Color activeStepBorderColor;
  late Color inactiveStepBorderColor;

  @override
  Widget build(BuildContext context) {
    // Determine colors for active and inactive steps
    activeStepColor =
        widget.activeStepColor ?? VCProductColors.instance.activeTileColor;
    inactiveStepColor =
        widget.inactiveStepColor ?? VCProductColors.instance.white;
    activeStepBorderColor = widget.activeStepBorderColor ??
        VCProductColors.instance.activeTileColor;
    inactiveStepBorderColor = widget.inactiveStepBorderColor ??
        VCProductColors.instance.disabledWidgetBackgroundColor;

    return LayoutBuilder(builder: (_, BoxConstraints box) {
      // Calculate the width of the last item in case there are stacked steps
      final stackedStepCount =
          widget.stepCount != null && widget.stepCount! >= 6
              ? widget.stepCount! - 5
              : 0;
      final lastItemWidth =
          max(stepBoxSize + (stepBoxSize / 4) * (stackedStepCount - 1), 0);
      final dividerWidth = ((box.constrainWidth() - lastItemWidth) /
          (((widget.stepCount ?? 2) > 6 ? 6 : (widget.stepCount ?? 2))));

      return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Display headline text if provided
          if (widget.headlineText != null) ...[
            Row(
              children: [
                // Display an icon for the first step if step count is not provided or less than 1
                if (widget.stepCount == null ||
                    (widget.stepCount ?? 1) <= 1) ...[
                  stepCircle(icon: Icons.menu, isActive: true, stepNumber: 0),
                  context.emptySizedWidthBoxLow,
                ],
                VCProductText(
                  text: widget.headlineText.toString(),
                  type: TypographyType.bodyMedium14,
                  textAlign: TextAlign.start,
                ),
              ],
            ),
          ],
          // Display steps if step count is provided and greater than 1
          if (widget.stepCount != null && widget.stepCount! > 1) ...[
            context.emptySizedHeightBoxSemiLow,
            // Stack to overlap step circles and dividers
            Stack(
              alignment: AlignmentDirectional.center,
              children: [
                // Display dividers between steps
                Row(
                  children: List.generate(
                      widget.stepCount! > 6 ? 6 : widget.stepCount!, (i) {
                    return divider(dividerWidth,
                        color: (i + 1) <= (widget.activeStep ?? 0)
                            ? activeStepColor
                            : null);
                  }),
                ),
                // Display step circles
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Display an icon for the first step
                      stepCircle(
                          icon: Icons.menu, isActive: true, stepNumber: 0),
                      ...List.generate(
                          widget.stepCount! > 6 ? 6 : widget.stepCount!, (i) {
                        if (i >= 5 && widget.stepCount! > 6) {
                          return stackedStepCircle(stackedStepCount);
                        }

                        return stepCircle(
                            stepNumber: i + 1,
                            isActive: i + 1 <= (widget.activeStep ?? 0));
                      }),
                    ]),
              ],
            ),
          ],
          // Display additional information text if provided
          if (widget.infoText != null) ...[
            context.emptySizedHeightBoxSemiLow,
            VCProductText(
              text: widget.infoText.toString(),
              type: TypographyType.smallText,
              textAlign: TextAlign.start,
            ),
          ],
        ],
      );
    });
  }

  /// Constructs a divider widget.
  /// Parameters:
  /// - width: The width of the divider.
  /// - color: The color of the divider. Defaults to inactive step border color.
  SizedBox divider(double width, {Color? color}) {
    return SizedBox(
      width: width,
      height: 2.8,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: color ?? inactiveStepBorderColor,
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }

  /// Constructs a step circle widget.
  /// Parameters:
  /// - isActive: Indicates whether the step is active.
  /// - icon: The icon to display within the step circle.
  /// - stepNumber: The number displayed inside the step circle.
  Container stepCircle(
      {bool? isActive, IconData? icon, required int stepNumber}) {
    return Container(
      height: stepBoxSize,
      width: stepBoxSize,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
              color: (isActive == true)
                  ? activeStepBorderColor
                  : inactiveStepBorderColor,
              width: 2),
          color: (isActive == true && stepNumber != 0)
              ? activeStepColor
              : inactiveStepColor),
      child: Center(
        child: icon != null
            ? Icon(
                icon,
                size: 15,
                color: widget.activeStepBorderColor ??
                    VCProductColors.instance.activeTileColor,
              )
            : VCProductText(
                text: stepNumber.toString(),
                type: TypographyType.btnSmall,
                textColor: (isActive == true)
                    ? widget.activeStepTextColor ??
                        VCProductColors.instance.white
                    : widget.inactiveStepTextColor,
              ),
      ),
    );
  }

  /// Constructs a stacked step circle widget.
  /// Parameters:
  /// - stackedStepCount: The number of stacked steps.
  SizedBox stackedStepCircle(int stackedStepCount) {
    return SizedBox(
      width: stepBoxSize + (stepBoxSize / 4) * (stackedStepCount - 1),
      child: Stack(
        alignment: AlignmentDirectional.topEnd,
        children: [
          ...List.generate(stackedStepCount, (i) {
            if (i < stackedStepCount - 1) {
              return Positioned(
                left: (stepBoxSize / 4) * i,
                child: Container(
                  height: stepBoxSize,
                  width: stepBoxSize,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border:
                          Border.all(color: inactiveStepBorderColor, width: 2),
                      color: inactiveStepColor),
                ),
              );
            }
            return stepCircle(stepNumber: widget.stepCount!, isActive: false);
          }),
        ],
      ),
    );
  }
}
