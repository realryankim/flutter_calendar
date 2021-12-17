import 'package:flutter_calendar/src/model/event.dart';
import 'package:get/get.dart';

class EventController extends GetxController {
  static EventController get to => Get.find<EventController>();

  final RxList<Event> _events = RxList<Event>();

  List<Event> get events => _events;

  void addEvent(Event event) {
    _events.add(event);
    print(_events.length);
  }
}
