import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:vidurakshak_sih/modules/tasks/enums/status_enum.dart';
import 'package:vidurakshak_sih/modules/tasks/enums/tasks_priority_enum.dart';
import 'package:vidurakshak_sih/modules/tasks/models/task_model.dart';
import 'package:vidurakshak_sih/modules/tasks/repository/tasks_repository.dart';

class TaskListProvider extends ChangeNotifier {
  final List<TaskModel> _activetasksList = [];
  final List<TaskModel> _completedTasksList = [];
  TaskModel _tasksModel = TaskModel(
      description: '',
      title: '',
      active: true,
      priority: TasksPriority.low,
      status: StatusEnum.start,
      latlng: GeoPoint(0, 0));

  TaskModel get tasksModel => _tasksModel;
  UnmodifiableListView<TaskModel> get activeTasksList =>
      UnmodifiableListView(_activetasksList);
  UnmodifiableListView<TaskModel> get completedTasksList =>
      UnmodifiableListView(_completedTasksList);

  void addTasksItem() async {
    final list = await TasksRepository().fetchData();
    _activetasksList.clear();
    _completedTasksList.clear();

    for (QueryDocumentSnapshot<Map<String, dynamic>> docs in list) {
      if (docs.get('active')) {
        _activetasksList.add(
          TaskModel(
            description: docs.get('description'),
            title: docs.get('title'),
            active: docs.get('active'),
            priority: TaskModel.getPriorityEnum(docs.get('priority')),
            status: TaskModel.getStatusEnum(docs.get('status')),
            latlng: docs.get('location'),
          ),
        );
      } else {
        _completedTasksList.add(
          TaskModel(
            description: docs.get('description'),
            title: docs.get('title'),
            active: docs.get('active'),
            priority: TaskModel.getPriorityEnum(docs.get('priority')),
            status: TaskModel.getStatusEnum(docs.get('status')),
            latlng: docs.get('location'),
          ),
        );
      }
    }
    notifyListeners();
  }

  void updateTasksModel(TaskModel taskModel) {
    _tasksModel = taskModel;

    notifyListeners();
  }
}
