library flutter_datetime_formfield;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateTimeFormField extends StatelessWidget {
  final DateTime initialValue;
  final FormFieldSetter<DateTime> onSaved;
  final FormFieldValidator<DateTime> validator;
  final bool autovalidate;
  final bool enabled;
  final String label;
  final DateFormat formatter;
  final bool onlyDate;
  final bool onlyTime;
  final DateTime firstDate;
  final DateTime lastDate;

  DateTimeFormField({
    @required DateTime initialValue,
    @required String label,
    DateFormat formatter,
    this.onSaved,
    this.validator,
    this.autovalidate: false,
    this.enabled: true,
    this.onlyDate: false,
    this.onlyTime: false,
    DateTime firstDate,
    DateTime lastDate,
  })  : assert(!onlyDate || !onlyTime),
        initialValue = initialValue ?? DateTime.now(),
        label = label ?? "Date Time",
        formatter = formatter ?? (onlyDate ? DateFormat("EEE, MMM d, yyyy") : (onlyTime ? DateFormat("h:mm a") : DateFormat("EE, MMM d, yyyy h:mma"))),
        firstDate =  firstDate ?? DateTime(1970),
        lastDate = lastDate ?? DateTime(2100);

  @override
  Widget build(BuildContext context) {
    return FormField<DateTime>(
      validator: validator,
      autovalidate: autovalidate,
      initialValue: initialValue,
      onSaved: onSaved,
      enabled: enabled,
      builder: (FormFieldState state) {
        return InkWell(
          child: InputDecorator(
            decoration: InputDecoration(
              labelText: label,
              errorText: state.errorText,
            ),
            child: Text(formatter.format(state.value)),
          ),
          onTap: () async {
            DateTime date;
            TimeOfDay time = TimeOfDay(hour: 0, minute: 0);
            if (onlyDate) {
              date = await showDatePicker(
                context: context,
                initialDate: state.value,
                firstDate: firstDate,
                lastDate: lastDate,
              );
              if (date != null) {
                state.didChange(date);
              }
            } else if (onlyTime) {
              time = await showTimePicker(
                context: context,
                initialTime: TimeOfDay.fromDateTime(state.value),
              );
              if (time != null) {
                state.didChange(DateTime(
                  initialValue.year,
                  initialValue.month,
                  initialValue.day,
                  time.hour,
                  time.minute,
                ));
              }
            } else {
              date = await showDatePicker(
                context: context,
                initialDate: state.value,
                firstDate: firstDate,
                lastDate: lastDate,
              );
              if (date != null) {
                time = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.fromDateTime(state.value),
                );
                if (time != null) {
                  state.didChange(DateTime(
                    date.year,
                    date.month,
                    date.day,
                    time.hour,
                    time.minute,
                  ));
                }
              }
            }
          },
        );
      },
    );
  }
}
