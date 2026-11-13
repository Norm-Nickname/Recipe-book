part of 'home_bloc.dart';

sealed class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object?> get props => [];
}

class HomeLoad extends HomeEvent {
  const HomeLoad({this.completer});

  /// Нужен, чтобы RefreshIndicator знал, когда загрузка завершилась.
  final Completer<void>? completer;

  @override
  List<Object?> get props => [];
}
