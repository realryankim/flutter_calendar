import 'package:flutter/material.dart';
import 'package:flutter_calendar/src/controller/event_controller.dart';
import 'package:flutter_calendar/src/model/event.dart';
import 'package:flutter_calendar/src/model/event_data_source.dart';
import 'package:flutter_calendar/src/page/event_viewing_page.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:syncfusion_flutter_core/theme.dart';

class TasksWidget extends StatelessWidget {
  const TasksWidget({Key? key}) : super(key: key);

  // 타임라인 이벤트 영역 UI
  Widget appintmentBuilder(
    BuildContext context,
    CalendarAppointmentDetails details,
  ) {
    final Event event = details.appointments.first;

    return Container(
      width: details.bounds.width,
      height: details.bounds.height,
      decoration: BoxDecoration(
        color: event.backgroundColor.withOpacity(0.5),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: Text(
          event.title,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final eventController = EventController.to;
    final selectedEvents = eventController.eventsOfSelectedDate;

    if (selectedEvents.isEmpty) {
      return const Center(
        child: Text(
          "No Events found!",
          style: TextStyle(color: Colors.white, fontSize: 24.0),
        ),
      );
    }

    return SfCalendarTheme(
      data: SfCalendarThemeData(
        timeTextStyle: const TextStyle(fontSize: 16.0, color: Colors.black),
      ),
      child: SfCalendar(
        view: CalendarView.timelineDay,
        dataSource: EventDataSource(eventController.events),
        initialDisplayDate: eventController.selectedDate,
        appointmentBuilder: appintmentBuilder,
        headerHeight: 0,
        todayHighlightColor: Colors.black,
        selectionDecoration: const BoxDecoration(
          // color: Colors.red.withOpacity(0.3),
          color: Colors.transparent,
        ),
        onTap: (details) {
          if (details.appointments == null) return;

          final event = details.appointments!.first;

          Get.to(() => EventViewingPage(event: event));
        },
      ),
    );
  }
}
