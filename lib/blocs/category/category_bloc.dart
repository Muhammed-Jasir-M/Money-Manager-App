import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:money_tracker_app/models/category/category_model.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final categoryBox = Hive.box<CategoryModel>('categories');

  CategoryBloc() : super(CategoryInitial()) {
    on<LoadCategories>((event, emit) async {
      emit(CategoryLoading());
      try {
        final categories = categoryBox.values.toList();
        if (categories.isEmpty) {
          emit(CategoryError("No categories found"));
        } else {
          emit(CategoryLoaded(categories));
        }
      } catch (e) {
        emit(CategoryError(e.toString()));
      }
    });

    on<AddCategory>((event, emit) async {
      emit(CategoryLoading());
      try {
        await categoryBox.add(event.category);
        final categories = categoryBox.values.toList();
        emit(CategoryLoaded(categories));
      } catch (e) {
        emit(CategoryError(e.toString()));
      }
    });

    add(LoadCategories());
  }
}
