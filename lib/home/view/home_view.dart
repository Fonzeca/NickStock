import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stock_app/api/models/models.dart';
import 'package:stock_app/contenedor/contenedor.dart';
import 'package:stock_app/home/home.dart';
import 'package:stock_app/producto/producto.dart';
import 'package:stock_app/widgets/widgets.dart';

class HomeView extends StatelessWidget {
  HomeView({super.key});

  final TextEditingController nameController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
      return Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [const ContainerView(), _ProductsTitle(productsTitle: state.productsTitle), const ProductView()],
          ),
        ),
        floatingActionButton: CircleAvatar(
          backgroundColor: Colors.indigo[200],
          child: _CreateButton(nameController: nameController, categoryController: categoryController),
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
          softWrap: false, overflow: TextOverflow.fade, style: GoogleFonts.roboto(fontSize: 20, fontWeight: FontWeight.w400, color: Colors.black54)),
    );
  }
}

class _CreateButton extends StatelessWidget {
  _CreateButton({
    Key? key,
    required this.nameController,
    required this.categoryController,
  }) : super(key: key);

  final TextEditingController nameController;
  final TextEditingController categoryController;
  final TextEditingController amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        amountController.text = '0';
        showDialog(
            context: context,
            builder: ((context) => BlocBuilder<CreateDialogBloc, CreateDialogState>(builder: (context, state) {
                  final List<Contenedor> containers = BlocProvider.of<ContenedorBloc>(context).state.containers;
                  Contenedor? selectedContainer;
                  bool isFirstTabSelected = state.isFirstTabSelected;
                  if (containers.isEmpty) {
                    isFirstTabSelected = false;
                  } else {
                    selectedContainer = containers.first;
                  }
                  return CustomDialog(
                      isFirstTabSelected: isFirstTabSelected,
                      firstTabText: "Producto",
                      secondTabText: "Contenedor",
                      tabTitle: isFirstTabSelected ? "Crear un producto" : "Crear un contenedor",
                      bodyInputs: [
                        if (isFirstTabSelected) ...[
                          const SizedBox(height: 12),
                          DropdownSearch<Contenedor>(
                            itemAsString: (Contenedor c) => c.nombre,
                            popupProps: const PopupProps.menu(
                                fit: FlexFit.loose,
                                constraints: BoxConstraints(maxHeight: 300, minHeight: 50),
                                menuProps: MenuProps(
                                  backgroundColor: Colors.white,
                                ),
                                textStyle: TextStyle(color: Colors.black54)),
                            items: containers,
                            selectedItem: (containers.isEmpty) ? null : containers.first,
                            dropdownButtonProps: const DropdownButtonProps(color: Colors.indigo),
                            onChanged: (savedContainer) => selectedContainer = savedContainer!,
                            dropdownDecoratorProps: DropDownDecoratorProps(
                                baseStyle: const TextStyle(color: Colors.black54), dropdownSearchDecoration: buildinputdecoration("Contenedor")),
                          ),
                        ],
                        const SizedBox(height: 12),
                        CustomTextField(labelValue: "Nombre", controller: nameController, isAmount: false),
                        const SizedBox(height: 12),
                        CustomTextField(
                          labelValue: "Cantidad",
                          controller: amountController,
                          isAmount: true,
                          isValidAmount: state.isValidAmount,
                          enabled: isFirstTabSelected ? true : false,
                        ),
                        if (!isFirstTabSelected) ...[
                          const SizedBox(height: 12),
                          CustomTextField(labelValue: "Categoría", controller: categoryController, isAmount: false),
                        ],
                        Expanded(child: Container())
                      ],
                      onAcceptPressed: () async {
                        if (amountController.text.isEmpty || nameController.text.isEmpty || (!isFirstTabSelected && categoryController!.text.isEmpty))
                          return;

                        FocusManager.instance.primaryFocus?.unfocus();

                        final int? parsedAmount = int.tryParse(amountController.text);

                        if (parsedAmount == null || parsedAmount < 0) {
                          BlocProvider.of<CreateDialogBloc>(context).add(ChangeAmountInputErrorEvent(isValidAmount: false));
                          return;
                        }

                        if (isFirstTabSelected) {
                          BlocProvider.of<ProductoBloc>(context)
                              .add(CreateProductEvent(containerId: selectedContainer!.id, name: nameController.text, amount: parsedAmount));

                          await BlocProvider.of<ProductoBloc>(context).stream.first;

                          BlocProvider.of<ContenedorBloc>(context).add(GetAllContenedoresEvent());
                        } else {
                          BlocProvider.of<ContenedorBloc>(context)
                              .add(CreateContainerEvent(name: nameController.text, category: categoryController.text));
                        }

                        amountController.clear();
                        nameController.clear();
                        categoryController.clear();
                        Navigator.of(context).pop();
                      });
                })));
      },
      icon: const Icon(Icons.add),
      color: Colors.white,
    );
  }
}
