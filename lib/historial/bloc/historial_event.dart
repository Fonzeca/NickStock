part of 'historial_bloc.dart';

abstract class HistorialEvent {}

class GetAllHistorialesEvent extends HistorialEvent {}

class GetHistoryByContainerIdEvent extends HistorialEvent {
  final int id;

  GetHistoryByContainerIdEvent(this.id);
}

class FilterHistorysEvent extends HistorialEvent {
  final String pattern;

  FilterHistorysEvent(this.pattern);
}
