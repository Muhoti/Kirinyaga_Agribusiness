import 'package:flutter/material.dart';

class MyCalendar extends StatefulWidget {
  final String? restorationId;
  final String label;
  Function(String) onSubmit;

  MyCalendar(
      {super.key,
      this.restorationId,
      required this.label,
      required this.onSubmit});

  @override
  _MyCalendarState createState() => _MyCalendarState();
}

class _MyCalendarState extends State<MyCalendar> with RestorationMixin {
  @override
  String? get restorationId => widget.restorationId;

  TextEditingController _controller = new TextEditingController();

  final RestorableDateTime _selectedDate = RestorableDateTime(
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day));
  late final RestorableRouteFuture<DateTime?> _restorableDatePickerRouteFuture =
      RestorableRouteFuture<DateTime?>(
    onComplete: _selectDate,
    onPresent: (NavigatorState navigator, Object? arguments) {
      return navigator.restorablePush(
        _datePickerRoute,
        arguments: _selectedDate.value.millisecondsSinceEpoch,
      );
    },
  );

  @pragma('vm:entry-point')
  static Route<DateTime> _datePickerRoute(
    BuildContext context,
    Object? arguments,
  ) {
    return DialogRoute<DateTime>(
      context: context,
      builder: (BuildContext context) {
        return DatePickerDialog(
          restorationId: 'date_picker_dialog',
          initialEntryMode: DatePickerEntryMode.calendarOnly,
          initialDate: DateTime.fromMillisecondsSinceEpoch(arguments! as int),
          firstDate: DateTime(2000),
          lastDate: DateTime(2099),
        );
      },
    );
  }

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(_selectedDate, 'selected_date');
    registerForRestoration(
        _restorableDatePickerRouteFuture, 'date_picker_route_future');
  }

  void _selectDate(DateTime? newSelectedDate) {
    if (newSelectedDate != null) {
      widget.onSubmit(
          "${_selectedDate.value.day}/${_selectedDate.value.month}/${_selectedDate.value.year}");
      setState(() {
        _controller.value = TextEditingValue(
          text:
              "${_selectedDate.value.day}/${_selectedDate.value.month}/${_selectedDate.value.year}",
          selection: TextSelection.fromPosition(
            TextPosition(
                offset:
                    "${_selectedDate.value.day}/${_selectedDate.value.month}/${_selectedDate.value.year}"
                        .length),
          ),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 10, 24, 10),
      child: TextField(
          onChanged: (value) {},
          onTap: () {
            _restorableDatePickerRouteFuture.present();
          },
          controller: _controller,
          enableSuggestions: false,
          autocorrect: false,
          decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(12),
              border: const OutlineInputBorder(
                  borderSide: BorderSide(color: Color.fromRGBO(0, 128, 0, 1))),
              filled: false,
              label: Text(
                widget.label.toString(),
                style: const TextStyle(color: Color.fromRGBO(0, 128, 0, 1)),
              ),
              floatingLabelBehavior: FloatingLabelBehavior.auto)),
    );
  }
}
