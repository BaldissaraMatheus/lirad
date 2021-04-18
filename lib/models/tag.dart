import 'package:flutter/material.dart';
import '../helper/icons_helper.dart';

class Tag {
  final String name;
  final Icon icon;

  Tag(this.name, this.icon);

  factory Tag.fromMap(Map<String, dynamic> snippet) {
    final icon = getMaterialIcon(name: snippet['icon']);
    return Tag(
      snippet['name'],
      Icon(icon != null ? getMaterialIcon(name: snippet['icon']) : Icons.subject)
    );
  }
}