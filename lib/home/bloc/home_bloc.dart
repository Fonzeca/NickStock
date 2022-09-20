import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitialState()) {
    on<ChangeTitleEvent>(((event, emit) {
      emit(state.copyWith(title: event.title));
    }));

    on<ChangeToHistoryEvent>(((event, emit) {
      emit(state.copyWith(isInHistory: event.isInHistory));
    }));
  }
}
