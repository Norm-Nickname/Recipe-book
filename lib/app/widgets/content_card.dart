import 'package:flutter/material.dart';
import 'package:flutter_application_2/app/widgets/meal_image.dart';
import 'package:flutter_application_2/data/models/models.dart';
import 'package:go_router/go_router.dart';

class ContentCard extends StatelessWidget {
  const ContentCard({required this.meal, super.key});

  final Meal meal;

  @override
  Widget build(BuildContext context) {
    final imageSize = 100.0;
    final theme = Theme.of(context);

    return InkWell(
      onTap: () => context.push('/content/${meal.id}'),
      borderRadius: BorderRadius.circular(16),
      child: SizedBox(
        height: imageSize,
        child: Row(
          spacing: 16,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: 'meal-image-${meal.id}',
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: MealImage(
                  url: meal.image,
                  height: imageSize,
                  width: imageSize,
                ),
              ),
            ),
            Expanded(
              child: Column(
                spacing: 4,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    meal.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.titleLarge,
                  ),
                  Text(
                    meal.origin,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.labelMedium?.copyWith(
                      color: theme.colorScheme.primary,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      meal.shortDescription,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.bodyMedium,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
