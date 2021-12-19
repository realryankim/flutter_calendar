import 'package:flutter/material.dart';
import 'package:flutter_calendar/src/controller/event_editing_controller.dart';
import 'package:flutter_calendar/src/model/event.dart';
import 'package:flutter_calendar/src/page/event_editing_page.dart';
import 'package:flutter_calendar/src/utils/utils.dart';
import 'package:get/get.dart';

class EventViewingPage extends StatelessWidget {
  EventViewingPage({
    Key? key,
    required this.event,
  }) : super(key: key);

  final Event event;

  List<Widget> buildViewingActions(BuildContext context, Event event) {
    return [
      IconButton(
        icon: const Icon(Icons.edit),
        onPressed: () {
          Get.to(() => EventEditingPage(event: event),
              binding: BindingsBuilder(() {
            Get.lazyPut(() => EventEditingController());
          }));
        },
      ),
      IconButton(
        icon: const Icon(Icons.delete),
        onPressed: () {},
      ),
    ];
  }

  Widget buildDateTime(Event event) {
    return Column(
      children: [
        buildDate(event.isAllDay ? "All-day" : "From", event.fromDate),
        if (!event.isAllDay) buildDate('To', event.toDate),
      ],
    );
  }

  Widget buildDate(String title, DateTime date) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 18.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
          Text("${Utils.toDate(date)} ${Utils.toTime(date)}"),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: CloseButton(),
        actions: buildViewingActions(context, event),
      ),
      body: ListView(
        padding: const EdgeInsets.all(32),
        children: [
          buildDateTime(event),
          SizedBox(height: 32.0),
          Text(
            event.title,
            style: TextStyle(
              fontSize: 22.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 24.0),
          Text(
            event.description,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.0,
            ),
          ),
        ],
      ),
    );
  }
}
