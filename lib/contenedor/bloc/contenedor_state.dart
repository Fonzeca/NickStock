part of 'contenedor_bloc.dart';

class ContenedorState {
  final List<Contenedor> containers;
  final int cardSelectedId;

  ContenedorState({required this.containers, required this.cardSelectedId});

  ContenedorState copyWith(
      {List<Contenedor>? containers, int cardSelectedId = -1}) {
    return ContenedorState(
        containers: containers ?? this.containers,
        cardSelectedId: cardSelectedId);
  }
}

class ContenedorInitial extends ContenedorState {
  ContenedorInitial() : super(containers: [], cardSelectedId: -1);
}
