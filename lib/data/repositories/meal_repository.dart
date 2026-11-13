import 'package:dio/dio.dart';
import 'package:flutter_application_2/data/dio/dio.dart';
import 'package:flutter_application_2/data/models/models.dart';
import 'package:flutter_application_2/data/repositories/meal_repository_interface.dart';

class MealRepository implements MealRepositoryInterface {
  MealRepository({required this.dio});

  final Dio dio;

  @override
  Future<List<Meal>> getMeals() async {
    try {
      final Response response = await dio.get(
        Endpoints.search,
        queryParameters: {'s': ''},
      );
      final meals = response.data['meals'] as List?;
      if (meals == null) return [];
      return meals
          .map((e) => Meal.fromJson(e as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw e.message.toString();
    }
  }

  @override
  Future<Meal> getMealById(String id) async {
    try {
      final Response response = await dio.get(
        Endpoints.lookup,
        queryParameters: {'i': id},
      );
      final meals = response.data['meals'] as List?;
      if (meals == null || meals.isEmpty) {
        throw 'Рецепт с id $id не найден';
      }
      return Meal.fromJson(meals.first as Map<String, dynamic>);
    } on DioException catch (e) {
      throw e.message.toString();
    }
  }
}
