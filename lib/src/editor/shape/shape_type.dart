import 'package:flutter/material.dart';

enum ShapeType {
  dot('Крапка', icon: Icons.trip_origin, usesDrag: false),
  line('Лінія', icon: Icons.horizontal_rule),
  rectangle('Прямокутник', icon: Icons.crop_square),
  ellipse('Еліпс', icon: Icons.panorama_fish_eye),
  circleLine('Лінія з кружечками', icon: Icons.timeline),
  cube('Каркас куба', icon: Icons.view_in_ar);

  const ShapeType(this.label, {required this.icon, this.usesDrag = true});

  final String label;

  final IconData icon;

  final bool usesDrag;
}
