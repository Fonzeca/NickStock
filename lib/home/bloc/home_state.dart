part of 'home_bloc.dart';

class HomeState {
  final String productsTitle;

  HomeState({required this.productsTitle});

  HomeState copyWith({String? productsTitle}) {
    return HomeState(productsTitle: productsTitle ?? this.productsTitle);
  }
}

class HomeInitialState extends HomeState {
  HomeInitialState() : super(productsTitle: 'Todos los Productos');
}
