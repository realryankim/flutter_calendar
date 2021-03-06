import 'package:flutter/material.dart';
import 'package:flutter_calendar/src/controller/event_controller.dart';
import 'package:flutter_calendar/src/controller/event_editing_controller.dart';
import 'package:flutter_calendar/src/model/event.dart';
import 'package:flutter_calendar/src/page/event_editing_page.dart';
import 'package:flutter_calendar/src/utils/utils.dart';
import 'package:flutter_calendar/src/widget/calendar_widget.dart';
import 'package:get/get.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Utils.title),
        centerTitle: true,
      ),
      body: CalendarWidget(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => EventEditingPage(), binding: BindingsBuilder(() {
            Get.lazyPut(() => EventEditingController());
          }));
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: Colors.red,
      ),
    );
  }
}
