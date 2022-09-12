import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stock_app/api/api.dart';
import 'package:stock_app/api/models/models.dart';

part 'contenedor_event.dart';
part 'contenedor_state.dart';

class ContenedorBloc extends Bloc<ContenedorEvent, ContenedorState> {
  ContenedorBloc() : super(ContenedorInitial()) {
    on<GetAllContenedoresEvent>((event, emit) async {
      final response = await Api.httpGet('/getAllContainers');
      final List<Contenedor> containers =
          List<Contenedor>.from(response.map((x) => Contenedor.fromMap(x)));
      emit(state.copyWith(containers: containers));
    });

    on<SelectContainerCardEvent>((event, emit) async {
      emit(state.copyWith(cardSelectedId: event.cardSelectedId));
    });

    add(GetAllContenedoresEvent());
  }
}
