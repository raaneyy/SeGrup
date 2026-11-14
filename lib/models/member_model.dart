import 'package:flutter/material.dart';

class MemberModel {
  String name;
  String role;
  final String initials;
  final Color avatarBgColor;
  final bool isCurrentUser;

  MemberModel({
    required this.name,
    required this.role,
    required this.initials,
    required this.avatarBgColor,
    this.isCurrentUser = false,
  });
}