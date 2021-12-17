import 'package:flutter_calendar/src/controller/event_controller.dart';
import 'package:flutter_calendar/src/controller/event_editing_controller.dart';
import 'package:get/get.dart';

class Binding implements Bindings {
  @override
  void dependencies() {
    Get.put(EventController());
  }
}
