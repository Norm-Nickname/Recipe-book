part of 'content_bloc.dart';

sealed class ContentEvent extends Equatable {
  const ContentEvent();

  @override
  List<Object?> get props => [];
}

class ContentLoad extends ContentEvent {
  const ContentLoad({required this.id, this.completer});

  /// id элемента, который нужно загрузить вторым запросом.
  final String id;

  final Completer<void>? completer;

  @override
  List<Object?> get props => [id];
}
