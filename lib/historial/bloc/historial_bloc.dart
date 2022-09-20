import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stock_app/api/api.dart';
import 'package:stock_app/api/models/models.dart';

part 'historial_state.dart';
part 'historial_event.dart';

class HistorialBloc extends Bloc<HistorialEvent, HistorialState> {
  List<Historial> historys = [];
  bool isFiltering = false;
  String pattern = '';

  HistorialBloc() : super(HistorialInit()) {
    on<GetAllHistorialesEvent>((event, emit) async {
      final response = await Api.httpGet('/getAllHistorys');
      _saveHistorys(response);
      emit(state.copyWith(historys: historys));
    });

    on<GetHistoryByContainerIdEvent>((event, emit) async {
      final response = await Api.httpGet('/getHistoryByContainerId?id=${event.id}');
      _saveHistorys(response);
      emit(state.copyWith(historys: historys));
    });

    on<FilterHistorysEvent>((event, emit) async {
      if (event.pattern.isEmpty) {
        isFiltering = false;
      }
      isFiltering = true;
      pattern = event.pattern;
      final List<Historial> filteredHistorys =
          historys.where((element) => element.nombre_producto.toLowerCase().contains(event.pattern.toLowerCase())).toList();

      emit(state.copyWith(historys: filteredHistorys));
    });

    add(GetAllHistorialesEvent());
  }
  _saveHistorys(response) {
    final List<Historial> historys = List<Historial>.from(response.map((x) => Historial.fromMap(x)));
    this.historys = historys;
    if (isFiltering) {
      add(FilterHistorysEvent(pattern));
    }
  }
}
