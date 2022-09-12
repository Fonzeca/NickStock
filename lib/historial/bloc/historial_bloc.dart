import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stock_app/api/api.dart';
import 'package:stock_app/api/models/models.dart';

part 'historial_state.dart';
part 'historial_event.dart';

class HistorialBloc extends Bloc<HistorialEvent, HistorialState> {
  HistorialBloc() : super(HistorialInit()) {
    on<GetAllHistorialesEvent>((event, emit) async {
      final response = await Api.httpGet('/getAllContainers');
      final List<Historial> historys =
          response.map((history) => Historial.fromMap(history));
      emit(state.copyWith(historys: historys));
    });

    add(GetAllHistorialesEvent());
  }
}
