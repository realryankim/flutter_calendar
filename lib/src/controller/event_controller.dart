import 'package:flutter_calendar/src/model/event.dart';
import 'package:get/get.dart';

class EventController extends GetxController {
  static EventController get to => Get.find<EventController>();

  final RxList<Event> _events = RxList<Event>();

  RxList<Event> get events => _events;

  DateTime _selectedDate = DateTime.now();

  DateTime get selectedDate => _selectedDate;
  void setDate(DateTime date) => _selectedDate = date;

  List<Event> get eventsOfSelectedDate => _events;

  void addEvent(Event event) {
    _events.add(event);
  }

  // #
  void deleteEvent(Event event) {
    _events.remove(event);
  }

  void editEvent(Event newEvent, Event oldEvent) {
    final index = _events.indexOf(oldEvent);
    print(newEvent.title);
    print(oldEvent.title);
    print(index);
    _events[index] = newEvent;
  }
}
