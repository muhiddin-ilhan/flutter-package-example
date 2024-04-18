import 'package:flutter/material.dart';
import 'package:vc_product_widgets/components/buttons/vc_button/vc_button.dart';
import 'package:vc_product_widgets/components/dropdown/vc_product_dropdown.dart';
import 'package:vc_product_widgets/components/time_slots/vc_product_time_slots.dart';
import 'package:vc_product_widgets/components/vc_product_components.dart';

class DropdownExamples extends StatefulWidget {
  const DropdownExamples({Key? key}) : super(key: key);

  @override
  State<DropdownExamples> createState() => _DropdownExamplesState();
}

class _DropdownExamplesState extends State<DropdownExamples> {
  List<String> dropdownItems = [
    'Option 1',
    'Option 2',
    'Option 3',
    'Option 4',
    'Option 5',
    'Option 6',
    'Option 7',
    'Option 8',
    'Option 9',
  ];
  String labelText = "Options";
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final Color textColor = const Color(0xFF121212);

  String? validateDropdownValue(String? value) {
    if (value == null || value.isEmpty) {
      return "This is error text";
    }
    return null;
  }

  late final TextStyle defaultTextStyle;
  String? selectedValue;

  @override
  void initState() {
    super.initState();
    defaultTextStyle = TextStyle(
      color: textColor,
      fontSize: 14,
      fontWeight: FontWeight.w600,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(),
      body: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                  child: VCProductDropdown<String>(
                  isSearchBoxDisabled: false,
                  isDisabled: false,
                  dropdownItems: dropdownItems,
                  label: labelText,
                  selectedItemWidget: (dynamic value) {
                    return Text(value.toString(), style: defaultTextStyle);
                  },
                  selectableItemWidget: (dynamic value) {
                    return Text(value.toString());
                  },
                  onChanged: (dynamic newValue, int index) {
                    setState(() {
                      selectedValue = newValue.toString();
                    });
                  },
                  validator: validateDropdownValue,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: VCProductDropdown<String>(
                  isSearchBoxDisabled: true,
                  initialValue: dropdownItems.first,
                  isDisabled: false,
                  dropdownItems: dropdownItems,
                  label: labelText,
                   selectedItemWidget: (dynamic value) {
                    return Text(value.toString(), style: defaultTextStyle);
                  },
                  selectableItemWidget: (dynamic value) {
                    return Text(value.toString());
                  },
                  onChanged: (dynamic newValue, int index) {
                    setState(() {
                      selectedValue = newValue.toString();
                    });
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: VCProductDropdown(
                  isSearchBoxDisabled: false,
                  isDisabled: true,
                  dropdownItems: dropdownItems,
                  label: labelText,
                   selectedItemWidget: (dynamic value) {
                    return Text(value.toString(), style: defaultTextStyle);
                  },
                  selectableItemWidget: (dynamic value) {
                    return Text(value.toString());
                  },
                  onChanged: (dynamic newValue, int index) {
                    setState(() {
                      selectedValue = newValue.toString();
                    });
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: VCProductDropdown<String>(
                  isSearchBoxDisabled: false,
                  isDisabled: true,
                  dropdownItems: dropdownItems,
                  initialValue: dropdownItems.first,
                  label: labelText,
                   selectedItemWidget: (dynamic value) {
                    return Text(value.toString(), style: defaultTextStyle);
                  },
                  selectableItemWidget: (dynamic value) {
                    return Text(value.toString());
                  },
                  onChanged: (dynamic newValue, int index) {
                    setState(() {
                      selectedValue = newValue.toString();
                    });
                  },
                ),
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
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: VCProductTimeSlots(
                  labelText: "Select Time Slot",
                  startDate: DateTime.now(),
                  onChanged: (newValue, index) {
                    selectedValue = newValue.toString();
                  }, 
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
