import 'package:flutter/material.dart';
import 'package:flutter_calendar/src/controller/event_editing_controller.dart';
import 'package:flutter_calendar/src/utils/utils.dart';
import 'package:get/get.dart';

class EventEditingPage extends GetView<EventEditingController> {
  const EventEditingPage({Key? key}) : super(key: key);

  List<Widget> buildEditingActions() {
    return [
      ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          primary: Colors.transparent,
          shadowColor: Colors.transparent,
          elevation: 0.0,
        ),
        onPressed: () {},
        icon: const Icon(Icons.done),
        label: const Text('SAVE'),
      ),
    ];
  }

  Widget buildTitle() {
    return TextFormField(
      style: TextStyle(fontSize: 24.0),
      decoration: InputDecoration(
        border: UnderlineInputBorder(),
        hintText: 'Add Title',
      ),
      onFieldSubmitted: (_) {},
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
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: buildDropdownField(
              text: Utils.toDate(controller.eventModel.value.fromDate),
              onClicked: () =>
                  controller.pickFromDateTime(context, pickDate: true),
            ),
          ),
          Expanded(
            child: buildDropdownField(
              text: Utils.toTime(controller.eventModel.value.fromDate),
              onClicked: () =>
                  controller.pickFromDateTime(context, pickDate: false),
            ),
          ),
        ],
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
              text: Utils.toDate(controller.eventModel.value.toDate),
              onClicked: () =>
                  controller.pickToDateTime(context, pickDate: true),
            ),
          ),
          Expanded(
            child: buildDropdownField(
              text: Utils.toTime(controller.eventModel.value.toDate),
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
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        child,
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: CloseButton(),
        actions: buildEditingActions(),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12.0),
        child: Form(
          key: controller.formKey,
          child: Obx(
            () => Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                buildTitle(),
                const SizedBox(height: 12),
                buildDateTimePickers(context),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
