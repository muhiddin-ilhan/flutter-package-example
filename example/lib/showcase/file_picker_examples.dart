import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:vc_product_widgets/components/buttons/vc_button/vc_button.dart';
import 'package:vc_product_widgets/components/file_picker/vc_product_file_picker.dart';
import 'package:vc_product_widgets/components/vc_product_components.dart';

class FilePickerExamples extends StatefulWidget {
  const FilePickerExamples({Key? key}) : super(key: key);

  @override
  State<FilePickerExamples> createState() => _FilePickerExamplesState();
}

class _FilePickerExamplesState extends State<FilePickerExamples> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool isDisabled = false;

  final List<String?> _fileNames = [];
  List<String> allowedExtensions = ['jpg', 'pdf', 'png', 'jpeg'];
  bool allowMultiple = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: [
              getTitle("Single With CheckBox"),
              VCProductFilePicker.single(
                infoText: "Upload any file minimum size 3MB",
                isCheckBoxEnabled: true,
                label: "Add File",
                title: "Identity Card",
                allowedExtensions: allowedExtensions,
                onChanged: (newValue) {
                  if (newValue != null) {
                    String fileName = newValue.name;
                    String extension = newValue.extension;
                    String base64 = newValue.base64;
                    debugPrint("file name: $fileName");
                    debugPrint(extension);
                    debugPrint(base64);
                  } else {
                    debugPrint("null");
                  }
                  setState(() {});
                },
                onCheckBoxTapped: (newValue) {
                  debugPrint(newValue.toString());
                },
              ),
              getTitle("Single Without CheckBox"),
              VCProductFilePicker.single(
                infoText: "Upload any file minimum size 3MB",
                validator: (isDone, newValue) {
                  if (!isDone) {
                    return "Please provide a file";
                  } else {
                    if (newValue!.size > 3) {
                      return "max size is 3";
                    } else {
                      return null;
                    }
                  }
                },
                label: "Add File",
                title: "Identity Card",
                allowedExtensions: allowedExtensions,
                onChanged: (newValue) {
                  if (newValue != null) {
                    String fileName = newValue.name;
                    String extension = newValue.extension;
                    String base64 = newValue.base64;
                    debugPrint("file name: $fileName");
                    debugPrint(extension);
                    debugPrint(base64);
                  } else {
                    debugPrint("null");
                  }
                },
              ),
              getTitle("Multiple With CheckBox"),
              VCProductFilePicker.multiple(
                infoText: "Upload any file minimum size 3MB",
                isCheckBoxEnabled: true,
                label: "Add File",
                title: "Identity Card",
                allowedExtensions: allowedExtensions,
                onFilesChanged: (newValue) {
                  List<String?> newFileNames = [];
                  for (int i = 0; i < newValue.length; i++) {
                    newFileNames.add(newValue[i]?.name);
                  }
                  _fileNames.clear();
                  _fileNames.addAll(newFileNames);
                  debugPrint(_fileNames.toString());
                },
                onFilesCheckBoxTapped: (newValue) {
                  debugPrint(newValue.toString());
                },
                fileNames: const ['Front Side', "Back Side"],
              ),
              getTitle("Multiple Without CheckBox"),
              VCProductFilePicker.multiple(
                infoText: "Upload any file minimum size 3MB",
                label: "Add File",
                title: "Identity Card",
                allowedExtensions: allowedExtensions,
                onFilesChanged: (newValue) {
                  List<String?> newFileNames = [];
                  for (int i = 0; i < newValue.length; i++) {
                    newFileNames.add(newValue[i]?.name);
                  }
                  _fileNames.clear();
                  _fileNames.addAll(newFileNames);
                  debugPrint(_fileNames.toString());
                },
                onFilesCheckBoxTapped: (newValue) {
                  debugPrint(newValue.toString());
                },
                fileNames: const ['Front Side', "Back Side"],
              ),
              getTitle("Custom Preview (PDF)"),
              VCProductFilePicker.single(
                infoText: "Upload any file minimum size 3MB",
                isCheckBoxEnabled: false,
                label: "Add File",
                title: "Identity Card",
                allowedExtensions: const ["pdf"],
                onChanged: (newValue) {
                  if (newValue != null) {
                    String fileName = newValue.name;
                    String extension = newValue.extension;
                    String base64 = newValue.base64;
                    debugPrint("file name: $fileName");
                    debugPrint(extension);
                    debugPrint(base64);
                  } else {
                    debugPrint("null");
                  }
                },
                onCheckBoxTapped: (newValue) {
                  debugPrint(newValue.toString());
                },
                previewWidget: (base64, file) {
                  return PDFView(
                    filePath: file.path,
                    enableSwipe: true,
                    swipeHorizontal: true,
                    autoSpacing: false,
                    pageFling: false,
                    onError: (error) {
                      debugPrint(error.toString());
                    },
                    onPageError: (page, error) {
                      debugPrint('$page: ${error.toString()}');
                    },
                  );
                },
              ),
              getTitle("mp4"),
              VCProductFilePicker.single(
                infoText: "Upload any file minimum size 3MB",
                isCheckBoxEnabled: false,
                label: "Add File",
                title: "Identity Card",
                allowedExtensions: const ["mp4"],
                onChanged: (newValue) {
                  if (newValue != null) {
                    String fileName = newValue.name;
                    String extension = newValue.extension;
                    String base64 = newValue.base64;
                    debugPrint("file name: $fileName");
                    debugPrint(extension);
                    debugPrint(base64);
                  } else {
                    debugPrint("null");
                  }
                },
                onCheckBoxTapped: (newValue) {
                  debugPrint(newValue.toString());
                },
                previewWidget: (base64, file) {
                  return PDFView(
                    filePath: file.path,
                    enableSwipe: true,
                    swipeHorizontal: true,
                    autoSpacing: false,
                    pageFling: false,
                    onError: (error) {
                      debugPrint(error.toString());
                    },
                    onPageError: (page, error) {
                      debugPrint('$page: ${error.toString()}');
                    },
                  );
                },
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: VCProductComponents.vcButton(
                  width: MediaQuery.of(context).size.width / 3,
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Success, processing...')),
                      );
                    }
                  },
                  disabled: false,
                  buttonType: VCButtonType.primary,
                  buttonSize: VCButtonSize.medium,
                  child: const Text("Send"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget getTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, bottom: 8),
      child: Container(
        width: MediaQuery.of(context).size.width,
        color: Colors.grey.shade200,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
