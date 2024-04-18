import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:vc_product_widgets/components/date_picker/vc_product_date_picker.dart';

class DatePickerExamples extends StatefulWidget {
  const DatePickerExamples({Key? key}) : super(key: key);

  @override
  State<DatePickerExamples> createState() => _DatePickerExamplesState();
}

class _DatePickerExamplesState extends State<DatePickerExamples> {
  DateTime? selectedDate;
  DateTime initialDate = DateTime.now();
  final List<DateTime> holidayList = [
    DateTime(2023, 12, 1),
    DateTime(2023, 12, 2),
  ];
  bool hideHolidays = true;
  DateTime minDate = DateTime(2020);
  DateTime maxDate = DateTime(2025, 12, 19);
  bool hideFutureDates = false;
  bool hidePreviousDates = false;
  late int selectedMonth;
  late int selectedYear;
  TextEditingController controller = TextEditingController();

  String? validateDatePicker(String? value) {
    if (value == null || value.isEmpty) {
      return "This is error text";
    }
    return null;
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    selectedMonth = initialDate.month;
    selectedYear = initialDate.year;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: VCProductDatePicker(
                onDaySelected: (DateTime? selectedDate) {
                  setState(() {
                    this.selectedDate = selectedDate;
                    controller.text = DateFormat('dd.MM.yyyy')
                        .format(selectedDate ?? DateTime.now());
                  });
                },
                holidayList: [DateTime(2023, 12, 1), DateTime(2023, 12, 2)],
                hideHolidays: true,
                label: "Date of Birth",
                locale: "tr_TR",
                initialDate: initialDate,
                minDate: minDate,
                maxDate: maxDate,
                hideFutureDates: hideFutureDates,
                hidePreviousDates: hidePreviousDates,
                controller: controller,
                validator: validateDatePicker,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Form geçerli, işleniyor...')),
                  );
                }
              },
              child: const Text('Gönder'),
            ),
          ],
        ),
      ),
    );
  }
}
