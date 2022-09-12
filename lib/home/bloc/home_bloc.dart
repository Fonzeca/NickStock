import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitialState()) {
    on<ChangeProductsTitleEvent>(((event, emit) {
      emit(state.copyWith(productsTitle: event.productsTitle));
    }));
  }
}
