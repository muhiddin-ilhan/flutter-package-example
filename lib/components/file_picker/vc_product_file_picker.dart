// ignore_for_file: unused_element

import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vc_product_network/vc_product_network.dart';
import 'package:vc_product_widgets/components/base/base_component.dart';
import 'package:vc_product_widgets/utils/color_constant.dart';
import '../../helper/smooth_page_indicator/effects/worm_effect.dart';
import '../checkbox/vc_product_checkbox.dart';
import '../vc_product_components.dart';

enum SelectionMode { single, multiple }

class VCProductFilePicker extends BaseComponent {
  /// The validator function of the single type file picker.
  /// It returns two parameters [bool] and  [PickedFile]? as callback.

  final String? Function(bool, PickedFile?)? singleValidator;

  /// The validator function of the multiple type file picker.
  /// It returns two parameters [bool] and  [List<PickedFile?>]? as callback.
  final String? Function(bool, List<PickedFile?>)? multiValidator;

  /// The title of the file picker.
  /// It will be shown above the file picker.
  final String? title;

  /// The info text of the file picker.
  /// It will be shown below the file picker.
  final String infoText;

  /// The label of the file picker.
  final String label;

  /// The flag to enable or disable the checkbox.
  /// If it is true then the checkbox will be enabled otherwise disabled.
  final bool isCheckBoxEnabled;

  /// The callback function of the single type file picker.
  /// It returns [PickedFile]? as callback.
  /// It will be called when the file is selected, removed or checkbox is tapped.
  final Function(PickedFile?) onChanged;

  /// The callback function of the multiple type file picker.
  /// It returns [List<PickedFile?>] as callback.
  /// It will be called when the file is selected, removed or checkbox is tapped.
  final Function(List<PickedFile?>) onFilesChanged;

  /// The callback function of the single type checkbox.
  /// It returns [bool]? as callback.
  /// It will be called when the checkbox is tapped.
  final Function(bool?)? onCheckBoxTapped;

  /// The callback function of the multiple type file picker.
  /// It returns [List<bool>] as callback.
  /// It will be called when the checkbox is tapped.
  final Function(List<bool>)? onFilesCheckBoxTapped;

  /// The list of allowed extensions.
  /// It will be used to filter the files.
  final List<String> allowedExtensions;

  /// The preview widget of the file picker.
  /// It will be shown when the preview is opened.
  /// If it is not provided then the default preview (just image) will be shown.
  final Widget Function(String base64, File file)? previewWidget;

  /// The selection mode of the file picker.
  /// If single constructor is used then the selection mode will be single
  /// otherwise multiple.
  final SelectionMode selectionMode;

  /// The list of file names for multiple type file picker.
  /// It will be used to show the file names in the multiple type file picker.
  final List<String> fileNames;

  final Color? labelColor;
  final Color? infoTextColor;


  const VCProductFilePicker._(
      {Key? key,
      required this.allowedExtensions,
      required this.onChanged,
      this.previewWidget,
      required this.selectionMode,
      required this.fileNames,
      required this.onFilesChanged,
      this.title,
      this.labelColor,
      this.infoTextColor,
      required this.label,
      this.isCheckBoxEnabled = false,
      this.onCheckBoxTapped,
      this.onFilesCheckBoxTapped,
      this.singleValidator,
      this.multiValidator,
      super.id,
      super.checkOthers,
      super.showError,
      super.willValidate,
      required this.infoText})
      : super(key: key);

  // Factory constructors
  factory VCProductFilePicker.single({
    Key? key,

    /// The validator function of the single type file picker.
    /// It returns two parameters [bool] and  [PickedFile]? as callback.
    String? Function(bool, PickedFile?)? validator,

    /// The list of allowed extensions.
    /// It will be used to filter the files.
    required List<String> allowedExtensions,

    /// The info text of the file picker.
    /// It will be shown below the file picker.
    required final String infoText,

    /// The callback function of the single type checkbox.
    /// It returns [bool]? as callback.
    /// It will be called when the checkbox is tapped.
    final Function(bool?)? onCheckBoxTapped,

    /// The callback function of the single type file picker.
    /// It returns [PickedFile]? as callback.
    /// It will be called when the file is selected, removed or checkbox is tapped.
    required Function(PickedFile?) onChanged,

    /// The preview widget of the file picker.
    /// It will be shown when the preview is opened.
    /// If it is not provided then the default preview (just image) will be shown.
    Widget Function(String base64, File file)? previewWidget,

    /// The title of the file picker.
    /// It will be shown above the file picker.
    String? title,

    /// The label of the file picker.
    /// It will be shown below the file picker.
    required String label,

    /// The flag to enable or disable the checkbox.
    /// If it is true then the checkbox will be enabled otherwise disabled.
    bool isCheckBoxEnabled = false,

  final Color? labelColor,
  final Color? infoTextColor,
  }) =>
      VCProductFilePicker._(
        key: key,
        singleValidator: validator,
        allowedExtensions: allowedExtensions,
        onChanged: onChanged,
        previewWidget: previewWidget,
        selectionMode: SelectionMode.single,
        fileNames: const [],
        onFilesChanged: (value) {},
        title: title,
        label: label,
        infoTextColor: infoTextColor,
        labelColor: labelColor,
        isCheckBoxEnabled: isCheckBoxEnabled,
        onCheckBoxTapped: onCheckBoxTapped,
        infoText: infoText,
      );

  factory VCProductFilePicker.multiple({
    Key? key,

    /// The validator function of the multiple type file picker.
    /// It returns two parameters [bool] and  [List<PickedFile?>]? as callback.
    /// It will be called when the file is selected, removed or checkbox is tapped.
    String? Function(bool, List<PickedFile?>)? validator,

    /// The list of allowed extensions.
    /// It will be used to filter the files.
    required List<String> allowedExtensions,

    /// The callback function of the multiple type file picker.
    /// It returns [List<PickedFile?>] as callback.
    /// It will be called when the file is selected, removed or checkbox is tapped.
    required Function(List<PickedFile?>) onFilesChanged,

    /// The callback function of the multiple type file picker.
    /// It returns [List<bool>] as callback.
    /// It will be called when the checkbox is tapped.
    final Function(List<bool>)? onFilesCheckBoxTapped,

    /// The preview widget of the file picker.
    /// It will be shown when the preview is opened.
    /// If it is not provided then the default preview (just image) will be shown.
    Widget Function(String base64, File file)? previewWidget,

    /// The list of file names for multiple type file picker.
    /// It will be used to show the file names in the multiple type file picker.
    required List<String> fileNames,

    /// The title of the file picker.
    /// It will be shown above the file picker.
    String? title,

    /// The label of the file picker.
    /// It will be shown below the file picker.
    required String label,

    /// The flag to enable or disable the checkbox.
    /// If it is true then the checkbox will be enabled otherwise disabled.
    final bool isCheckBoxEnabled = false,

    /// The info text of the file picker.
    /// It will be shown below the file picker.
    required final String infoText,
  }) =>
      VCProductFilePicker._(
        key: key,
        multiValidator: validator,
        allowedExtensions: allowedExtensions,
        onChanged: (value) {},
        previewWidget: previewWidget,
        selectionMode: SelectionMode.multiple,
        fileNames: fileNames,
        onFilesChanged: onFilesChanged,
        title: title,
        label: label,
        isCheckBoxEnabled: isCheckBoxEnabled,
        onFilesCheckBoxTapped: onFilesCheckBoxTapped,
        infoText: infoText,
      );

  @override
  State<VCProductFilePicker> createState() => _VCProductFilePickerState();
}

class _VCProductFilePickerState extends State<VCProductFilePicker> {
  final Color disabledColor =
      VCProductColors.instance.disabledWidgetBackgroundColor;
  final Color defaultColor = VCProductColors.instance.defaultColor;
  final Color errorColor = VCProductColors.instance.errorWidgetColor;
  final Color borderColor = VCProductColors.instance.widgetBorderColor;
  final Color textColor = VCProductColors.instance.widgetTextColor;
  final Color iconColor = VCProductColors.instance.iconColor;

  final List<PickedFile?> _pickedFiles = [];

  PickedFile? _pickedFile;

  final List<bool> isFilesChecked = [];
  bool isChecked = false;

  bool isFileLoading = false;

  String? validatorErrorText;

  @override
  void initState() {
    super.initState();

    /// This is the place where the _pickedFiles list is initialized.
    /// The length of the _pickedFiles list is equal to the length of the fileNames list.
    /// The _pickedFiles list is used to store the picked files.
    /// The fileNames list is used to show the file names in the multiple type file picker.
    if (widget.selectionMode == SelectionMode.multiple) {
      for (int i = 0; i < widget.fileNames.length; i++) {
        _pickedFiles.add(null);
        if (widget.isCheckBoxEnabled) {
          isFilesChecked.add(false);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ValidatorBuilder(builder: (_) {
      if (widget.id != null && widget.showError) {
        validatorErrorText = ValidatorService.getErrorMessage(widget.id!);
      }
      return getFilePicker();
    });
  }

  /// This is the main widget of the file picker.
  /// It contains the header, picker area and error icon.
  /// The header contains the title and done icon.
  /// The picker area contains the picked files.
  /// The error icon is shown when the file picker is invalid.
  /// The file picker is invalid when the file is not selected and checkbox is not checked.
  Widget getFilePicker() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if(widget.title != null) getHeader(),
        FormField(
          validator: (String? value) {
            if (widget.selectionMode == SelectionMode.single) {
              return widget.singleValidator
                  ?.call(validateFilePicker(), _pickedFile);
            } else {
              return widget.multiValidator
                  ?.call(validateFilePicker(), _pickedFiles);
            }
          },
          builder: (formFieldState) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                getPickerArea(formFieldState),
                _getErrorWidget(formFieldState),
              ].map((Widget child) {
                return Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: child,
                );
              }).toList(),
            );
          },
        ),
      ]
          .map((Widget child) =>
              Padding(padding: const EdgeInsets.only(top: 8.0), child: child))
          .toList(),
    );
  }

  /// This is the error widget of the file picker.
  /// It is shown when the file picker is invalid.
  /// The file picker is invalid when the file is not selected and checkbox is not checked.
  Widget _getErrorWidget(FormFieldState formFieldState) {
    if (formFieldState.hasError || validatorErrorText != null) {
      return Padding(
        padding: const EdgeInsets.only(top: 4.0),
        child: Row(
          children: [
            Icon(Icons.error_outline, size: 16, color: errorColor),
            const SizedBox(
              width: 4,
            ),
            Text(
              formFieldState.errorText ?? validatorErrorText!,
              style: TextStyle(color: errorColor),
            )
          ],
        ),
      );
    } else {
      return FittedBox(
        fit: BoxFit.scaleDown,
        child: Text(widget.infoText, style: TextStyle(fontSize: 12, color: widget.infoTextColor)),
      );
    }
  }

  /// This is the picker area of the file picker.
  /// It is used to display border
  /// It gets the picked files from the getPickedFiles method.
  Widget getPickerArea(FormFieldState formFieldState) {
    return Container(
      decoration: BoxDecoration(
        color: defaultColor,
        border: Border.all(
          color: formFieldState.hasError || validatorErrorText != null
              ? errorColor
              : borderColor,
          width: formFieldState.hasError || validatorErrorText != null ? 2 : 1,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: getPickedFiles(formFieldState),
    );
  }

  /// This is the method to show the file picker bottom sheet.
  /// It is used to show the camera and file explorer options.
  void _showFilePickerBottomSheet(int? index) {
    late String title;
    if (widget.selectionMode == SelectionMode.single) {
      title = widget.title ?? "";
    } else {
      title = widget.fileNames[index!];
    }
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text("Open Camera"),
              onTap: () {
                Navigator.pop(context);
                _openImagePicker(title, index);
              },
            ),
            ListTile(
              leading: const Icon(Icons.image),
              title: const Text("Open Files"),
              onTap: () {
                Navigator.pop(context);
                _openFileExplorer(index);
              },
            ),
          ],
        );
      },
    );
  }

  /// This is the method to get the trailing icon of the file picker.
  /// It is used to show the preview icon or upload icon.
  /// If the file is selected then the preview icon will be shown otherwise upload icon will be shown.
  Widget getTrailingIcon(FormFieldState formFieldState) {
    if (widget.selectionMode == SelectionMode.multiple) {
      if (_pickedFiles.any((item) => item != null)) {
        return GestureDetector(
          onTap: () {
            _previewMultipleFile();
          },
          child: Icon(
            Icons.remove_red_eye_outlined,
            color: formFieldState.hasError || validatorErrorText != null
                ? errorColor
                : iconColor,
          ),
        );
      } else {
        return const SizedBox.shrink();
      }
    } else {
      if (_pickedFile != null) {
        return Icon(
          Icons.remove_red_eye_outlined,
          color: formFieldState.hasError || validatorErrorText != null
              ? errorColor
              : iconColor,
        );
      } else {
        return Icon(
          Icons.file_upload_outlined,
          color: formFieldState.hasError || validatorErrorText != null
              ? errorColor
              : iconColor,
        );
      }
    }
  }

  /// This is the method to upload the file.
  /// It is used to show the camera and file explorer options.
  /// If the file is image or video then the camera option will be shown otherwise file explorer option will be shown.
  void uploadFile(int? index) {
    if (widget.allowedExtensions.contains("jpg") ||
        widget.allowedExtensions.contains("png") ||
        widget.allowedExtensions.contains("jpeg") ||
        widget.allowedExtensions.contains("mp4")) {
      _showFilePickerBottomSheet(index);
    } else {
      _openFileExplorer(index);
    }
  }

  /// This is the method to open the image picker.
  /// It is used to open the camera and select the image or video.
  /// If the file is image then the image will be selected otherwise video will be selected.
  /// If the file is selected then the file will be renamed with the given name.
  /// The file name will be the given name with the extension of the file.
  /// The file will be stored in the device storage.
  /// If the selection mode is single The file will be stored in the [_pickedFile] variable otherwise it will be added to [_pickedFiles] list.
  /// The file will be converted to base64 string and assigned to [_pickedFile.base64] or [_pickedFiles[index].base64].
  /// The file will be assigned to [_pickedFile.file] or [_pickedFiles[index].file].
  /// The file name will be assigned to [_pickedFile.name] or [_pickedFiles[index].name].
  /// The file extension will be assigned to [_pickedFile.extension] or [_pickedFiles[index].extension].
  /// The file size will be assigned to [_pickedFile.size] or [_pickedFiles[index].size].
  /// The onChanged callback will be called with the [_pickedFile] variable.
  /// The onFilesChanged callback will be called with the [_pickedFiles] list.
  void _openImagePicker(String name, int? index) async {
    final picker = ImagePicker();
    final pickedFile = widget.allowedExtensions.contains("mp4")
        ? await picker.pickVideo(source: ImageSource.camera)
        : await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      File image = File(pickedFile.path);

      String fileName = name;

      String extension = image.path.split('.').last;

      var path = image.path;
      var lastSeparator = path.lastIndexOf(Platform.pathSeparator);
      var newPath = "${path.substring(0, lastSeparator + 1)}$fileName"
          ".$extension";
      image = await image.rename(newPath);

      int sizeInBytes = image.lengthSync();
      double sizeInMb = sizeInBytes / (1024 * 1024);

      List<int> imageBytes = await image.readAsBytes();

      String base64 = base64Encode(imageBytes);

      PickedFile currentPickedFile = PickedFile(
        file: image,
        name: image.path.split('/').last,
        base64: base64,
        extension: extension,
        size: sizeInMb,
      );

      if (index != null) {
        setState(() {
          _pickedFiles[index] = currentPickedFile;
        });
        widget.onFilesChanged.call(_pickedFiles);
      } else {
        setState(() {
          _pickedFile = currentPickedFile;
        });
        widget.onChanged.call(_pickedFile);
      }
      if (widget.id != null && widget.willValidate) {
        ValidatorService.validate(
            componentId: widget.id!,
            value: _pickedFile,
            showError: widget.showError,
            checkOthers: widget.checkOthers);
      }
    }
  }

  /// This is the method to open the file explorer.
  /// It is used to select the file.
  /// If the file is selected then the file will be renamed with the given name.
  /// The file name will be the given name with the extension of the file.
  /// The file will be stored in the device storage.
  /// If the selection mode is single The file will be stored in the [_pickedFile] variable otherwise it will be added to [_pickedFiles] list.
  /// The file will be converted to base64 string and assigned to [_pickedFile.base64] or [_pickedFiles[index].base64].
  /// The file will be assigned to [_pickedFile.file] or [_pickedFiles[index].file].
  /// The file name will be assigned to [_pickedFile.name] or [_pickedFiles[index].name].
  /// The file extension will be assigned to [_pickedFile.extension] or [_pickedFiles[index].extension].
  /// The file size will be assigned to [_pickedFile.size] or [_pickedFiles[index].size].
  /// The onChanged callback will be called with the [_pickedFile] variable.
  /// The onFilesChanged callback will be called with the [_pickedFiles] list.
  void _openFileExplorer(int? index) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      allowedExtensions: widget.allowedExtensions,
      type: FileType.custom,
      onFileLoading: (status) {
        if (status.index == 0) {
          setState(() {
            isFileLoading = true;
          });
        } else {
          setState(() {
            isFileLoading = false;
          });
        }
      },
    );

    if (result != null) {
      if (result.files.isNotEmpty) {
        String path = result.files.single.path!;
        File file = File(path);

        int sizeInBytes = file.lengthSync();
        double sizeInMb = sizeInBytes / (1024 * 1024);

        String name = file.uri.pathSegments.last;
        String extension = name.split('.').last;
        List<int> bytes = file.readAsBytesSync();
        String base64 = base64Encode(bytes);

        PickedFile currentPickedFile = PickedFile(
          file: file,
          name: name,
          base64: base64,
          extension: extension,
          size: sizeInMb,
        );

        if (index != null) {
          setState(() {
            _pickedFiles[index] = currentPickedFile;
          });
          widget.onFilesChanged.call(_pickedFiles);
        } else {
          setState(() {
            _pickedFile = currentPickedFile;
          });
          widget.onChanged.call(_pickedFile);
        }
        if (widget.id != null && widget.willValidate) {
          ValidatorService.validate(
              componentId: widget.id!,
              value: _pickedFile,
              showError: widget.showError,
              checkOthers: widget.checkOthers);
        }
      }
    }
  }

  /// This is the method to check the selection mode.
  /// It is used to check the selection mode of the file picker.
  Widget getPickedFiles(FormFieldState formFieldState) {
    if (widget.selectionMode == SelectionMode.single) {
      return getSingleFile(formFieldState);
    } else {
      return getMultipleFiles(formFieldState);
    }
  }

  /// This widget is shown when selection mode is multiple
  /// It is used to show the multiple selected files.
  /// If the file is selected then the file name will be shown otherwise the label will be shown.
  /// If the file is selected then the delete icon will be shown otherwise the upload icon will be shown.
  Widget getMultipleFiles(FormFieldState formFieldState) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
          dense: true,
          trailing: getTrailingIcon(formFieldState),
          title: Text(
            widget.label,
            style: TextStyle(
              color: formFieldState.hasError || validatorErrorText != null
                  ? errorColor
                  : widget.labelColor ?? textColor,
            ),
          ),
        ),
        if (widget.fileNames.isNotEmpty)
          Flexible(
            fit: FlexFit.loose,
            child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: widget.fileNames.length,
              itemBuilder: (BuildContext context, int index) {
                if (_pickedFiles[index] != null) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: disabledColor,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: ListTile(
                        dense: true,
                        title: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(_pickedFiles[index]!.name,
                              style: TextStyle(
                                  color: formFieldState.hasError ||
                                          validatorErrorText != null
                                      ? errorColor
                                      : textColor)),
                        ),
                        trailing: GestureDetector(
                          onTap: () {
                            _deleteMultipleFile(index);
                          },
                          child: const Icon(
                            Icons.cancel,
                            color: Colors.grey,
                            size: 16,
                          ),
                        ),
                      ),
                    ),
                  );
                } else {
                  return Column(
                    children: [
                      ListTile(
                        // dense: true,
                        trailing: Icon(
                          Icons.file_upload_outlined,
                          color: formFieldState.hasError ||
                                  validatorErrorText != null
                              ? errorColor
                              : iconColor,
                        ),
                        title: Text(
                          widget.fileNames[index],
                          style: TextStyle(
                            color: formFieldState.hasError ||
                                    validatorErrorText != null
                                ? errorColor
                                : textColor,
                          ),
                        ),
                        onTap: () {
                          uploadFile(index);
                        },
                      ),
                      widget.isCheckBoxEnabled
                          ? Padding(
                              padding:
                                  const EdgeInsets.only(bottom: 8.0, left: 16),
                              child: VCProductCheckBox(
                                text: "I will provide later",
                                onChanged: (value) {
                                  setState(() {
                                    isFilesChecked[index] = value!;
                                    widget.onFilesChanged.call(_pickedFiles);
                                    widget.onFilesCheckBoxTapped
                                        ?.call(isFilesChecked);
                                  });
                                  if (widget.id != null &&
                                      widget.willValidate) {
                                    ValidatorService.validate(
                                        componentId: widget.id!,
                                        value: _pickedFiles,
                                        showError: widget.showError,
                                        checkOthers: widget.checkOthers);
                                  }
                                },
                              ),
                            )
                          : const SizedBox.shrink(),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Divider(
                          color: borderColor,
                          thickness: 1,
                        ),
                      )
                    ],
                  );
                }
              },
            ),
          ),
      ],
    );
  }

  /// This widget is shown when selection mode is single
  /// It is used to show the selected file.
  /// If the file is selected then the file name will be shown otherwise the label will be shown.
  /// If the file is selected then the delete icon will be shown otherwise the upload icon will be shown.
  /// If the checkbox is enabled then the checkbox will be shown otherwise it will not be shown.
  getSingleFile(FormFieldState formFieldState) {
    return Column(
      children: [
        ListTile(
          dense: _pickedFile != null ? true : false,
          trailing: getTrailingIcon(formFieldState),
          title: Text(
            widget.label,
            style: TextStyle(
              color: formFieldState.hasError || validatorErrorText != null
                  ? errorColor
                  : widget.labelColor ?? textColor,
            ),
          ),
          onTap: () {
            if (_pickedFile != null) {
              _previewSingleFile();
            } else {
              uploadFile(null);
            }
          },
        ),
        _pickedFile != null
            ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: disabledColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: ListTile(
                    dense: true,
                    title: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        _pickedFile!.name,
                        style: TextStyle(
                            color: formFieldState.hasError ||
                                    validatorErrorText != null
                                ? errorColor
                                : textColor),
                      ),
                    ),
                    trailing: GestureDetector(
                      onTap: () {
                        _deleteSingleFile();
                      },
                      child: const Icon(
                        Icons.cancel,
                        color: Colors.grey,
                        size: 16,
                      ),
                    ),
                  ),
                ),
              )
            : widget.isCheckBoxEnabled
                ? Padding(
                    padding: const EdgeInsets.only(bottom: 8.0, left: 16),
                    child: VCProductCheckBox(
                      text: "I will provide later",
                      onChanged: (value) {
                        setState(() {
                          widget.onChanged.call(null);
                          widget.onCheckBoxTapped?.call(value);
                          isChecked = value!;
                        });
                      },
                    ),
                  )
                : const SizedBox.shrink(),
      ],
    );
  }

  /// This is the method to remove the file of single type file picker.
  /// It is used to remove the file from the [_pickedFile] variable.
  /// The onChanged callback will be called with the [_pickedFile] variable.
  void _deleteSingleFile() {
    if (_pickedFile!.file.existsSync()) {
      _pickedFile!.file.deleteSync();
    }
    setState(() {
      _pickedFile = null;
    });
    widget.onChanged.call(null);
  }

  /// This is the method to remove the file at given index of multiple type file picker.
  /// It is used to remove the file from the [_pickedFiles] list.
  /// The onFilesChanged callback will be called with the [_pickedFiles] list.
  void _deleteMultipleFile(int index) {
    if (index < _pickedFiles.length) {
      if (_pickedFiles[index]!.file.existsSync()) {
        _pickedFiles[index]!.file.deleteSync();
      }
      setState(() {
        _pickedFiles[index] = null;
      });
    }
    widget.onFilesChanged(_pickedFiles);
  }

  /// This widget is used to add header of the file picker.
  /// It contains the title and done icon.
  /// The title is the title of the file picker.
  /// The done icon is shown when the file is selected or checkbox is checked.
  Widget getHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          widget.title ?? "",
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        getDoneIcon(),
      ],
    );
  }

  /// This widget is used to get the done icon.
  /// It is shown when the file is selected or checkbox is checked.
  /// If the selection mode is single then the done icon will be shown when the file is selected.
  /// If the selection mode is multiple then the done icon will be shown when all the files are selected or remainings are checked.
  getDoneIcon() {
    if (widget.selectionMode == SelectionMode.single) {
      if (_pickedFile != null || isChecked) {
        return doneIcon();
      } else {
        return const SizedBox.shrink();
      }
    } else {
      if (widget.isCheckBoxEnabled) {
        List<int> nullIndices = [];
        List<bool> checkList = [];

        for (int i = 0; i < _pickedFiles.length; i++) {
          if (_pickedFiles[i] == null) {
            nullIndices.add(i);
          }
        }

        if (nullIndices.isEmpty) {
          return doneIcon();
        } else {
          for (int index in nullIndices) {
            checkList.add(isFilesChecked[index]);
          }
          if (checkList.contains(false)) {
            return const SizedBox.shrink();
          } else {
            return doneIcon();
          }
        }
      } else {
        if (!_pickedFiles.contains(null)) {
          return doneIcon();
        } else {
          return const SizedBox.shrink();
        }
      }
    }
  }

  /// This widget is used to get the done icon.
  doneIcon() {
    return Text(
      String.fromCharCode(Icons.done.codePoint),
      style: TextStyle(
        inherit: false,
        color: iconColor,
        fontSize: 24.0,
        fontWeight: FontWeight.bold,
        fontFamily: Icons.done.fontFamily,
        package: Icons.done.fontPackage,
      ),
    );
  }

  /// This is the method to open the multiple preview pop up.
  /// It is used to show the preview of the selected files.
  /// The preview widget is shown when the preview is opened.
  /// If the [widget.previewWidget] is not provided then the default preview (just image) will be shown.
  /// The preview widget is shown in the carousel.
  /// The carousel is used to show the multiple files.
  void _previewMultipleFile() {
    int index = 0;
    PickedFile? file;

    file = _pickedFiles[index];

    showGeneralDialog(
      barrierLabel: "previewMultipleFile",
      context: context,
      barrierDismissible: true,
      transitionDuration: const Duration(milliseconds: 400),
      pageBuilder: (context, __, ___) {
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter modalSetState) {
          return Scaffold(
            backgroundColor: Colors.black.withOpacity(0.9),
            appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: Colors.black.withOpacity(0.9),
              title: Text(
                file?.name ?? "",
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600),
              ),
              actions: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.cancel,
                    color: Colors.white,
                  ),
                )
              ],
            ),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: widget.previewWidget != null
                            ? file != null
                                ? widget.previewWidget!(
                                    file!.base64, file!.file)
                                : getNoFileSelectedWidget()
                            : VCProductComponents.vcCarousel<PickedFile?>(
                                indicatorEffect: const WormEffect(
                                  activeDotColor: Colors.white,
                                  dotColor: Colors.grey,
                                  type: WormType.thin,
                                  dotHeight: 10,
                                  dotWidth: 10,
                                ),
                                aspectRatio: 4 / 3,
                                onPageChange: (pageIndex) {
                                  modalSetState(() {
                                    file = _pickedFiles[pageIndex];
                                    index = pageIndex;
                                  });
                                },
                                viewportFraction: 1,
                                items: _pickedFiles,
                                itemBuilder: (item) => item != null
                                    ? SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: Image.file(
                                          item.file,
                                          errorBuilder: (BuildContext context,
                                              Object exception,
                                              StackTrace? stackTrace) {
                                            return getNoPreviewWidget(
                                                file?.extension ?? "");
                                          },
                                        ),
                                      )
                                    : getNoFileSelectedWidget(),
                              ),
                      ),
                    ),
                  ),
                  file != null
                      ? getDeleteButton(index)
                      : getAddButton(index, modalSetState),
                ],
              ),
            ),
          );
        });
      },
    );
  }

  /// This is the method to open the single preview pop up.
  /// It is used to show the preview of the selected file.
  /// The preview widget is shown when the preview is opened.
  /// If the [widget.previewWidget] is not provided then the default preview (just image) will be shown.
  /// The preview widget is shown in the carousel.
  void _previewSingleFile() async {
    PickedFile? file;

    file = _pickedFile;

    showGeneralDialog(
      barrierLabel: "previewSingleFile",
      context: context,
      barrierDismissible: true,
      transitionDuration: const Duration(milliseconds: 400),
      pageBuilder: (context, __, ___) {
        return Scaffold(
          backgroundColor: Colors.black.withOpacity(0.9),
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.black.withOpacity(0.9),
            title: Text(
              file!.name,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600),
            ),
            actions: [
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.cancel,
                  color: Colors.white,
                ),
              )
            ],
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: widget.previewWidget != null
                        ? widget.previewWidget!(file.base64, file.file)
                        : SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: Image.file(file.file, errorBuilder:
                                (BuildContext context, Object exception,
                                    StackTrace? stackTrace) {
                              return getNoPreviewWidget(file!.extension);
                            })),
                  ),
                ),
                IconButton(
                    onPressed: () {
                      _deleteSingleFile();
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.white,
                    ))
              ],
            ),
          ),
        );
      },
    );
  }

  /// This widget is shown when no file is selected.
  getNoFileSelectedWidget() {
    return Container(
      color: Colors.white,
      child: const Center(
          child: Text(
        "No File Added",
        style: TextStyle(fontWeight: FontWeight.w600),
      )),
    );
  }

  /// This widget is shown when the file format does not have any preview.
  getNoPreviewWidget(String extension) {
    return Container(
      color: Colors.white,
      child: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Icon(Icons.folder_outlined, size: 100, color: borderColor),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(extension.toUpperCase()),
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "No Preview",
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 8.0, right: 8.0),
            child: Text(
              "The file format does not have any preview.",
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
            ),
          ),
        ],
      )),
    );
  }

  /// This widget is used to show delete button of preview.
  /// It is shown when the preview is opened.
  /// It is used to delete the file at selected index.
  /// The file will be deleted from the [_pickedFiles] list.
  /// The onFilesChanged callback will be called with the [_pickedFiles] list.
  getDeleteButton(int index) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: IconButton(
            onPressed: () {
              _deleteMultipleFile(index);
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.delete_outline_outlined,
              color: Colors.black,
            )),
      ),
    );
  }

  /// This widget is used to show add button of preview.
  /// It is shown when the preview is opened.
  /// It is used to upload the file at selected index.
  /// The file will be uploaded from the [_pickedFiles] list.
  /// The onFilesChanged callback will be called with the [_pickedFiles] list.
  getAddButton(int index, StateSetter modalSetState) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: IconButton(
            onPressed: () {
              Navigator.pop(context);
              uploadFile(index);
            },
            icon: const Icon(
              Icons.add,
              color: Colors.black,
            )),
      ),
    );
  }

  /// This is the method to validate the file picker and it returns [bool].
  /// It is used to check the file picker is valid or not.
  /// The file picker is invalid when the file is not selected and checkbox is not checked.

  bool validateFilePicker() {
    if (widget.selectionMode == SelectionMode.single) {
      if (_pickedFile != null || isChecked) {
        return true;
      } else {
        return false;
      }
    } else {
      if (widget.isCheckBoxEnabled) {
        List<int> nullIndices = [];
        List<bool> checkList = [];

        for (int i = 0; i < _pickedFiles.length; i++) {
          if (_pickedFiles[i] == null) {
            nullIndices.add(i);
          }
        }

        if (nullIndices.isEmpty) {
          return true;
        } else {
          for (int index in nullIndices) {
            checkList.add(isFilesChecked[index]);
          }
          if (checkList.contains(false)) {
            return false;
          } else {
            return doneIcon();
          }
        }
      } else {
        if (!_pickedFiles.contains(null)) {
          return true;
        } else {
          return false;
        }
      }
    }
  }
}

/// This is the class to store the file details.
/// It contains the file, name, base64, extension and size of the file.
/// The file is the file object of the file.
/// The name is the name of the file.
/// The base64 is the base64 string of the file.
/// The extension is the extension of the file.
/// The size is the size of the file.
/// The size is in MB.

class PickedFile {
  final File file;
  final String name;
  final String base64;
  final String extension;
  final double size;

  PickedFile({
    required this.file,
    required this.name,
    required this.base64,
    required this.extension,
    required this.size,
  });
}
