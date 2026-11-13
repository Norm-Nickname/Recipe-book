import 'package:flutter_application_2/data/models/models.dart';

abstract interface class MealRepositoryInterface {
  /// Первый запрос: список рецептов.
  Future<List<Meal>> getMeals();

  /// Второй запрос: один рецепт по id.
  Future<Meal> getMealById(String id);
}
