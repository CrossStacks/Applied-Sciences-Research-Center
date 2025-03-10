import 'package:flutter/material.dart';

import 'custom_button_widget.dart';

class DatePicker extends StatefulWidget {
  const DatePicker({super.key});

  @override
  State<DatePicker> createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  DateTime? selectedDate;

  Future<void> _pickDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    String formatted1 = selectedDate != null
        ? "${selectedDate!.day} ${_getMonthAbbr(selectedDate!.month)}, ${selectedDate!.year}"
        : 'No date chosen';

    String formatted2 = selectedDate != null
        ? "${_getMonthName(selectedDate!.month)} ${selectedDate!.day}, ${selectedDate!.year}"
        : 'No date chosen';

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        CustomButtonWidget(
          initialColor: Color.fromARGB(255, 245, 245, 245),
          initialTextColor: Colors.black,
          hoverColor: Color.fromARGB(255, 244, 241, 237),
          hoverTextColor: Colors.black,
          onTap: _pickDate,
          text: 'Select Date',
          textStyle: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text('date: $formatted1'),
        Text('complete date: $formatted2'),
      ],
    );
  }

  String _getMonthAbbr(int month) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];
    return months[month - 1];
  }

  String _getMonthName(int month) {
    const months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December'
    ];
    return months[month - 1];
  }
}
