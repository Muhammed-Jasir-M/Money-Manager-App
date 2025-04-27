import 'package:hive_flutter/hive_flutter.dart';

part 'category_model.g.dart';

@HiveType(typeId: 0)
class CategoryModel extends HiveObject {
  @HiveField(0)
  String categoryId;

  @HiveField(1)
  String title;

  @HiveField(2)
  String icon;

  @HiveField(3)
  String color;

  CategoryModel({
    required this.categoryId,
    required this.title,
    required this.icon,
    required this.color,
  });
}
