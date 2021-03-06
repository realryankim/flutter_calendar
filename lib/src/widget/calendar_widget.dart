import 'package:flutter/material.dart';
import 'package:flutter_calendar/src/controller/event_controller.dart';
import 'package:flutter_calendar/src/model/event.dart';
import 'package:flutter_calendar/src/model/event_data_source.dart';
import 'package:flutter_calendar/src/widget/tasks_widget.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CalendarWidget extends StatelessWidget {
  const CalendarWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final RxList<Event> events = EventController.to.events;

    return Obx(
      // syncfusion_flutter_calendar
      () => SfCalendar(
        view: CalendarView.month,
        dataSource: EventDataSource(events.value),
        initialSelectedDate: DateTime.now(),
        cellBorderColor: Colors.transparent,
        onLongPress: (details) {
          final eventController = EventController.to;
          eventController.setDate(details.date!);
          Get.bottomSheet(TasksWidget());
        },
      ),
    );
  }
}
