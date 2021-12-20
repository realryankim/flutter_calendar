import 'package:flutter/material.dart';
import 'package:flutter_calendar/src/controller/event_controller.dart';
import 'package:flutter_calendar/src/controller/event_editing_controller.dart';
import 'package:flutter_calendar/src/model/event.dart';
import 'package:flutter_calendar/src/utils/utils.dart';
import 'package:get/get.dart';

class EventEditingPage extends GetView<EventEditingController> {
  const EventEditingPage({
    Key? key,
    this.event,
  }) : super(key: key);

  final Event? event;

  List<Widget> buildEditingActions() {
    return [
      ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          primary: Colors.transparent,
          shadowColor: Colors.transparent,
          elevation: 0.0,
        ),
        onPressed: () {
          if (event == null) {
            controller.saveForm();
          } else {
            controller.saveForm(event);
          }
        },
        icon: const Icon(Icons.done),
        label: const Text('SAVE'),
      ),
    ];
  }

  Widget buildTitle() {
    return TextFormField(
      style: const TextStyle(fontSize: 24.0),
      decoration: InputDecoration(
        border: UnderlineInputBorder(),
        hintText: 'Add Title',
      ),
      // 타이틀을 입력하고, 키보드에서 체크를 눌러도, 이벤트 저장
      onFieldSubmitted: (_) => controller.saveForm,
      validator: (title) =>
          title != null && title.isEmpty ? 'Title cannot be empty' : null,
      controller: controller.titleController,
    );
  }

  Widget buildDateTimePickers(BuildContext context) {
    return Column(
      children: [
        buildFrom(context),
        buildTo(context),
      ],
    );
  }

  Widget buildFrom(BuildContext context) {
    return buildHeader(
      header: 'FROM',
      child: Obx(
        () => Row(
          children: [
            Expanded(
              flex: 2,
              child: buildDropdownField(
                text: Utils.toDate(controller.event.value.fromDate),
                onClicked: () =>
                    controller.pickFromDateTime(context, pickDate: true),
              ),
            ),
            Expanded(
              child: buildDropdownField(
                text: Utils.toTime(controller.event.value.fromDate),
                onClicked: () =>
                    controller.pickFromDateTime(context, pickDate: false),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTo(BuildContext context) {
    return buildHeader(
      header: 'TO',
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: buildDropdownField(
              text: Utils.toDate(controller.event.value.toDate),
              onClicked: () =>
                  controller.pickToDateTime(context, pickDate: true),
            ),
          ),
          Expanded(
            child: buildDropdownField(
              text: Utils.toTime(controller.event.value.toDate),
              onClicked: () =>
                  controller.pickToDateTime(context, pickDate: false),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildDropdownField({
    required String text,
    required VoidCallback onClicked,
  }) {
    return ListTile(
      title: Text(text),
      trailing: const Icon(Icons.arrow_drop_down),
      onTap: onClicked,
    );
  }

  Widget buildHeader({
    required String header,
    required Widget child,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          header,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        child,
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    if (event == null) {
      controller.titleController.text = '';
      controller.event.value.fromDate = DateTime.now();
      controller.event.value.toDate =
          DateTime.now().add(const Duration(hours: 2));
    } else {
      controller.titleController.text = event!.title;
      controller.event.value.fromDate = event!.fromDate;
      controller.event.value.toDate = event!.toDate;
    }

    return Scaffold(
      appBar: AppBar(
        leading: const CloseButton(),
        actions: buildEditingActions(),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12.0),
        child: Form(
          key: controller.formKey,
          child: Obx(
            () => GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () {
                Get.focusScope!.unfocus();
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  buildTitle(),
                  const SizedBox(height: 12),
                  buildDateTimePickers(context),

                  // TODO: Add All Day Event checkbox
                  // TODO: Add Event Details TextField
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
