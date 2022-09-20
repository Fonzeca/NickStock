part of 'home_bloc.dart';

class HomeState {
  final String title;
  final bool isInHistory;

  HomeState({required this.title, required this.isInHistory});

  HomeState copyWith({String? title, bool? isInHistory}) {
    return HomeState(title: title ?? this.title, isInHistory: isInHistory ?? this.isInHistory);
  }
}

class HomeInitialState extends HomeState {
  HomeInitialState() : super(title: 'Todos los Productos', isInHistory: false);
}
