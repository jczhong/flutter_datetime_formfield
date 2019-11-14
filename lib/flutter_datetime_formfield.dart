library flutter_datetime_formfield;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// A date time pick form field widget.
class DateTimeFormField extends StatelessWidget {
  /// The initial date time, default value is 'DateTime.now()'.
  final DateTime initialValue;
  /// Save value function of form field.
  final FormFieldSetter<DateTime> onSaved;
  /// Validate function of form field.
  final FormFieldValidator<DateTime> validator;
  /// Whether validate every time, default value is false.
  final bool autovalidate;
  final bool enabled;
  /// The label of form field, default value is 'Date Time'.
  final String label;
  /// The format of displaying date time in form field, default value is 'DateFormat("EE, MMM d, yyyy h:mma")' in date and time mode,
  /// 'DateFormat("EEE, MMM d, yyyy")' in date only mode,
  /// 'DateFormat("h:mm a") in time only mode.
  final DateFormat formatter;
  /// Only show and edit date, default value is false.
  final bool onlyDate;
  /// Only show and edit time, default value is false. [onlyDate] and [onlyTime] cannot be set to true at the same time.
  final bool onlyTime;
  /// The first date time of picking, default value is 'DateTime(1970)'.
  final DateTime firstDate;
  /// The last date time of picking, default value is 'DateTime(2100)'.
  final DateTime lastDate;

  /// Create a DateTimeFormField.
  /// The [onlyDate] and [onlyTime] arguments can not be set to true at the same time.
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
        formatter = formatter ??
            (onlyDate
                ? DateFormat("EEE, MMM d, yyyy")
                : (onlyTime
                    ? DateFormat("h:mm a")
                    : DateFormat("EE, MMM d, yyyy h:mma"))),
        firstDate = firstDate ?? DateTime(1970),
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
