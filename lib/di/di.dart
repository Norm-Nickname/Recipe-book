import 'package:dio/dio.dart';
import 'package:flutter_application_2/app/features/content/content.dart';
import 'package:flutter_application_2/app/features/home/home.dart';
import 'package:flutter_application_2/data/data.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_flutter/talker_flutter.dart';

final getIt = GetIt.instance;
final talker = TalkerFlutter.init();
final Dio dio = Dio();

Future<void> setupLocator() async {
  getIt.registerSingleton(talker);

  setUpDio();

  getIt.registerSingleton<MealRepositoryInterface>(
    MealRepository(dio: dio),
  );

  // Блоки создаются заново для каждого экрана, поэтому регистрируем их
  // через registerFactory, а не как singleton.
  getIt.registerFactory(() => HomeBloc(getIt<MealRepositoryInterface>()));
  getIt.registerFactory(() => ContentBloc(getIt<MealRepositoryInterface>()));
}
