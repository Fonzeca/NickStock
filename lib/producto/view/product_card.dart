import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stock_app/api/models/models.dart';
import 'package:stock_app/contenedor/contenedor.dart';
import 'package:stock_app/home/home.dart';
import 'package:stock_app/producto/producto.dart';
import 'package:stock_app/widgets/widgets.dart';

class ProductCard extends StatelessWidget {
  final Producto product;
  final double height;

  final TextEditingController nameController;
  final TextEditingController amountController;

  ProductCard({super.key, required this.product, required this.height, required this.amountController, required this.nameController});

  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: Key(product.id.toString()),
      endActionPane: ActionPane(
        motion: ScrollMotion(),
        children: [
          SlidableAction(
            flex: 2,
            onPressed: ((context) {
              nameController.text = product.cantidad.toString();
              showDialog(
                  context: context,
                  builder: (BuildContext context) => BlocBuilder<CreateDialogBloc, CreateDialogState>(
                      builder: (context, state) => CustomDialog(
                            isFirstTabSelected: state.isFirstTabSelected,
                            firstTabText: "Añadir",
                            secondTabText: "Remover",
                            tabTitle: state.isFirstTabSelected ? 'Añadir stock a ${product.nombre}' : 'Remover stock a ${product.nombre}',
                            bodyInputs: [
                              const SizedBox(height: 12),
                              CustomTextField(
                                labelValue: "Stock actual",
                                isAmount: true,
                                enabled: false,
                                controller: nameController,
                              ),
                              const SizedBox(height: 12),
                              CustomTextField(
                                labelValue: state.isFirstTabSelected ? "Cantidad a añadir" : "Cantidad a remover",
                                controller: amountController,
                                isAmount: true,
                                isValidAmount: state.isValidAmount,
                                enabled: true,
                              ),
                              Expanded(child: Container()),
                            ],
                            onAcceptPressed: () async {
                              if (nameController.text.isEmpty) return;

                              FocusManager.instance.primaryFocus?.unfocus();

                              final int? parsedAmount = int.tryParse(amountController.text);

                              if (parsedAmount == null || parsedAmount < 0 || (parsedAmount == 0)) {
                                BlocProvider.of<CreateDialogBloc>(context).add(ChangeAmountInputErrorEvent(isValidAmount: false));
                                return;
                              }

                              if (state.isFirstTabSelected)
                                BlocProvider.of<ProductoBloc>(context).add(AddProductStockById(id: product.id!, amount: parsedAmount));
                              else
                                BlocProvider.of<ProductoBloc>(context).add(RemoveProductStockById(id: product.id!, amount: parsedAmount));

                              await BlocProvider.of<ProductoBloc>(context).stream.first;

                              BlocProvider.of<ContenedorBloc>(context).add(GetAllContenedoresEvent());

                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                content: Text('Cantidad añadida'),
                                backgroundColor: Colors.indigo,
                              ));

                              amountController.clear();
                              nameController.clear();
                              Navigator.of(context).pop();
                            },
                          )));
            }),
            backgroundColor: Colors.indigo,
            foregroundColor: Colors.white,
            icon: Icons.inventory_2_outlined,
          ),
          SlidableAction(
            onPressed: ((context) async {
              BlocProvider.of<ProductoBloc>(context).add(DeleteProductEvent(product.id!));

              await BlocProvider.of<ProductoBloc>(context).stream.first;

              BlocProvider.of<ContenedorBloc>(context).add(GetAllContenedoresEvent());

              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text('${product.nombre} eliminado'),
                backgroundColor: Colors.red,
              ));
            }),
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            icon: Icons.delete,
          ),
        ],
      ),
      child: Card(
          color: Colors.indigo[50]!.withOpacity(0.4),
          surfaceTintColor: Colors.transparent,
          shadowColor: Colors.transparent,
          elevation: 0,
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
          child: Container(
              alignment: Alignment.center,
              height: height,
              padding: const EdgeInsets.all(10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    alignment: Alignment.topLeft,
                    width: 130,
                    child: Text(
                      product.nombre,
                      style: GoogleFonts.roboto(fontWeight: FontWeight.w500, fontSize: 14, color: Colors.black54),
                    ),
                  ),
                  const SizedBox(height: 22),
                  CustomDetails(
                      label: "Contenedor",
                      labelValue: product.nombreContenedor ?? '',
                      icon: const Icon(
                        Icons.business_center_outlined,
                        color: Colors.black38,
                        size: 30,
                      )),
                  const SizedBox(
                    width: 20,
                  ),
                  CustomDetails(
                      label: "Cantidad",
                      labelValue: product.cantidad.toString(),
                      icon: const Icon(
                        Icons.inventory_2_outlined,
                        color: Colors.black38,
                        size: 30,
                      )),
                ],
              ))),
    );
  }
}
