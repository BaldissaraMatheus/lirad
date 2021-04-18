import 'package:flutter/material.dart';
import 'package:frontend/models/quiz.dart';

class Filter {
  final String key;
  final List<Quiz> quizes;
  Icon icon;

  Filter(this.key, this.quizes, this.icon);
}