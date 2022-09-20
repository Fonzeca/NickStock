part of 'home_bloc.dart';

abstract class HomeEvent {}

class ChangeTitleEvent extends HomeEvent {
  final String title;

  ChangeTitleEvent(this.title);
}

class ChangeToHistoryEvent extends HomeEvent {
  final bool isInHistory;

  ChangeToHistoryEvent(this.isInHistory);
}
