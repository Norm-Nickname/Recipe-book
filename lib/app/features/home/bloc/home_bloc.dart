import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_application_2/data/data.dart';
import 'package:flutter_application_2/di/di.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc(this.mealRepository) : super(HomeInitial()) {
    on<HomeLoad>(_homeLoad);
  }

  final MealRepositoryInterface mealRepository;

  Future<void> _homeLoad(HomeLoad event, Emitter<HomeState> emit) async {
    try {
      if (state is! HomeLoadSuccess) {
        emit(HomeLoadInProgress());
      }
      final meals = await mealRepository.getMeals();
      emit(HomeLoadSuccess(meals: meals));
    } catch (exception, stackTrace) {
      emit(HomeLoadFailure(exception: exception));
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
