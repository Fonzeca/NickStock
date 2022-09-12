import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stock_app/api/api.dart';
import 'package:stock_app/contenedor/contenedor.dart';
import 'package:stock_app/historial/historial.dart';
import 'package:stock_app/home/home.dart';
import 'package:stock_app/producto/producto.dart';

import 'config/config.dart';

void main() {
  Api.configureDio();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => HomeBloc()),
        BlocProvider(create: (_) => ProductoBloc()),
        BlocProvider(create: (_) => ContenedorBloc()),
        BlocProvider(create: (_) => HistorialBloc())
      ],
      child: MaterialApp(
          builder: (context, child) {
            return ScrollConfiguration(
              behavior: CustomScrollBehaviour(),
              child: child!,
            );
          },
          title: 'Stock App',
          home: const HomeView()),
    );
  }
}
