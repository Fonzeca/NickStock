part of 'create_dialog_bloc.dart';

class CreateDialogState {
  final bool isProductTabSelected;
  final bool isValidAmount;

  CreateDialogState(
      {required this.isProductTabSelected, required this.isValidAmount});

  CreateDialogState copyWith(
      {bool? isProductTabSelected, bool? isValidAmount}) {
    return CreateDialogState(
        isProductTabSelected: isProductTabSelected ?? this.isProductTabSelected,
        isValidAmount: isValidAmount ?? this.isValidAmount);
  }
}

class CreateDialogInitialState extends CreateDialogState {
  CreateDialogInitialState()
      : super(isProductTabSelected: true, isValidAmount: true);
}
