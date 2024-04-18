import 'dart:io';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:vc_product_network/vc_product_network.dart';
import 'package:vc_product_widgets/components/base/base_component.dart';
import 'package:vc_product_widgets/components/vc_product_components.dart';
import 'package:vc_product_widgets/utils/vc_icons.dart';
import '../../utils/color_constant.dart';
//import 'package:webview_flutter/webview_flutter.dart';
//import 'package:http/http.dart' as http;
//import 'dart:convert';

//@TODO :
// when form validate refresh captcha

// ignore: must_be_immutable
class VCProductCaptcha extends BaseComponent {
  /// The label text displayed above the input field.
  String? label;

  /// Helper text that appears below the input field to provide additional guidance.
  String? helperText;

  /// Error text displayed below the input field when validation fails.
  String? errorText;

  /// Hint text displayed inside the input field when it's empty.
  String? hintText;

  /// Maximum allowed length for the input value.
  int maxLength;

  /// A brief hint that is displayed inside the input field when it's empty.
  String? hint;

  /// The style of the text within the input field.
  TextStyle? style;

  /// The controller for this text field, which can be used to control and observe the input text.
  TextEditingController? controller;

  /// A function that validates the input value and returns an error message if invalid.
  String? Function(String? value)? validator;

  Function()? Function()? refresh;

  /// A callback that is called when the input value changes.
  Function(String)? onChanged;

  /// A callback that is called when the form is saved.
  Function(String)? onSaved;

  /// A callback that is called when the input field is tapped.
  Function()? onTap;

  /// The fontSize of the input field
  double? fontSize;

  /// The fontHeight of the input field
  double? fontHeight;

  /// Flag indicating whether the input field should automatically receive focus. default [false]
  bool autoFocus;

  /// Flag indicating whether the input field should have a dense appearance. default [false]
  bool isDense;

  /// Flag indicating whether the input field is read-only or editable. default [false]
  bool readOnly;

  /// The background color of the input field. default [Colors.white]
  Color? backgroundColor;

  /// The background color of the input field. default [Colors.white]
  Color? borderColor;

  /// The background color of the input field. default [Colors.white]
  Color? borderSize;

  /// The alignment of the text within the input field.
  TextAlign? textAlign;

  //Checks if captcha is disabled. Default value is false
  bool disabled = false;

  /// The color of the button used for certain actions, such as refreshing the captcha.
  Color? buttonColor;

  /// The opacity level when the widget is in a disabled state.
  double disableOpacity;

  /// The initial text value to be displayed in the captcha input field.
  String? initTextValue;

  double? backgroundOpacity;

  Color? inputColor;
  Color? labelColor;

  Color? errorColor;

  final String apiUrl;

  VCProductCaptcha({
    Key? key,
    required this.apiUrl,
    super.id,
    super.checkOthers,
    super.showError,
    super.willValidate,
    this.label = "Captcha",
    this.hint,
    this.helperText,
    this.labelColor,
    this.errorText,
    this.hintText,
    this.controller,
    this.validator,
    this.maxLength = 1000,
    this.onChanged,
    this.onSaved,
    this.onTap,
    this.style,
    this.textAlign,
    this.autoFocus = false,
    this.isDense = false,
    this.readOnly = false,
    this.backgroundColor,
    this.borderColor,
    this.borderSize,
    this.disabled = false,
    this.buttonColor,
    this.disableOpacity = 0.7,
    this.backgroundOpacity = 1,
    this.initTextValue = "",
    this.inputColor,
    this.fontSize,
    this.fontHeight,
    this.errorColor,
  }) : super(key: key);

  @override
  State<VCProductCaptcha> createState() => VCProductCaptchaState();
}

class VCProductCaptchaState<T extends VCProductCaptcha> extends State<T> {
  late ThemeData theme;
  String? validatorErrorText;

  final FocusNode _focusNode = FocusNode();
  late TextEditingController? _controller;

  //Holds the URL of captcha Image Path.
  String _url = "";
  File? imageFile;

  //WebViewController? webViewController;

  //private _reload: boolean;

  //Holds captcha key.
  final _captchaUrlPrefix =
      "Images/CaptchaImage.jpg?s=8A353800-2A4A-4436-A0EA-2E22C5249781&v=";

  Color _borderColor = Colors.orange;
  double _borderSize = 1;

  @override
  void initState() {
    super.initState();

    _controller = widget.controller ?? TextEditingController();
    _controller?.text = widget.initTextValue ?? "";

    _controller?.addListener(() {});
    _focusNode.addListener(() {
      setState(() {
        _borderSize = _focusNode.hasFocus ? 2 : 1;
      });
    });

    _refresh();
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
    var buttonColor =
        widget.buttonColor ?? VCProductColors.instance.activeTileColor;
    buttonColor = widget.disabled
        ? buttonColor.withOpacity(widget.disableOpacity)
        : buttonColor;

    var style = widget.style ??
        TextStyle(
            fontWeight: FontWeight.w600,
            fontFamily: "Inter",
            fontSize: widget.fontSize,
            height: widget.fontHeight,
            color: widget.inputColor);

    return ValidatorBuilder(
      builder: (state) {
        if (widget.id != null && widget.showError) {
          validatorErrorText = ValidatorService.getErrorMessage(widget.id!);
        }
        return FormField(validator: (String? value) {
          return widget.validator?.call(_controller?.text);
        }, builder: (formFieldState) {
          _borderColor = formFieldState.hasError ||
                  widget.errorText != null ||
                  validatorErrorText != null
              ? widget.errorColor ?? Theme.of(context).colorScheme.error
              : widget.borderColor ??
                  VCProductColors.instance
                      .widgetBorderColor; //Theme.of(context).primaryColor;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                        border:
                            Border.all(color: _borderColor, width: _borderSize),
                        borderRadius: BorderRadius.circular(8),
                        color: !widget.disabled
                            ? (widget.backgroundColor ?? Colors.white)
                                .withOpacity(widget.backgroundOpacity ?? 1)
                            : VCProductColors
                                .instance.disabledWidgetBackgroundColor
                                .withOpacity(widget.backgroundOpacity ?? 1),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    child: Column(
                      children: [
                        if (widget.textAlign == TextAlign.center &&
                            widget.label != null) ...[
                          Padding(
                            padding: const EdgeInsets.only(top: 16),
                            child: Text(
                              widget.label ?? "",
                              style: (widget.style ?? theme.textTheme.bodyLarge)
                                  ?.apply(
                                      color: formFieldState.hasError ||
                                              widget.errorText != null ||
                                              validatorErrorText != null
                                          ? widget.errorColor ??
                                              Theme.of(context)
                                                  .colorScheme
                                                  .error
                                          : null),
                            ),
                          ),
                        ],
                        TextFormField(
                          maxLines: 1,
                          readOnly: widget.readOnly,
                          onTap: widget.onTap,
                          enabled: !widget.disabled,
                          focusNode: _focusNode,
                          autofocus: widget.autoFocus,
                          controller: _controller,
                          autocorrect: false,
                          style: (widget.style ?? style)
                              ?.apply(
                                  color: formFieldState.hasError ||
                                          widget.errorText != null ||
                                          validatorErrorText != null
                                      ? widget.errorColor ??
                                          Theme.of(context).colorScheme.error
                                      : widget.inputColor),
                          maxLength: widget.maxLength,
                          textAlign: widget.textAlign ?? TextAlign.start,
                          onChanged: (text) {
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
                            counterText: "",
                            errorStyle: const TextStyle(
                                height: 0,
                                color: Colors.transparent,
                                fontSize: 0,
                                wordSpacing: 0,
                                letterSpacing: 0,
                                decorationThickness: 0),
                            hintStyle: (widget.style ??
                                    theme.textTheme.bodyLarge)
                                ?.apply(
                                    color: formFieldState.hasError ||
                                            widget.errorText != null ||
                                            validatorErrorText != null
                                        ? widget.errorColor ??
                                            Theme.of(context).colorScheme.error
                                        : null),
                            labelText: (widget.textAlign == TextAlign.start ||
                                    widget.textAlign == null)
                                ? widget.label
                                : null,
                            labelStyle: theme.textTheme.bodyLarge?.apply(
                                color: formFieldState.hasError ||
                                        widget.errorText != null ||
                                        validatorErrorText != null
                                    ? widget.errorColor ??
                                        Theme.of(context).colorScheme.error
                                    : widget.labelColor),
                            hintText: widget.hintText,
                            helperText: widget.helperText,
                            border: InputBorder.none,
                            suffixIcon: Wrap(
                              alignment: WrapAlignment.end,
                              crossAxisAlignment: WrapCrossAlignment.center,
                              children: [
                                if (imageFile != null) Image.file(imageFile!),
                                //if(webViewController != null) Container(width:93, height:37, child: WebViewWidget(controller: webViewController!)),
                                // Image.network(
                                //   this._url, // Captcha image URL
                                //   headers: {
                                //     "X-Requested-With": "XMLHttpRequest",
                                //     "UniqueKey":
                                //         HttpService.instance.uniqueKey ?? "",
                                //     'Content-Type': 'application/json',
                                //     "Accept": "*/*",
                                //     "Accept-Encoding": "gzip, deflate, br",
                                //     "Connection": "keep-alive",
                                //   },
                                // ),
//                            if(bodyBytes !=null)
// Image.memory(bodyBytes!),
                                const SizedBox(
                                  width: 10,
                                ),

                                ///given according to figma design
                                VCProductComponents.vcButton(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(8)),
                                    backgroundColor: buttonColor,
                                    onTap: () {
                                      _refresh();
                                    },
                                    child: VCIcons.ic_vector,
                                    width: 42,
                                    height: 42)
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (widget.textAlign == TextAlign.end) ...[
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 16),
                      child: Text(
                        widget.label ?? "",
                        style: theme.textTheme.bodyLarge?.apply(
                            color: formFieldState.hasError ||
                                    widget.errorText != null ||
                                    validatorErrorText != null
                                ? widget.errorColor ??
                                    Theme.of(context).colorScheme.error
                                : null),
                      ),
                    ),
                  ],
                ],
              ),
              _getErrorIcon(formFieldState)
            ],
          );
        });
      },
    );
  }

  Widget _getErrorIcon(formFieldState) => (formFieldState.hasError ||
          widget.errorText != null ||
          validatorErrorText != null)
      ? Padding(
          padding: const EdgeInsets.only(top: 4.0),
          child: Row(
            children: [
              Icon(Icons.error_outline,
                  size: 16,
                  color:
                      widget.errorColor ?? Theme.of(context).colorScheme.error),
              const SizedBox(
                width: 4,
              ),
              Text(
                formFieldState.errorText ??
                    widget.errorText ??
                    validatorErrorText ??
                    "",
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: widget.errorColor ??
                        Theme.of(context).colorScheme.error),
              )
            ],
          ),
        )
      : const SizedBox.shrink();

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  void _refresh() async {
    this._url = widget.apiUrl +
        _captchaUrlPrefix +
        DateFormat('yyyy-MM-ddTHH:mm:ssZ').format(DateTime.now());
    var newImageFile = await HttpService.instance.callAction(
        url: _url,
        config: HttpConfig(headers: {"Content-Type": "image/jpeg"}),
        method: "getImage");

    setState(() {
      imageFile = newImageFile;
    });
  }
}
