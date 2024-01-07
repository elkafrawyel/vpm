import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../../app/config/app_color.dart';
import '../../../app/util/constants.dart';
import '../modal_bottom_sheet.dart';

class AppDateRangeSelector extends StatefulWidget {
  final Widget child;
  final Function(String firstDate, String lastDate) onDateSelected;
  final DateTime? startDate, endDate;
  final String outputFormat;
  final String? validationText;

  const AppDateRangeSelector({
    Key? key,
    required this.child,
    required this.onDateSelected,
    this.startDate,
    this.endDate,
    this.validationText,
    this.outputFormat = 'yyyy-MM-dd',
  }) : super(key: key);

  @override
  State<AppDateRangeSelector> createState() => AppDateRangeSelectorState();
}

class AppDateRangeSelectorState extends State<AppDateRangeSelector> {
  /// The start date of the range.
  DateTime? startDate;

  /// The end date of the range.
  DateTime? endDate;

  PickerDateRange? initialSelectedDates;
  DateRangePickerSelectionChangedArgs? selectedArgs;
  String? range;
  FormFieldState<Object?>? formFieldState;

  @override
  void initState() {
    super.initState();
    startDate = widget.startDate;
    endDate = widget.endDate;
  }

  reset() {
    startDate = null;
    endDate = null;
  }

  @override
  Widget build(BuildContext context) {
    return FormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) {
        if (value == null) {
          return widget.validationText;
        } else {
          return null;
        }
      },
      builder: (formFieldState) {
        this.formFieldState = formFieldState;
        bool hasError = formFieldState.hasError && widget.validationText != null;

        return GestureDetector(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(kRadius),
                  border: Border.all(color: hasError ? Colors.red : Theme.of(context).primaryColor),
                ),
                child: widget.child,
              ),
              if (hasError)
                Padding(
                  padding: const EdgeInsetsDirectional.only(start: 12, top: 10),
                  child: Text(
                    formFieldState.errorText!,
                    style: const TextStyle(
                      fontStyle: FontStyle.normal,
                      fontSize: 13,
                      fontWeight: FontWeight.normal,
                      color: errorColor,
                      height: 0.5,
                    ),
                  ),
                )
            ],
          ),
          onTap: () {
            FocusManager.instance.primaryFocus!.unfocus();
            showAppModalBottomSheet(
                context: context,
                builder: (context, scrollController) {
                  return Container(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: IconButton(
                            onPressed: () {
                              Get.back();
                            },
                            icon: const Icon(Icons.clear),
                          ),
                        ),
                        Expanded(
                          child: SfDateRangePicker(
                            selectionColor: Theme.of(context).primaryColor,
                            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                            onSelectionChanged: _onSelectionChanged,
                            view: DateRangePickerView.month,
                            selectionMode: DateRangePickerSelectionMode.range,
                            showTodayButton: false,
                            enablePastDates: false,
                            initialSelectedRange: PickerDateRange(startDate, endDate),
                            // minDate: DateTime.now(),
                            // maxDate: DateTime(DateTime.now().year + 2),
                            todayHighlightColor: Theme.of(context).primaryColor,
                            rangeSelectionColor: Theme.of(context).primaryColor.withOpacity(0.5),
                            startRangeSelectionColor: Theme.of(context).primaryColor,
                            endRangeSelectionColor: Theme.of(context).primaryColor,
                            initialSelectedDate: DateTime.now(),
                            navigationDirection: DateRangePickerNavigationDirection.vertical,
                            navigationMode: DateRangePickerNavigationMode.scroll,
                            toggleDaySelection: true,
                            headerStyle: DateRangePickerHeaderStyle(
                              textStyle: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold, color: Theme.of(context).primaryColor),
                              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                            ),
                            selectionTextStyle: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                            rangeTextStyle: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                });
          },
        );
      },
    );
  }

  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    selectedArgs = args;
    startDate = args.value.selectedDate;
    endDate = args.value.endDate;
    int daysCount = 0;
    if (startDate != null && endDate != null) {
      daysCount = endDate!.difference(startDate!).inDays;
      if (daysCount == 0) {
        range = null;
        setState(() {});
        return;
      }
    }
    if (startDate != null && endDate != null) {
      String firstDate = _formatSelectedDate(startDate!);
      String lastDate = _formatSelectedDate(endDate!);
      range = '$firstDate - $lastDate';
      widget.onDateSelected(firstDate, lastDate);
      // ignore: invalid_use_of_protected_member
      formFieldState?.setValue(firstDate);
      formFieldState?.validate();
    } else {
      range = ' - ';
    }
    setState(() {});
  }

  String _formatSelectedDate(DateTime dateTime) {
    return DateFormat(widget.outputFormat, (Get.locale?.languageCode ?? 'en')).format(dateTime).toString();
  }
}
