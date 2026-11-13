import 'package:flutter/material.dart';
import 'package:flutter_application_2/app/widgets/widgets.dart';
import 'package:flutter_application_2/data/models/models.dart';
import 'package:flutter_application_2/di/di.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/bloc.dart';

class ContentScreen extends StatelessWidget {
  const ContentScreen({required this.contentId, super.key});

  final String contentId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          getIt<ContentBloc>()..add(ContentLoad(id: contentId)),
      child: _ContentView(contentId: contentId),
    );
  }
}

class _ContentView extends StatelessWidget {
  const _ContentView({required this.contentId});

  final String contentId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppAppbar(
        title: const Text('Details'),
        leading: const AppBackButton(),
      ),
      body: BlocBuilder<ContentBloc, ContentState>(
        builder: (context, state) {
          return switch (state) {
            ContentInitial() => const SizedBox.shrink(),
            ContentLoadInProgress() => const AppProgressIndicator(),
            ContentLoadSuccess() => _ContentDetails(meal: state.meal),
            ContentLoadFailure() => AppError(
              description: state.exception.toString(),
              onTap: () => context.read<ContentBloc>().add(
                ContentLoad(id: contentId),
              ),
            ),
          };
        },
      ),
    );
  }
}

class _ContentDetails extends StatelessWidget {
  const _ContentDetails({required this.meal});

  final Meal meal;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 16,
        children: [
          Hero(
            tag: 'meal-image-${meal.id}',
            child: ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: AspectRatio(
                aspectRatio: 4 / 3,
                child: MealImage(url: meal.image, width: double.infinity),
              ),
            ),
          ),
          Text(
            meal.title,
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              if (meal.category.isNotEmpty)
                _InfoChip(icon: Icons.restaurant_menu, label: meal.category),
              if (meal.area.isNotEmpty)
                _InfoChip(icon: Icons.public, label: meal.area),
              ...meal.tagList.map(
                (tag) => _InfoChip(icon: Icons.sell_outlined, label: tag),
              ),
            ],
          ),
          const Divider(height: 8),
          Text('Ингредиенты', style: theme.textTheme.titleLarge),
          Column(
            spacing: 6,
            children: meal.ingredients
                .map((ingredient) => _IngredientRow(ingredient: ingredient))
                .toList(),
          ),
          const Divider(height: 8),
          Text('Приготовление', style: theme.textTheme.titleLarge),
          Text(
            meal.instructions,
            style: theme.textTheme.bodyLarge?.copyWith(height: 1.6),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  const _InfoChip({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(100),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        spacing: 6,
        children: [
          Icon(icon, size: 16, color: theme.colorScheme.primary),
          Text(label, style: theme.textTheme.labelLarge),
        ],
      ),
    );
  }
}

class _IngredientRow extends StatelessWidget {
  const _IngredientRow({required this.ingredient});

  final MealIngredient ingredient;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 8,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 7),
          child: Icon(
            Icons.circle,
            size: 6,
            color: theme.colorScheme.primary,
          ),
        ),
        Expanded(child: Text(ingredient.name)),
        Text(
          ingredient.measure,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.outline,
          ),
        ),
      ],
    );
  }
}
