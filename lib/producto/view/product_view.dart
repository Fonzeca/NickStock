import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stock_app/producto/producto.dart';

class ProductView extends StatelessWidget {
  const ProductView({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final double cardHeight = (size.width * 15) / 100;
    final TextEditingController _controller = TextEditingController();

    return BlocBuilder<ProductoBloc, ProductoState>(
        builder: ((context, state) => Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                  child: _SearchProductsField(controller: _controller),
                ),
                const SizedBox(height: 5),
                Flexible(
                  fit: FlexFit.loose,
                  child: ListView.builder(
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      itemCount: state.products.length,
                      itemBuilder: (BuildContext context, int index) =>
                          ProductCard(
                              product: state.products[index],
                              height: cardHeight)),
                ),
              ],
            )));
  }
}

class _SearchProductsField extends StatelessWidget {
  const _SearchProductsField({
    Key? key,
    required TextEditingController controller,
  })  : _controller = controller,
        super(key: key);

  final TextEditingController _controller;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      onChanged: ((pattern) => BlocProvider.of<ProductoBloc>(context)
          .add(FilterProductsEvent(pattern))),
      decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(
                color: Colors.indigo[200]!, width: 2, style: BorderStyle.solid),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(color: Colors.indigo[400]!, width: 2),
          ),
          hintText: "Buscar productos",
          contentPadding: const EdgeInsets.all(10),
          counterText: '',
          suffixIcon: Icon(Icons.search_outlined, color: Colors.indigo[200])),
      maxLength: 15,
      maxLines: 1,
    );
  }
}
