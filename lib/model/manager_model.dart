import 'package:flutter/material.dart';

class ManagerModel {
  ManagerModel({
    required this.pk,
    this.name,
    this.createdAt,
    this.updatedAt,
    this.profile,
  });

  final int pk;
  final String? name;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final Widget? profile;

  factory ManagerModel.dummy() {
    return ManagerModel(
        pk: -1,
        name: 'Dummy Manager',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        profile: const Icon(Icons.person));
  }

  ManagerModel copyWith({
    int? pk,
    String? name,
    DateTime? createdAt,
    DateTime? updatedAt,
    Widget? profile,
  }) {
    return ManagerModel(
      pk: pk ?? this.pk,
      name: name ?? this.name,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      profile: profile ?? this.profile,
    );
  }
}
