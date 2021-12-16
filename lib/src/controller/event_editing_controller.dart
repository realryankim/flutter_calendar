import 'package:flutter/material.dart';
import 'package:flutter_calendar/src/model/event_model.dart';
import 'package:get/get.dart';

class EventEditingController extends GetxController {
  final Rx<EventModel> eventModel = EventModel(
    title: '',
    description: '',
    fromDate: DateTime.now(),
    toDate: DateTime.now().add(
      Duration(hours: 2),
    ),
  ).obs;
  final _formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();

  GlobalKey<FormState> get formKey => _formKey;

  @override
  void onClose() {
    titleController.dispose();
    super.onClose();
  }

  Future pickFromDateTime(BuildContext context,
      {required bool pickDate}) async {
    final date = await pickDateTime(
      context,
      eventModel.value.fromDate,
      pickDate: pickDate,
    );

    if (date == null) return;

    // From 날짜가 To 날짜를 넘으면

    if (date.isAfter(eventModel.value.toDate)) {
      eventModel(
        eventModel.value.copyWith(
          toDate: DateTime(
            date.year,
            date.month,
            date.day,
            eventModel.value.toDate.hour,
            eventModel.value.toDate.minute,
          ),
        ),
      );
    }

    eventModel(eventModel.value.copyWith(fromDate: date));
  }

  Future pickToDateTime(BuildContext context, {required bool pickDate}) async {
    final date = await pickDateTime(
      context,
      eventModel.value.toDate,
      pickDate: pickDate,
      // from date 이전 날짜는 null로 선택 안되도록
      firstDate: pickDate ? eventModel.value.fromDate : null,
    );

    if (date == null) return;

    eventModel(eventModel.value.copyWith(toDate: date));
  }

  Future<DateTime?> pickDateTime(BuildContext context, DateTime initialDate,
      {required bool pickDate, DateTime? firstDate}) async {
    // date
    if (pickDate) {
      final date = await showDatePicker(
        context: context,
        initialDate: initialDate,
        // 날짜 시작
        firstDate: firstDate ?? DateTime(2015, 8),
        lastDate: DateTime(2101),
      );

      if (date == null) return null;

      final time = Duration(
        hours: initialDate.hour,
        minutes: initialDate.minute,
      );

      return date.add(time);
    } else {
      // time
      final timeOfDay = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(initialDate),
      );

      if (timeOfDay == null) return null;

      final date =
          DateTime(initialDate.year, initialDate.month, initialDate.day);

      final time = Duration(
        hours: timeOfDay.hour,
        minutes: timeOfDay.minute,
      );
      return date.add(time);
    }
  }
}
