part of 'home_bloc.dart';

abstract class HomeEvent {}

class ChangeProductsTitleEvent extends HomeEvent {
  final String productsTitle;

  ChangeProductsTitleEvent(this.productsTitle);
}
