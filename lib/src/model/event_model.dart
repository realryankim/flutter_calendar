import 'package:flutter/material.dart';

class EventModel {
  final String title;
  final String description;
  final DateTime fromDate;
  final DateTime toDate;
  final Color backgroundColor;
  final bool isAllDay;

  const EventModel({
    required this.title,
    required this.description,
    required this.fromDate,
    required this.toDate,
    this.backgroundColor = Colors.lightGreen,
    this.isAllDay = false,
  });

  // model의 각 데이터를 업데이트 하기 위한 copyWith 메서드
  EventModel copyWith({
    String? title,
    String? description,
    DateTime? fromDate,
    DateTime? toDate,
    Color? backgroundColor,
    bool? isAllDay,
  }) {
    return EventModel(
      title: title ?? this.title,
      description: description ?? this.description,
      fromDate: fromDate ?? this.fromDate,
      toDate: toDate ?? this.toDate,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      isAllDay: isAllDay ?? this.isAllDay,
    );
  }
}
