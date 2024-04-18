import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:vc_product_widgets/components/dropdown/vc_product_dropdown.dart';
import 'package:vc_product_widgets/components/text/typography_type.dart';
import 'package:vc_product_widgets/components/text/vc_product_text.dart';


class VCProductTimeSlots extends StatelessWidget {
  /// Final variable to store the start date of time slots [defaults to Datetime.now()]
  late final DateTime _startDate;

  /// Final variable to store the end date of time slots [defaults to 6:00 PM ]
  late final DateTime _endDate;

  /// Final variable to store the time interval between slots [defaults to 30 minutes]
  final Duration timeInterval;

  /// External label text
  final String labelText;

  /// Final variable to store the start of time slots [defaults to 9:00 AM ]
  final int startHour;

  /// External onChanged function
  final Function(dynamic, int) onChanged;

  /// The disabled state of the dropdown
  final bool? isDisabled;


  VCProductTimeSlots({
    super.key,
    required DateTime startDate,
    required this.labelText,
    required this.onChanged,
    this.timeInterval = const Duration(minutes: 30),
    this.startHour = 9,
    int endHour = 21,
    DateTime? endDate,
    this.isDisabled
  }){
     _startDate = _roundToNextHalfHour(startDate); 
     _endDate = endDate ?? DateTime(startDate.year, startDate.month, startDate.day, endHour, 0);
  }
  

  // Function to round the given time to the next half hour
  final int _halfTimePeriod = 30;
  DateTime _roundToNextHalfHour(DateTime time) {
    if (time.hour < startHour || (time.hour == startHour && time.minute == 0)) {
      return DateTime(time.year, time.month, time.day, startHour, 0); 
    }
    int nextHour = time.minute < _halfTimePeriod ? time.hour : time.hour + 1;
    int nextMinute = time.minute < _halfTimePeriod ? _halfTimePeriod : 0;
    return DateTime(time.year, time.month, time.day, nextHour, nextMinute);
  }

  // Function to generate time slots based on start and end dates and time interval
  List<String> generateTimeSlots() {
    List<String> timeSlots = [];

    // Date formatter for time representation in AM/PM format
    final DateFormat formatter = DateFormat('hh:mm a');

    DateTime currentTime = _startDate;
    while (currentTime.isBefore(_endDate)) {
      String startTime = formatter.format(currentTime);
      currentTime = currentTime.add(timeInterval);
      String endTimeFormatted = formatter.format(currentTime);
      timeSlots.add('$startTime - $endTimeFormatted');
    }

    return timeSlots; // Return the generated time slots
  }


  @override
  Widget build(BuildContext context) {
    List<String> slots = generateTimeSlots(); // Generate time slots

    return VCProductDropdown<String>(
      id: "timeslotcomponent",
      isSearchBoxDisabled: true,
      isDisabled: isDisabled ?? false,
      dropdownItems: slots,
      label: labelText,
      selectedItemWidget: (dynamic value) {
        return VCProductText(
            text: value.toString(),
            type: TypographyType.bodySemiBold16,
            textAlign: TextAlign.start);
      },
      selectableItemWidget: (dynamic value) {
        return VCProductText(
            text: value.toString(),
            type: TypographyType.bodyRegular14,
            textAlign: TextAlign.start);
      },
      onChanged: onChanged,
    );
  }
}
