part of 'contenedor_bloc.dart';

abstract class ContenedorEvent {}

class GetAllContenedoresEvent extends ContenedorEvent {}

class SelectContainerCardEvent extends ContenedorEvent {
  final int cardSelectedId;

  SelectContainerCardEvent(this.cardSelectedId);
}

class CreateContainerEvent extends ContenedorEvent {
  final String name;
  final String category;

  CreateContainerEvent({required this.name, required this.category});
}
