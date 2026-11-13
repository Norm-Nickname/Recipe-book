import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'meal.g.dart';

/// Один ингредиент рецепта: название и количество.
class MealIngredient extends Equatable {
  const MealIngredient({required this.name, required this.measure});

  final String name;
  final String measure;

  /// TheMealDB присылает ингредиенты плоскими полями
  /// strIngredient1...strIngredient20 и strMeasure1...strMeasure20,
  /// поэтому собираем их в список вручную.
  static List<MealIngredient> listFromJson(Map<String, dynamic> json) {
    final ingredients = <MealIngredient>[];
    for (var i = 1; i <= 20; i++) {
      final name = (json['strIngredient$i'] as String?)?.trim() ?? '';
      final measure = (json['strMeasure$i'] as String?)?.trim() ?? '';
      if (name.isEmpty) continue;
      ingredients.add(MealIngredient(name: name, measure: measure));
    }
    return ingredients;
  }

  @override
  List<Object?> get props => [name, measure];
}

@JsonSerializable()
class Meal extends Equatable {
  const Meal({
    required this.id,
    required this.title,
    required this.category,
    required this.area,
    required this.instructions,
    required this.image,
    this.tags,
    this.youtube,
    this.ingredients = const [],
  });

  @JsonKey(name: 'idMeal')
  final String id;

  @JsonKey(name: 'strMeal')
  final String title;

  @JsonKey(name: 'strCategory', defaultValue: '')
  final String category;

  @JsonKey(name: 'strArea', defaultValue: '')
  final String area;

  @JsonKey(name: 'strInstructions', defaultValue: '')
  final String instructions;

  @JsonKey(name: 'strMealThumb', defaultValue: '')
  final String image;

  @JsonKey(name: 'strTags')
  final String? tags;

  @JsonKey(name: 'strYoutube')
  final String? youtube;

  /// Список ингредиентов не приходит отдельным полем, поэтому он
  /// не участвует в генерации и заполняется в фабрике ниже.
  @JsonKey(includeFromJson: false, includeToJson: false)
  final List<MealIngredient> ingredients;

  factory Meal.fromJson(Map<String, dynamic> json) {
    final meal = _$MealFromJson(json);
    return meal.copyWith(ingredients: MealIngredient.listFromJson(json));
  }

  Map<String, dynamic> toJson() => _$MealToJson(this);

  Meal copyWith({List<MealIngredient>? ingredients}) {
    return Meal(
      id: id,
      title: title,
      category: category,
      area: area,
      instructions: instructions,
      image: image,
      tags: tags,
      youtube: youtube,
      ingredients: ingredients ?? this.ingredients,
    );
  }

  /// Кухня и категория одной строкой; у некоторых рецептов кухня не указана.
  String get origin => [area, category]
      .where((e) => e.isNotEmpty)
      .join(' • ');

  /// Теги приходят одной строкой через запятую.
  List<String> get tagList {
    final value = tags;
    if (value == null || value.isEmpty) return const [];
    return value
        .split(',')
        .map((e) => e.trim())
        .where((e) => e.isNotEmpty)
        .toList();
  }

  bool get hasVideo {
    final value = youtube;
    return value != null && value.isNotEmpty;
  }

  /// Первое предложение инструкции — удобное короткое описание для карточки.
  String get shortDescription {
    final text = instructions.replaceAll(RegExp(r'\s+'), ' ').trim();
    final dotIndex = text.indexOf('.');
    if (dotIndex == -1) return text;
    return text.substring(0, dotIndex + 1);
  }

  @override
  List<Object?> get props => [
    id,
    title,
    category,
    area,
    instructions,
    image,
    tags,
    youtube,
    ingredients,
  ];
}
