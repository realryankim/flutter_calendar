import 'package:flutter/material.dart';
import 'package:flutter_calendar/src/app.dart';
import 'package:flutter_calendar/src/controller/event_controller.dart';
import 'package:flutter_calendar/src/model/event.dart';
import 'package:get/get.dart';

class EventEditingController extends GetxController {
  static EventEditingController get to => Get.find<EventEditingController>();

  // Event 반응형으로 초기화
  Rx<Event> event = Event(
    title: '',
    description: '',
    fromDate: DateTime.now(),
    toDate: DateTime.now().add(
      const Duration(hours: 2),
    ),
  ).obs;

  final _formKey = GlobalKey<FormState>();
  late TextEditingController titleController = TextEditingController();

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
      event.value.fromDate,
      pickDate: pickDate,
    );

    if (date == null) return;

    // fromDate를 toDate 넘는 날짜를 선택하면 toDate을 변경
    if (date.isAfter(event.value.toDate)) {
      event(
        event.value.copyWith(
          toDate: DateTime(
            date.year,
            date.month,
            date.day,
            date.hour,
            date.minute,
          ),
        ),
      );
    }

    // event.value.fromDate = date; ❌
    event(event.value.copyWith(fromDate: date));
  }

  Future pickToDateTime(BuildContext context, {required bool pickDate}) async {
    final date = await pickDateTime(
      context,
      event.value.toDate,
      pickDate: pickDate,
      // firstDate: from date 이전 날짜들은 null로 할당해서 선택 안되도록
      firstDate: pickDate ? event.value.fromDate : null,
    );

    if (date == null) return;

    // event.value.toDate = date; ❌
    event(event.value.copyWith(toDate: date));
  }

  Future<DateTime?> pickDateTime(BuildContext context, DateTime initialDate,
      {required bool pickDate, DateTime? firstDate}) async {
    // DatePicker
    if (pickDate) {
      final date = await showDatePicker(
        context: context,
        initialDate: initialDate,
        // 날짜 시작, 끝의 범위 제한
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
      // TimePicker
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

  // 이벤트 저장
  Future saveForm([Event? previousEvent]) async {
    final isValid = _formKey.currentState!.validate();

    if (isValid) {
      final saveEvent = event.value.copyWith(
        title: titleController.text,
        description: 'Description',
        fromDate: event.value.fromDate,
        toDate: event.value.toDate,
        isAllDay: false,
      );

      // edit mode
      final oldEvent = previousEvent;
      final isEditing = oldEvent != null;

      // final eventController = Get.find<EventController>(); // #1
      final eventController = EventController.to; // #2

      if (isEditing) {
        eventController.editEvent(saveEvent, oldEvent!);
        Get.offAll(() => App());
      } else {
        eventController.addEvent(saveEvent);
        Get.offAll(() => App());
      }
      Get.back();
    }
  }
}
