import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_application_2/app/extensions/extensions.dart';
import 'package:flutter_application_2/app/widgets/widgets.dart';
import 'package:flutter_application_2/data/models/models.dart';
import 'package:flutter_application_2/di/di.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talker_flutter/talker_flutter.dart';

import 'bloc/bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<HomeBloc>()..add(const HomeLoad()),
      child: const _HomeView(),
    );
  }
}

class _HomeView extends StatelessWidget {
  const _HomeView();

  void _load(BuildContext context) {
    context.read<HomeBloc>().add(const HomeLoad());
  }

  /// Возвращает Future, чтобы RefreshIndicator показал индикатор
  /// ровно до окончания загрузки.
  Future<void> _refresh(BuildContext context) {
    final completer = Completer<void>();
    context.read<HomeBloc>().add(HomeLoad(completer: completer));
    return completer.future;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppAppbar(
        title: const Text('Recipe Book'),
        actions: [
          IconButton(
            tooltip: 'Логи приложения',
            icon: const Icon(Icons.bug_report_outlined),
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute<void>(
                builder: (_) => TalkerScreen(talker: talker),
              ),
            ),
          ),
        ],
      ),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          return switch (state) {
            HomeInitial() => const SizedBox.shrink(),
            HomeLoadInProgress() => const AppProgressIndicator(),
            HomeLoadSuccess() => _HomeContent(
              meals: state.meals,
              onRefresh: () => _refresh(context),
            ),
            HomeLoadFailure() => AppError(
              description: state.exception.toString(),
              onTap: () => _load(context),
            ),
          };
        },
      ),
    );
  }
}

class _HomeContent extends StatelessWidget {
  const _HomeContent({required this.meals, required this.onRefresh});

  final List<Meal> meals;
  final Future<void> Function() onRefresh;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return RefreshIndicator(
      onRefresh: onRefresh,
      child: ListView.separated(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.all(16),
        itemCount: meals.length + 1,
        itemBuilder: (context, index) {
          if (index == 0) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 4,
              children: [
                Text('Рецепты', style: theme.textTheme.headlineLarge),
                Text(
                  '${meals.length} рецептов из TheMealDB',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.outline,
                  ),
                ),
              ],
            );
          }
          return ContentCard(meal: meals[index - 1]);
        },
        separatorBuilder: (context, index) =>
            index == 0 ? 20.ph : 16.ph,
      ),
    );
  }
}
