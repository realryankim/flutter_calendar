import 'package:flutter/material.dart';
import 'package:flutter_calendar/src/model/event_model.dart';
import 'package:get/get.dart';

class EventEditingController extends GetxController {
  final EventModel eventModel = EventModel(
    title: '',
    description: '',
    from: DateTime.now(),
    to: DateTime.now().add(
      Duration(hours: 2),
    ),
  );
  final _formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();

  GlobalKey<FormState> get formKey => _formKey;

  @override
  void onClose() {
    titleController.dispose();
    super.onClose();
  }
}
