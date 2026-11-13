import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_application_2/data/data.dart';
import 'package:flutter_application_2/di/di.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'content_event.dart';
part 'content_state.dart';

class ContentBloc extends Bloc<ContentEvent, ContentState> {
  ContentBloc(this.mealRepository) : super(ContentInitial()) {
    on<ContentLoad>(_contentLoad);
  }

  final MealRepositoryInterface mealRepository;

  Future<void> _contentLoad(
    ContentLoad event,
    Emitter<ContentState> emit,
  ) async {
    try {
      if (state is! ContentLoadSuccess) {
        emit(ContentLoadInProgress());
      }
      final meal = await mealRepository.getMealById(event.id);
      emit(ContentLoadSuccess(meal: meal));
    } catch (exception, stackTrace) {
      emit(ContentLoadFailure(exception: exception));
      talker.handle(exception, stackTrace);
    } finally {
      event.completer?.complete();
    }
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    super.onError(error, stackTrace);
    talker.handle(error, stackTrace);
  }
}
