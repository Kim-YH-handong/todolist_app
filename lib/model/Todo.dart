import 'package:flutter/material.dart';

class Todo{
  Todo({
    required this.title,
    required this.memo,
    required this.endDate,
    required this.important,
    required this.isEnd
  });

  final String title;
  final String memo;
  final String endDate;
  final bool important;
  final bool isEnd;
}