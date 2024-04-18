// ignore_for_file: must_be_immutable, constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vc_product_network/vc_product_network.dart';
import 'package:vc_product_widgets/components/base/base_component.dart';
import 'package:vc_product_widgets/components/text/typography_type.dart';
import 'package:vc_product_widgets/components/text/vc_product_text.dart';

import '../../utils/color_constant.dart';

class VCBaseTextField extends BaseComponent {
  /// The label text displayed above the input field.
  String? label;

  /// Helper text that appears below the input field to provide additional guidance.
  String? helperText;

  /// Flag indicating whether the login validation view is enabled. default [false]
  bool? loginValidationViewEnabled;

  /// Flag indicating whether the input field should have an underline. default [false]
  bool? hasUnderline;

  /// Error text displayed below the input field when validation fails.
  String? errorText;

  /// Hint text displayed inside the input field when it's empty.
  String? hintText;

  /// Flag to determine whether the input field should display its content in an obscured manner. default [false]
  bool isSecure;

  /// Flag to obscure the text input by default (useful for password fields). default [true]
  bool obscureText = true;

  /// Maximum allowed length for the input value.
  int maxLength;

  /// A brief hint that is displayed inside the input field when it's empty.
  String? hint;

  /// The type of keyboard to display for input.
  TextInputType? inputType;

  /// The initial value to be set in the input field.  default [""]
  String? initValue;

  /// Widget to be displayed as a suffixIcon at the end of the input field.
  Widget? suffixIcon;

  /// Widget to be displayed as a suffix at the end of the input field.
  Widget? suffix;

  /// Widget to be displayed as a widget at the bottom of the input field.
  Widget? bottomWidget;

  /// Widget to be displayed as a prefix at the beginning of the input field.
  Widget? prefix;

  /// The alignment of the text within the input field.
  TextAlign? textAlign;

  /// The style of the text within the input field.
  TextStyle? style;

  /// The controller for this text field, which can be used to control and observe the input text.
  TextEditingController? controller;

  /// A function that validates the input value and returns an error message if invalid.
  String? Function(String? value)? validator;

  /// A callback that is called when the input value changes.
  Function(String)? onChanged;

  /// A callback that is called when the form is saved.
  Function(String)? onSaved;

  /// A callback that is called when the input field is tapped.
  Function()? onTap;

  /// A list of input formatters that allow custom formatting of the input value.
  List<TextInputFormatter>? inputFormatters;

  /// Flag indicating whether the input field is deletable or not. default [false]
  bool deletable;

  /// Flag indicating whether the input field is enabled or disabled. default [true]
  bool enabled;

  /// Flag indicating whether the character counter should be displayed. default [false]
  bool counterEnabled;

  /// Flag indicating whether the input field should automatically receive focus. default [false]
  bool autoFocus;

  /// Flag indicating whether the input field should have a dense appearance. default [false]
  bool isDense;

  /// Flag indicating whether the input field is read-only or editable. default [false]
  bool readOnly;

  /// The background color of the input field. default [Colors.white]
  Color? backgroundColor;

  /// The backgroundOpacity of the input field. default [1]
  double? backgroundOpacity;

  /// The border color of the input field
  Color? borderColor;

  /// The background color of the input field. default [Colors.white]
  Color? borderSize;

  /// The fontSize of the input field
  double? fontSize;

  /// The fontHeight of the input field
  double? fontHeight;

  /// The background color of the input field. default [Colors.white]
  Color? inputColor;

  /// The background color of the input field. default [Colors.white]
  Color? labelColor;

  /// The background color of the input field. default [Colors.white]
  Color? errorColor;

  /// The padding of the input field container
  EdgeInsets? containerPadding;

  /// Counter to be displayed as a suffix at the end of the input field.
  bool suffixCounterEnabled;

  bool hasBorderTop;

  bool hasBorderBottom;

  bool expanded;

  bool showErrorMessage = true;

  static const int MAX_LENGTH = 1000;

  VCBaseTextField(
      {Key? key,
      this.label,
      this.hint,
      this.helperText,
      this.errorText,
      this.hintText,
      this.inputType,
      this.initValue = "",
      this.isSecure = false,
      this.obscureText = true,
      this.textAlign,
      this.style,
      this.controller,
      this.validator,
      this.maxLength = MAX_LENGTH,
      this.onChanged,
      this.onSaved,
      this.onTap,
      this.inputFormatters,
      this.suffixIcon,
      this.suffix,
      this.prefix,
      this.deletable = false,
      this.enabled = true,
      this.counterEnabled = false,
      this.autoFocus = false,
      this.isDense = false,
      this.readOnly = false,
      this.backgroundColor,
      this.backgroundOpacity,
      this.borderColor,
      this.borderSize,
      this.fontSize,
      this.fontHeight,
      this.containerPadding,
      this.inputColor,
      this.labelColor,
      super.id,
      super.showError,
      super.checkOthers,
      super.willValidate,
      this.hasBorderBottom = true,
      this.hasBorderTop = true,
      this.suffixCounterEnabled = false,
      this.errorColor,
      this.showErrorMessage = true,
      this.loginValidationViewEnabled = false,
      this.hasUnderline = false,
      this.expanded = false})
      : super(key: key);

  @override
  State<VCBaseTextField> createState() => VCBaseTextFieldState();
}

class VCBaseTextFieldState<T extends VCBaseTextField> extends State<T> {
  late ThemeData theme;

  final FocusNode _focusNode = FocusNode();
  late TextEditingController? _controller;

  Color _borderColor = Colors.orange;
  double _borderSize = 1;

  String? _validatorErrorText;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();

    if (widget.controller == null) {
      _controller?.text = widget.initValue ?? "";
    }

    _controller?.addListener(() {});
    _focusNode.addListener(() {
      setState(() {
        _borderSize = _focusNode.hasFocus ? 2 : 1;
      });
    });
  }

  @override
  void didChangeDependencies() {
    theme = Theme.of(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    widget.inputColor =
        widget.inputColor ?? VCProductColors.instance.labelColor;

    widget.labelColor =
        widget.labelColor ?? VCProductColors.instance.labelColor;
    var style = widget.style ??
        TextStyle(
            fontWeight: FontWeight.w600,
            fontFamily: "Inter",
            fontSize: widget.fontSize,
            height: widget.fontHeight,
            color: widget.inputColor);
    return ValidatorBuilder(
      builder: (_) {
        if (widget.id != null && widget.showError) {
          _validatorErrorText = ValidatorService.getErrorMessage(widget.id!);
        }
        return FormField(validator: (String? value) {
          return widget.validator?.call(_controller?.text);
        }, builder: (formFieldState) {
          _borderColor = formFieldState.hasError ||
                  widget.errorText != null ||
                  _validatorErrorText != null
              ? widget.errorColor ?? VCProductColors.instance.statusWeakColor
              : widget.borderColor ??
                  VCProductColors.instance
                      .widgetBorderColor; //Theme.of(context).primaryColor;
          return widget.loginValidationViewEnabled!
              ? Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    buildTextField(formFieldState, context, style),
                    if (widget.showErrorMessage)
                      _getLoginErrorIcon(formFieldState)
                  ],
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (widget.expanded) ...[
                      Expanded(
                        child: buildTextField(formFieldState, context, style),
                      ),
                    ] else ...[
                      buildTextField(formFieldState, context, style)
                    ],
                    if (widget.showErrorMessage) _getErrorIcon(formFieldState)
                  ],
                );
        });
      },
    );
  }

  Widget buildTextField(FormFieldState<dynamic> formFieldState,
      BuildContext context, TextStyle style) {
    return Column(
      children: [
        Stack(
          children: [
            Positioned(
              top: 0,
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: _borderColor, width: _borderSize),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(widget.hasBorderTop ? 8 : 0),
                    topRight: Radius.circular(widget.hasBorderTop ? 8 : 0),
                    bottomLeft: Radius.circular(widget.hasBorderBottom ? 8 : 0),
                    bottomRight:
                        Radius.circular(widget.hasBorderBottom ? 8 : 0),
                  ),
                  color: (widget.enabled
                          ? widget.backgroundColor ?? Colors.white
                          : VCProductColors
                              .instance.disabledWidgetBackgroundColor)
                      .withOpacity(widget.backgroundOpacity ?? 1),
                ),
              ),
            ),
            Padding(
              padding: widget.containerPadding ??
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              child: Column(
                children: [
                  if (widget.textAlign == TextAlign.center &&
                      widget.label != null) ...[
                    Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: Text(
                        widget.label ?? "",
                        style: theme.textTheme.bodyLarge?.apply(
                            color: formFieldState.hasError ||
                                    widget.errorText != null ||
                                    _validatorErrorText != null
                                ? widget.errorColor ??
                                    VCProductColors.instance.statusWeakColor
                                : widget.labelColor),
                      ),
                    ),
                  ],
                  Stack(
                    children: [
                      TextFormField(
                        obscuringCharacter: "●",
                        readOnly: widget.readOnly,
                        onTap: widget.onTap,
                        enabled: widget.enabled,
                        focusNode: _focusNode,
                        autofocus: widget.autoFocus,
                        controller: _controller,
                        autocorrect: false,
                        obscureText:
                            (widget.isSecure) ? widget.obscureText : false,
                        keyboardType: widget.inputType,
                        style: (widget.style ?? style).apply(
                            color: formFieldState.hasError ||
                                    widget.errorText != null ||
                                    _validatorErrorText != null
                                ? widget.errorColor ??
                                    VCProductColors.instance.statusWeakColor
                                : null),
                        maxLength: widget.maxLength,
                        textAlign: widget.textAlign ?? TextAlign.start,
                        minLines: (widget.inputType == TextInputType.multiline)
                            ? null
                            : 1,
                        maxLines: (widget.inputType == TextInputType.multiline)
                            ? null
                            : 1,
                        inputFormatters: widget.inputFormatters,
                        onChanged: (text) {
                          _controller?.text.length;
                          widget.onChanged?.call(text);
                          if (widget.id != null && widget.willValidate) {
                            ValidatorService.validate<String>(
                                componentId: widget.id!,
                                value: text,
                                showError: widget.showError,
                                checkOthers: widget.checkOthers);
                          }
                        },
                        decoration: InputDecoration(
                          isDense: widget.isDense,
                          errorStyle: const TextStyle(
                              height: 0,
                              color: Colors.transparent,
                              fontSize: 0,
                              wordSpacing: 0,
                              letterSpacing: 0,
                              decorationThickness: 0),
                          counterText: widget.counterEnabled ? null : "",
                          hintStyle: (widget.style ?? style).apply(
                              color: formFieldState.hasError ||
                                      widget.errorText != null ||
                                      _validatorErrorText != null
                                  ? widget.errorColor ??
                                      VCProductColors.instance.statusWeakColor
                                  : null),
                          labelText: (widget.textAlign == TextAlign.start ||
                                  widget.textAlign == null)
                              ? widget.label
                              : null,
                          labelStyle: theme.textTheme.bodyLarge?.apply(
                              color: formFieldState.hasError ||
                                      widget.errorText != null ||
                                      _validatorErrorText != null
                                  ? widget.errorColor ??
                                      VCProductColors.instance.statusWeakColor
                                  : widget.labelColor),
                          hintText: widget.hintText,
                          helperText: widget.helperText,
                          suffixIcon: widget.suffixCounterEnabled
                              ? Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                      VCProductText(
                                        text:
                                            "${_controller!.text.length}/${widget.maxLength}",
                                        type: TypographyType.bodyRegular14,
                                      )
                                    ])
                              : widget.suffix == null
                                  ? (widget.deletable &&
                                          _focusNode.hasFocus &&
                                          _controller != null &&
                                          _controller!.text.isNotEmpty)
                                      ? getDeleteIcon(formFieldState)
                                      : getSuffixIcon(formFieldState)
                                  : Wrap(
                                      alignment: WrapAlignment.end,
                                      crossAxisAlignment:
                                          WrapCrossAlignment.center,
                                      children: [
                                        widget.suffix!,
                                        SizedBox(
                                          child: (widget.deletable &&
                                                  _focusNode.hasFocus &&
                                                  _controller != null &&
                                                  _controller!.text.isNotEmpty)
                                              ? getDeleteIcon(formFieldState)
                                              : getSuffixIcon(formFieldState),
                                        )
                                      ],
                                    ),
                          prefixIcon: widget.prefix,
                          border: InputBorder.none,
                        ),
                      ),
                      if (widget.bottomWidget != null) widget.bottomWidget!,
                    ],
                  )
                ],
              ),
            ),
            if (widget.textAlign == TextAlign.end) ...[
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                child: Text(
                  widget.label ?? "",
                  style: theme.textTheme.bodyLarge?.apply(
                      color: formFieldState.hasError ||
                              widget.errorText != null ||
                              _validatorErrorText != null
                          ? widget.errorColor ??
                              VCProductColors.instance.statusWeakColor
                          : widget.labelColor),
                ),
              ),
            ],
          ],
        ),
        formFieldState.hasError ||
                widget.errorText != null ||
                _validatorErrorText != null
            ? const SizedBox.shrink()
            : widget.hasUnderline!
                ? Container(
                    color: VCProductColors.instance.backgroundGray,
                    height: 0.5,
                  )
                : const SizedBox.shrink()
      ],
    );
  }

  Widget _getLoginErrorIcon(formFieldState) => (formFieldState.hasError ||
          (widget.errorText != null || _validatorErrorText != null))
      ? (_validatorErrorText ?? "").isNotEmpty ||
              (widget.errorText ?? "").isNotEmpty
          ? Container(
              decoration: BoxDecoration(
                color: VCProductColors.instance.statusWeakColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(8),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(3.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.error_outlined,
                        size: 16, color: VCProductColors.instance.white),
                    const SizedBox(
                      width: 4,
                    ),
                    Text(
                      formFieldState.errorText ??
                          widget.errorText ??
                          _validatorErrorText ??
                          "",
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(color: VCProductColors.instance.white),
                    )
                  ],
                ),
              ),
            )
          : const SizedBox.shrink()
      : const SizedBox.shrink();

  Widget _getErrorIcon(formFieldState) => (formFieldState.hasError ||
          (widget.errorText != null || _validatorErrorText != null))
      ? (_validatorErrorText ?? "").isNotEmpty ||
              (widget.errorText ?? "").isNotEmpty
          ? Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.error_outline,
                      size: 16,
                      color: VCProductColors.instance.errorWidgetColor),
                  const SizedBox(
                    width: 4,
                  ),
                  Expanded(
                    child: Text(
                      formFieldState.errorText ??
                          widget.errorText ??
                          _validatorErrorText ??
                          "",
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: widget.errorColor ??
                                VCProductColors.instance.statusWeakColor,
                          ),
                    ),
                  )
                ],
              ),
            )
          : const SizedBox.shrink()
      : const SizedBox.shrink();

  Widget? getSuffixIcon(formFieldState) {
    if (widget.loginValidationViewEnabled! &&
        (formFieldState.hasError ||
            widget.errorText != null ||
            _validatorErrorText != null)) {
      return const SizedBox.shrink();
    }
    return (widget.suffixIcon.runtimeType == Icon)
        ? Icon(
            (widget.suffixIcon as Icon).icon,
            color: formFieldState.hasError ||
                    widget.errorText != null ||
                    _validatorErrorText != null
                ? widget.errorColor ?? VCProductColors.instance.statusWeakColor
                : (widget.suffixIcon as Icon).color ??
                    Theme.of(context).primaryColor,
          )
        : widget.suffixIcon;
  }

  Widget? getDeleteIcon(formFieldState) {
    return IconButton(
      hoverColor: Colors.transparent,
      focusColor: Colors.transparent,
      splashColor: Colors.transparent,
      padding: EdgeInsets.zero,
      icon: Icon(
        Icons.close,
        color: formFieldState.hasError ||
                widget.errorText != null ||
                _validatorErrorText != null
            ? widget.errorColor ?? VCProductColors.instance.statusWeakColor
            : Theme.of(context).primaryColor,
      ),
      onPressed: () {
        setState(() {
          _controller?.clear();
        });
      },
    );
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }
}
