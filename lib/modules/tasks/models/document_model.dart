import 'dart:io';

class DocumentModel {
  final List<File> images;
  final String description;
  final String location;
  final DateTime timestamp;
  DocumentModel({
    required this.images,
    required this.description,
    required this.location,
    required this.timestamp,
  });
}
