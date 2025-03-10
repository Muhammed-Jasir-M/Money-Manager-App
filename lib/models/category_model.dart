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

}
