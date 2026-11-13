import 'package:flutter/material.dart';

class AppError extends StatelessWidget {
  const AppError({required this.description, this.onTap, super.key});

  final String description;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: 16,
          children: [
            Icon(
              Icons.cloud_off_outlined,
              size: 56,
              color: Theme.of(context).colorScheme.error,
            ),
            Text(
              'Не удалось загрузить данные',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            Text(
              description,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            if (onTap != null)
              FilledButton.icon(
                onPressed: onTap,
                icon: const Icon(Icons.refresh),
                label: const Text('Повторить'),
              ),
          ],
        ),
      ),
    );
  }
}
