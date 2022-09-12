import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stock_app/contenedor/contenedor.dart';
import 'package:stock_app/home/home.dart';
import 'package:stock_app/producto/producto.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
      return Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const ContainerView(),
              _ProductsTitle(productsTitle: state.productsTitle),
              const ProductView()
            ],
          ),
        ),
      );
    });
  }
}

class _ProductsTitle extends StatelessWidget {
  final String productsTitle;

  const _ProductsTitle({
    Key? key,
    required this.productsTitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.indigo[100]!.withOpacity(0.4),
      ),
      alignment: Alignment.center,
      height: 40,
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 6),
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: Text(productsTitle,
          style: GoogleFonts.roboto(
              fontSize: 20,
              fontWeight: FontWeight.w400,
              color: Colors.black54)),
    );
  }
}
