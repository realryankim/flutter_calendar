import 'package:flutter/material.dart';
import 'package:flutter_calendar/src/controller/event_controller.dart';
import 'package:flutter_calendar/src/model/event.dart';
import 'package:get/get.dart';

class EventEditingController extends GetxController {
  static EventEditingController get to => Get.find<EventEditingController>();

  // EventEditingController({
  //   this.oldEvent,
  // });

  // final Event? oldEvent;

  final Rx<Event> event = Event(
    title: '',
    description: '',
    fromDate: DateTime.now(),
    toDate: DateTime.now().add(
      Duration(hours: 2),
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

    // From 날짜가 To 날짜를 넘으면
    if (date.isAfter(event.value.toDate)) {
      event(
        event.value.copyWith(
          toDate: DateTime(
            date.year,
            date.month,
            date.day,
            event.value.toDate.hour,
            event.value.toDate.minute,
          ),
        ),
      );
    }

    event(event.value.copyWith(fromDate: date));
  }

  Future pickToDateTime(BuildContext context, {required bool pickDate}) async {
    final date = await pickDateTime(
      context,
      event.value.toDate,
      pickDate: pickDate,
      // from date 이전 날짜는 null로 선택 안되도록
      firstDate: pickDate ? event.value.fromDate : null,
    );

    if (date == null) return;

    event(event.value.copyWith(toDate: date));
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
      final oldTitleData = previousEvent!.title.isEmpty;
      final oldEvent = previousEvent;
      final isEditing = oldTitleData == false;

      // final eventController = Get.find<EventController>(); // #1
      final eventController = EventController.to; // #2

      if (isEditing) {
        eventController.editEvent(saveEvent, oldEvent);
        Get.back();
      } else {
        eventController.addEvent(saveEvent);
      }

      Get.back();
      Get.back();
    }
  }
}
