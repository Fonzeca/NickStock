import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stock_app/producto/producto.dart';
import 'package:stock_app/widgets/widgets.dart';

class ProductView extends StatelessWidget {
  const ProductView({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final double cardHeight = (size.width * 15) / 100;
    final TextEditingController controller = TextEditingController();

    final TextEditingController nameController = TextEditingController();
    final TextEditingController amountController = TextEditingController();

    return BlocBuilder<ProductoBloc, ProductoState>(
        builder: ((context, state) => SizedBox(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                    child: CustomSearchBar(
                        controller: controller,
                        hintText: "Buscar Productos",
                        onChanged: ((pattern) => BlocProvider.of<ProductoBloc>(context).add(FilterProductsEvent(pattern)))),
                  ),
                  const SizedBox(height: 5),
                  SizedBox(
                    height: (state.products.isEmpty) ? cardHeight : (size.height * 62) / 100,
                    child: (state.products.isEmpty)
                        ? EmptyProductCard(height: cardHeight)
                        : ListView.builder(
                            padding: EdgeInsets.zero,
                            itemCount: state.products.length,
                            itemBuilder: (BuildContext context, int index) => ProductCard(
                                product: state.products[index],
                                height: cardHeight,
                                nameController: nameController,
                                amountController: amountController)),
                  ),
                ],
              ),
            )));
  }
}
