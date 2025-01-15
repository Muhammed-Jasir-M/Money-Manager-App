import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:money_tracker_app/models/category_model.dart';

class TransactionRepository {
  final _db = FirebaseFirestore.instance;

  Future<void> createCategory(CategoryModel category) async {
    try {
      await _db
          .collection('categories')
          .doc(category.categoryId)
          .set(category.toJson());
    } catch (e) {
      throw 'Something went wrong, Plaease try again';
    }
  }

  Future<List<CategoryModel>> getCategories() async {
    try {
      final snapshot = await _db.collection('categories').get();
      final list = snapshot.docs
          .map((document) => CategoryModel.fromSnapshot(document))
          .toList();
      return list;
    } catch (e) {
      throw 'Something went wrong, Plaease try again';
    }
  }
}
