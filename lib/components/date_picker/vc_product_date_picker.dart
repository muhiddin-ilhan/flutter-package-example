import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:vc_product_network/vc_product_network.dart';
import 'package:vc_product_widgets/components/base/base_component.dart';
import 'package:vc_product_widgets/components/buttons/vc_button/vc_button.dart';
import 'package:vc_product_widgets/components/inputs/vc_base_text_field.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:vc_product_widgets/components/vc_product_components.dart';
import '../../utils/color_constant.dart';

class VCProductDatePicker extends BaseComponent {
  /// The onDaySelected function of the date picker
  final Function(DateTime?) onDaySelected;

  /// The TextEditingController of the date picker
  final TextEditingController controller;

  /// The initial date of the date picker
  final DateTime initialDate;

  /// The list of holidays of the date picker (optional)
  final List<DateTime>? holidayList;

  /// The boolean value of the hideHolidays of the date picker (optional)
  final bool? hideHolidays;

  /// The minimum date of the date picker
  final DateTime minDate;

  /// The maximum date of the date picker
  final DateTime maxDate;

  /// The boolean value of the hideFutureDates of the date picker
  final bool hideFutureDates;

  /// The boolean value of the hidePreviousDates of the date picker
  final bool hidePreviousDates;

  /// The label of the date picker
  final String label;

  /// The locale of the date picker
  final String? locale;

  /// The validator function of the date picker (optional)
  final String? Function(String?)? validator;

  final String? errorText;

  final bool? isDisabled;

  const VCProductDatePicker({
    Key? key,
    super.id,
    super.showError,
    super.checkOthers,
    super.willValidate,
    required this.initialDate,
    this.holidayList = const [],
    required this.minDate,
    required this.maxDate,
    required this.hideFutureDates,
    required this.hidePreviousDates,
    required this.controller,
    this.hideHolidays = false,
    required this.onDaySelected,
    required this.label,
    this.locale,
    this.errorText,
    this.validator,
    this.isDisabled = false,
  }) : super(key: key);

  @override
  State<VCProductDatePicker> createState() => _VCProductDatePickerState();
}

class _VCProductDatePickerState extends State<VCProductDatePicker> {
  /// The selected date of the date picker
  DateTime? selectedDate;

  /// The selected month of the date picker
  late int selectedMonth;

  /// The selected year of the date picker
  late int selectedYear;

  /// The list of years in range of the date picker
  List<int> yearsInRange = [];

  final Color selectedDayColor = VCProductColors.instance.iconColor;

  @override
  void initState() {
    super.initState();
    initializeDateFormatting();
    selectedDate = widget.initialDate;
    selectedMonth = widget.initialDate.month;
    selectedYear = widget.initialDate.year;
    for (int year = widget.minDate.year; year <= widget.maxDate.year; year++) {
      yearsInRange.add(year);
    }
  }

  @override
  Widget build(BuildContext context) {
    return VCBaseTextField(
      validator: widget.validator,
      label: widget.label,
      suffixIcon:
          const Icon(Icons.calendar_month_outlined, color: Colors.black),
      onTap: () async {
        if (widget.isDisabled!) {
          return;
        }
        await _selectDate(context);
      },
      readOnly: true,
      id: widget.id,
      showError: widget.showError,
      controller: widget.controller,
      initValue: widget.controller.text,
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDialog<DateTime>(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter dialogSetState) {
          return AlertDialog(
            surfaceTintColor: Colors.transparent,
            content: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(
                              right: 8.0,
                            ),
                            child: dropdownMonth(dialogSetState),
                          ),
                        ),
                        Expanded(
                            child: Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: dropdownYear(dialogSetState),
                        )),
                      ],
                    ),
                  ),
                  TableCalendar(
                    startingDayOfWeek: StartingDayOfWeek.monday,
                    headerVisible: false,
                    locale: widget.locale,
                    holidayPredicate: (DateTime date) {
                      return widget.holidayList!
                          .contains(DateTime(date.year, date.month, date.day));
                    },
                    calendarStyle: CalendarStyle(
                        holidayTextStyle: const TextStyle(color: Colors.red),
                        todayTextStyle: const TextStyle(color: Colors.white),
                        weekendTextStyle: const TextStyle(color: Colors.red),
                        disabledTextStyle: const TextStyle(color: Colors.grey),
                        defaultTextStyle: const TextStyle(color: Colors.black),
                        selectedTextStyle: const TextStyle(color: Colors.white),
                        holidayDecoration:
                            const BoxDecoration(shape: BoxShape.circle),
                        selectedDecoration: BoxDecoration(
                          color: selectedDayColor,
                          shape: BoxShape.circle,
                        ),
                        isTodayHighlighted: false),
                    firstDay: widget.minDate,
                    lastDay: DateTime(widget.maxDate.year, 12, 31),
                    focusedDay: DateTime(selectedYear, selectedMonth),
                    selectedDayPredicate: (DateTime date) {
                      return isSameDay(selectedDate, date);
                    },
                    enabledDayPredicate: (DateTime date) {
                      if ((widget.hideFutureDates &&
                              date.isAfter(DateTime.now())) ||
                          (widget.hidePreviousDates &&
                              date.isBefore(DateTime.now()
                                  .subtract(const Duration(days: 1))))) {
                        return false;
                      }
                      if (date.isAfter(widget.maxDate)) {
                        return false;
                      }

                      if (widget.hideHolidays!) {
                        return !widget.holidayList!.contains(
                            DateTime(date.year, date.month, date.day));
                      }

                      return true;
                    },
                    onDaySelected: (selectedDay, focusedDay) {
                      dialogSetState(() {
                        selectedDate = selectedDay;
                      });
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: VCProductComponents.vcButton(
                      width: MediaQuery.of(context).size.width / 3,
                      backgroundColor: VCProductColors.instance.iconColor,
                      onTap: () {
                        widget.onDaySelected.call(selectedDate);
                        if (widget.id != null && widget.willValidate) {
                          ValidatorService.validate(
                              componentId: widget.id!,
                              value: selectedDate,
                              showError: widget.showError,
                              checkOthers: widget.checkOthers);
                        }
                        Navigator.of(context).pop(selectedDate);
                      },
                      disabled: false,
                      buttonType: VCButtonType.primary,
                      buttonSize: VCButtonSize.medium,
                      child: const Text("Done"),
                    ),
                  )
                ],
              ),
            ),
          );
        });
      },
    );

    if (picked != null) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  Widget dropdownMonth(StateSetter dialogSetState) {
    final List<String> months = List.generate(12, (int index) {
      return DateFormat.MMMM(widget.locale)
          .format(DateTime(DateTime.now().year, index + 1));
    });
    return DropdownButtonHideUnderline(
      child: DropdownButton(
        icon: const Icon(
          Icons.keyboard_arrow_down,
          color: Colors.grey,
        ),
        isExpanded: true,
        value: selectedMonth,
        onChanged: (int? newValue) {
          dialogSetState(() {
            selectedMonth = newValue!;
          });
        },
        items: months.map<DropdownMenuItem<int>>((String value) {
          return DropdownMenuItem<int>(
            value: months.indexOf(value) + 1,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }

  Widget dropdownYear(StateSetter dialogSetState) {
    return DropdownButtonHideUnderline(
      child: DropdownButton(
        icon: const Icon(
          Icons.keyboard_arrow_down,
          color: Colors.grey,
        ),
        isExpanded: true,
        value: selectedYear,
        onChanged: (int? newValue) {
          dialogSetState(() {
            selectedYear = newValue!;
          });
        },
        items: yearsInRange.map<DropdownMenuItem<int>>((int value) {
          return DropdownMenuItem<int>(
            value: value,
            child: Text(value.toString()),
          );
        }).toList(),
      ),
    );
  }
}
