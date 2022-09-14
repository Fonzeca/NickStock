import 'package:flutter_bloc/flutter_bloc.dart';

part 'create_dialog_event.dart';
part 'create_dialog_state.dart';

class CreateDialogBloc extends Bloc<CreateDialogEvent, CreateDialogState> {
  CreateDialogBloc() : super(CreateDialogInitialState()) {
    on<ChangeDialogTabEvent>(((event, emit) {
      emit(state.copyWith(isProductTabSelected: event.isProductTabSelected));
    }));

    on<ChangeAmountInputErrorEvent>(((event, emit) {
      emit(state.copyWith(isValidAmount: event.isValidAmount));
    }));
  }
}
