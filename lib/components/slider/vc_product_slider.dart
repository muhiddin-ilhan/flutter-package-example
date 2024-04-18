import 'package:flutter/material.dart';
import 'package:vc_product_widgets/utils/color_constant.dart';

class VCProductSlider extends StatefulWidget {
  /// The callback function of the slider.
  /// It returns [double] value as callback.
  /// It will be called when the user interacts with the slider.
  final Function(double) onChanged;

  /// The minimum value of the slider.
  /// It must be less than or equal to [max].
  /// If the [max] is equal to the [min], then the slider is disabled.
  final double min;

  /// The maximum value of the slider.
  /// It must be greater than or equal to [min].
  /// If the [max] is equal to the [min], then the slider is disabled.
  final double max;

  /// The initial value of the slider. (optional)
  /// If not specified, the [min] value will be used.
  final double? value;

  /// The number of discrete divisions.
  /// If null, the slider is continuous.
  /// It must be greater than 0.
  final int? divisions;

  /// The prefix text of the slider. (optional)
  /// It will be displayed before the value.
  final String? prefix;

  /// The suffix text of the slider. (optional)
  /// It will be displayed after the value.
  final String? suffix;

  /// A slider widget that allows users to select a value within a specified range.
  ///
  /// The [VCProductSlider] widget displays a slider with minimum and maximum values,
  /// and allows users to select a value by dragging the slider thumb. It also supports
  /// divisions, prefix, and suffix for displaying additional information.
  ///
  /// The [onChanged] callback is triggered when the slider value changes.
  ///
  /// Example usage:
  ///
  /// VCProductSlider(
  ///   min: 0,
  ///   max: 100,
  ///   initialValue: 50,
  ///   divisions: 5,
  ///   onChanged: (value) {
  ///     print('Selected value: $value');
  ///   },
  ///   prefix: '\$',
  ///   suffix: ' USD',
  /// )
  ///
  const VCProductSlider({
    super.key,
    required this.min,
    required this.max,
    this.value,
    this.divisions,
    required this.onChanged,
    this.prefix,
    this.suffix,
  });

  @override
  VCProductSliderState createState() => VCProductSliderState();
}

class VCProductSliderState extends State<VCProductSlider> {
  late double _sliderValue;
  bool isToolTipVisible = false;

  @override
  Widget build(BuildContext context) {
    if (widget.value == null) {
      _sliderValue = widget.min;
    } else {
      _sliderValue = widget.value!;
    }
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Column(
          children: [
            if (widget.divisions == null)
              const SizedBox(
                height: 18,
              ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  getTextWithPrefixAndSuffix(formatDouble(widget.min)),
                  style: TextStyle(
                    color: VCProductColors.instance.labelColor,
                  ),
                ),
                Text(
                  getTextWithPrefixAndSuffix(formatDouble(widget.max)),
                  style: TextStyle(
                    color: VCProductColors.instance.labelColor,
                  ),
                ),
              ],
            ),
            SliderTheme(
              data: SliderTheme.of(context).copyWith(
                trackShape: CustomTrackShape(),
                valueIndicatorColor: VCProductColors.instance.black,
                valueIndicatorShape:
                    const RectangularSliderValueIndicatorShape(),
                thumbColor: VCProductColors.instance.iconColor,
                thumbShape:
                    const RoundSliderThumbShape(enabledThumbRadius: 12.0),
                overlayColor: Colors.white,
                overlayShape: const RoundSliderOverlayShape(
                  overlayRadius: 20.0,
                ),
                inactiveTickMarkColor: Colors.transparent,
                activeTickMarkColor: Colors.transparent,
                inactiveTrackColor: VCProductColors.instance.grey,
                activeTrackColor: VCProductColors.instance.iconColor,
              ),
              child: Slider(
                label: getTextWithPrefixAndSuffix(formatDouble(_sliderValue)),
                value: _sliderValue,
                divisions: widget.divisions,
                min: widget.min,
                max: widget.max,
                onChanged: (newValue) {
                  _sliderValue = newValue;
                  widget.onChanged.call(newValue);
                },
                onChangeStart: (newValue) {
                  setState(() {
                    isToolTipVisible = true;
                  });
                },
                onChangeEnd: (newValue) {
                  setState(() {
                    isToolTipVisible = false;
                  });
                },
              ),
            ),
          ],
        ),
        widget.divisions == null
            ? isToolTipVisible
                ? Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(5)),
                      color: VCProductColors.instance.black,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 16.0, right: 16.0, top: 8.0, bottom: 8.0),
                      child: Text(
                        getTextWithPrefixAndSuffix(formatDouble(_sliderValue)),
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  )
                : const SizedBox.shrink()
            : const SizedBox.shrink(),
      ],
    );
  }

  /// Formats the [double] value to a [String] value.
  /// If the [double] value ends with '.0', then it will be removed.
  /// For example, 10.0 will be formatted as 10.
  String formatDouble(double value) {
    String formattedValue = value.toString();
    if (formattedValue.endsWith('.0')) {
      formattedValue = formattedValue.replaceAll('.0', '');
    }
    return formattedValue;
  }

  /// Returns the [String] value with the prefix and suffix.
  /// If the [prefix] or [suffix] is null, then it will not be added to the [String].
  /// For example, if the [prefix] is '₺' and the [suffix] is ' TL', then the [String] will be formatted as '₺10 TL'.
  String getTextWithPrefixAndSuffix(String formatDouble) {
    String text = formatDouble;
    if (widget.prefix != null) {
      text = widget.prefix! + text;
    }
    if (widget.suffix != null) {
      text = text + widget.suffix!;
    }
    return text;
  }
}

class CustomTrackShape extends RoundedRectSliderTrackShape {
  @override
  Rect getPreferredRect({
    required RenderBox parentBox,
    Offset offset = Offset.zero,
    required SliderThemeData sliderTheme,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    final trackHeight = sliderTheme.trackHeight;
    final trackLeft = offset.dx;
    final trackTop = offset.dy + (parentBox.size.height - trackHeight!) / 2;
    final trackWidth = parentBox.size.width;
    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
  }
}
