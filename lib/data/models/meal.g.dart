// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meal.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Meal _$MealFromJson(Map<String, dynamic> json) => Meal(
  id: json['idMeal'] as String,
  title: json['strMeal'] as String,
  category: json['strCategory'] as String? ?? '',
  area: json['strArea'] as String? ?? '',
  instructions: json['strInstructions'] as String? ?? '',
  image: json['strMealThumb'] as String? ?? '',
  tags: json['strTags'] as String?,
  youtube: json['strYoutube'] as String?,
);

Map<String, dynamic> _$MealToJson(Meal instance) => <String, dynamic>{
  'idMeal': instance.id,
  'strMeal': instance.title,
  'strCategory': instance.category,
  'strArea': instance.area,
  'strInstructions': instance.instructions,
  'strMealThumb': instance.image,
  'strTags': instance.tags,
  'strYoutube': instance.youtube,
};
