part of 'create_dialog_bloc.dart';

abstract class CreateDialogEvent {}

class ChangeDialogTabEvent extends CreateDialogEvent {
  final bool isProductTabSelected;

  ChangeDialogTabEvent({required this.isProductTabSelected});
}

class ChangeAmountInputErrorEvent extends CreateDialogEvent {
  final bool isValidAmount;

  ChangeAmountInputErrorEvent({required this.isValidAmount});
}
