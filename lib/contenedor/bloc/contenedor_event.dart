part of 'contenedor_bloc.dart';

abstract class ContenedorEvent {}

class GetAllContenedoresEvent extends ContenedorEvent {}

class SelectContainerCardEvent extends ContenedorEvent {
  final int cardSelectedId;

  SelectContainerCardEvent(this.cardSelectedId);
}
