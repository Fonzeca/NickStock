part of 'historial_bloc.dart';

class HistorialState {
  final List<Historial> historys;

  HistorialState({required this.historys});

  HistorialState copyWith({List<Historial>? historys}) {
    return HistorialState(historys: historys ?? this.historys);
  }
}

class HistorialInit extends HistorialState {
  HistorialInit() : super(historys: []);
}
