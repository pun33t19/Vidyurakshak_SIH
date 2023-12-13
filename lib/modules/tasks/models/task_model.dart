import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:vidurakshak_sih/modules/tasks/enums/status_enum.dart';
import 'package:vidurakshak_sih/modules/tasks/enums/tasks_priority_enum.dart';

class TaskModel {
  final String description;
  final String title;
  final TasksPriority priority;
  final bool active;
  final StatusEnum status;
  final GeoPoint latlng;
  TaskModel({
    required this.description,
    required this.title,
    required this.active,
    required this.priority,
    required this.status,
    required this.latlng,
  });

  static TasksPriority getPriorityEnum(String priority) {
    switch (priority.toLowerCase()) {
      case 'low':
        return TasksPriority.low;
      case 'medium':
        return TasksPriority.medium;
      default:
        return TasksPriority.high;
    }
  }

  static StatusEnum getStatusEnum(String status) {
    switch (status.toLowerCase()) {
      case 'start':
        return StatusEnum.start;
      case 'workInProgress':
        return StatusEnum.workInProgress;
      case 'inspection':
        return StatusEnum.inspection;
      case 'finished':
        return StatusEnum.finished;
      default:
        return StatusEnum.start;
    }
  }
}
