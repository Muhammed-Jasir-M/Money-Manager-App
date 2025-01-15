import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryModel {
  String categoryId;
  String title;
  String icon;
  String color;

  CategoryModel({
    required this.categoryId,
    required this.title,
    required this.icon,
    required this.color,
  });

  static CategoryModel empty() =>
      CategoryModel(categoryId: '', title: '', icon: '', color: '');

  /// Convert Model to Json structure so that you can store data in Firebase
  Map<String, dynamic> toJson() {
    return {
      'categoryId': categoryId,
      'title': title,
      'icon': icon,
      'color': color,
    };
  }

  /// Map Json oriented document snapshot from Firebase to Usermodel
  factory CategoryModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data();
    if (data != null) {
      // Map Json Record to Model
      return CategoryModel(
        categoryId: document.id,
        title: data['title'] ?? '',
        icon: data['icon'] ?? '',
        color: data['color'] ?? '',
      );
    } else {
      return CategoryModel.empty();
    }
  }
}
