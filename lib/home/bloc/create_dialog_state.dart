part of 'create_dialog_bloc.dart';

class CreateDialogState {
  final bool isFirstTabSelected;
  final bool isValidAmount;

  CreateDialogState({required this.isFirstTabSelected, required this.isValidAmount});

  CreateDialogState copyWith({bool? isFirstTabSelected, bool? isValidAmount}) {
    return CreateDialogState(isFirstTabSelected: isFirstTabSelected ?? this.isFirstTabSelected, isValidAmount: isValidAmount ?? this.isValidAmount);
  }
}

class CreateDialogInitialState extends CreateDialogState {
  CreateDialogInitialState() : super(isFirstTabSelected: true, isValidAmount: true);
}
