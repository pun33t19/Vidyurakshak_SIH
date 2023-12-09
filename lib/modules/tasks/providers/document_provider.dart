import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:vidurakshak_sih/modules/tasks/models/document_model.dart';

class DocumentProvider extends ChangeNotifier {
  final List<DocumentModel> _documentList = [];

  UnmodifiableListView<DocumentModel> get items =>
      UnmodifiableListView(_documentList);

  void addDocumentItem(DocumentModel item) {
    _documentList.add(item);
    notifyListeners();
  }
}
