part of 'create_dialog_bloc.dart';

abstract class CreateDialogEvent {}

class ChangeDialogTabEvent extends CreateDialogEvent {
  final bool isFirstTabSelected;

  ChangeDialogTabEvent({required this.isFirstTabSelected});
}

class ChangeAmountInputErrorEvent extends CreateDialogEvent {
  final bool isValidAmount;

  ChangeAmountInputErrorEvent({required this.isValidAmount});
}
