import 'package:flutter/material.dart';
import 'package:flutter_calendar/src/page/event_editing_page.dart';
import 'package:flutter_calendar/src/widget/calendar_widget.dart';
import 'package:get/get.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: Text(MyApp.title),
        title: Text('Calendar Events App'),
        centerTitle: true,
      ),
      body: CalendarWidget(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => EventEditingPage());
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: Colors.red,
      ),
    );
  }
}
