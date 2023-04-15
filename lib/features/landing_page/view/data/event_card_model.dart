import 'package:flutter/material.dart';

class EventCardModel {
  final String title;
  final Image image;
  final DateTime date;
  final String location;
  final String id;

  EventCardModel({
    required this.title,
    required this.image,
    required this.date,
    required this.location,
    required this.id,
  });
}
