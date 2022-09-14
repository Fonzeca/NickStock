import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stock_app/api/models/models.dart';
import 'package:stock_app/contenedor/contenedor.dart';
import 'package:stock_app/home/home.dart';
import 'package:stock_app/producto/producto.dart';

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
            children: [
              const ContainerView(),
              _ProductsTitle(productsTitle: state.productsTitle),
              const ProductView()
            ],
          ),
        ),
        floatingActionButton: CircleAvatar(
          backgroundColor: Colors.indigo[200],
          child: _CreateButton(
              nameController: nameController,
              categoryController: categoryController),
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

class _CreateButton extends StatelessWidget {
  const _CreateButton({
    Key? key,
    required this.nameController,
    required this.categoryController,
  }) : super(key: key);

  final TextEditingController nameController;
  final TextEditingController categoryController;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        showDialog(
            context: context,
            builder: ((context) {
              return BlocBuilder<CreateDialogBloc, CreateDialogState>(
                  builder: (context, state) {
                return Dialog(
                  backgroundColor: Colors.transparent,
                  child: SizedBox(
                    height: 380,
                    width: 400,
                    child: Column(
                      children: [
                        _HeaderDialog(
                            isProductTabSelected: state.isProductTabSelected),
                        _BodyDialog(
                          isProductTabSelected: state.isProductTabSelected,
                          isValidAmount: state.isValidAmount,
                          nameController: nameController,
                          categoryController: categoryController,
                        )
                      ],
                    ),
                  ),
                );
              });
            }));
      },
      icon: const Icon(Icons.add),
      color: Colors.white,
    );
  }
}

class _HeaderDialog extends StatelessWidget {
  final bool isProductTabSelected;

  const _HeaderDialog({
    Key? key,
    required this.isProductTabSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.zero,
      padding: EdgeInsets.zero,
      height: 40,
      color: Colors.transparent,
      child: Row(children: [
        _ConfirmCreationButton(
            isProductButton: true, isProductTabSelected: isProductTabSelected),
        _ConfirmCreationButton(
            isProductButton: false, isProductTabSelected: isProductTabSelected),
      ]),
    );
  }
}

class _ConfirmCreationButton extends StatelessWidget {
  final bool isProductTabSelected;
  final bool isProductButton;

  const _ConfirmCreationButton({
    Key? key,
    required this.isProductTabSelected,
    required this.isProductButton,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () {
          isProductButton
              ? BlocProvider.of<CreateDialogBloc>(context)
                  .add(ChangeDialogTabEvent(isProductTabSelected: true))
              : BlocProvider.of<CreateDialogBloc>(context)
                  .add(ChangeDialogTabEvent(isProductTabSelected: false));
        },
        style: ButtonStyle(
            minimumSize: MaterialStateProperty.all(const Size(100, 40)),
            padding: MaterialStateProperty.all(EdgeInsets.zero),
            overlayColor: MaterialStateProperty.all(Colors.white),
            shape: MaterialStateProperty.all(const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10), topRight: Radius.circular(10)),
            )),
            foregroundColor: MaterialStateProperty.all(Colors.black54),
            backgroundColor: MaterialStateProperty.all(isProductButton
                ? (isProductTabSelected
                    ? Colors.white
                    : const Color.fromARGB(255, 235, 235, 235))
                : (isProductTabSelected
                    ? const Color.fromARGB(255, 235, 235, 235)
                    : Colors.white))),
        child: isProductButton
            ? const Text("Producto")
            : const Text("Contenedor"));
  }
}

class _BodyDialog extends StatelessWidget {
  final TextEditingController amountController = TextEditingController();

  _BodyDialog({
    Key? key,
    required this.isProductTabSelected,
    required this.isValidAmount,
    required this.nameController,
    required this.categoryController,
  }) : super(key: key);

  final bool isProductTabSelected;
  final bool isValidAmount;
  final TextEditingController nameController;
  final TextEditingController categoryController;

  @override
  Widget build(BuildContext context) {
    final FocusNode _amountFocus = FocusNode();
    final List<Contenedor> containers =
        BlocProvider.of<ContenedorBloc>(context).state.containers;
    Contenedor container = containers.first;
    return Container(
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(10),
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10))),
      margin: EdgeInsets.zero,
      padding: const EdgeInsets.only(top: 20, left: 20, bottom: 5, right: 20),
      height: 320,
      child: Form(
        child: Column(
          children: [
            Text(
              isProductTabSelected
                  ? 'Crear un Producto'
                  : 'Crear un Contenedor',
              textAlign: TextAlign.center,
              style: GoogleFonts.roboto(
                  fontSize: 20,
                  color: Colors.indigo,
                  fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 20),
            if (isProductTabSelected) ...[
              const SizedBox(height: 12),
              DropdownSearch<Contenedor>(
                itemAsString: (Contenedor c) => c.nombre,
                popupProps: const PopupProps.menu(
                    fit: FlexFit.loose,
                    constraints: BoxConstraints(maxHeight: 300, minHeight: 100),
                    menuProps: MenuProps(
                      backgroundColor: Colors.white,
                    ),
                    textStyle: TextStyle(color: Colors.black54)),
                items: containers,
                selectedItem: (containers.isEmpty) ? null : containers.first,
                dropdownButtonProps:
                    const DropdownButtonProps(color: Colors.indigo),
                onChanged: (savedContainer) => container = savedContainer!,
                dropdownDecoratorProps: DropDownDecoratorProps(
                    baseStyle: const TextStyle(color: Colors.black54),
                    dropdownSearchDecoration:
                        _buildinputdecoration("Contenedor")),
              ),
            ],
            const SizedBox(height: 12),
            _CustomTextField(
                labelValue: "Nombre",
                controller: nameController,
                isAmount: false,
                isProductTabSelected: isProductTabSelected),
            const SizedBox(height: 12),
            _CustomTextField(
                labelValue: "Cantidad",
                controller: amountController,
                isAmount: true,
                isValidAmount: isValidAmount,
                isProductTabSelected: isProductTabSelected),
            if (!isProductTabSelected) ...[
              const SizedBox(height: 12),
              _CustomTextField(
                  labelValue: "Categoría",
                  controller: categoryController,
                  isAmount: false,
                  isProductTabSelected: isProductTabSelected),
            ],
            Expanded(child: Container()),
            Align(
              alignment: Alignment.bottomRight,
              child: TextButton(
                  style: ButtonStyle(
                      overlayColor:
                          MaterialStateProperty.all(Colors.indigo[50])),
                  onPressed: () async {
                    if (amountController.text.isEmpty ||
                        nameController.text.isEmpty ||
                        (!isProductTabSelected &&
                            categoryController.text.isEmpty)) return;

                    FocusManager.instance.primaryFocus?.unfocus();

                    final int? parsedAmount =
                        int.tryParse(amountController.text);

                    if (parsedAmount == null) {
                      BlocProvider.of<CreateDialogBloc>(context).add(
                          ChangeAmountInputErrorEvent(isValidAmount: false));
                      return;
                    }

                    if (isProductTabSelected) {
                      BlocProvider.of<ProductoBloc>(context).add(
                          CreateProductEvent(
                              containerId: container.id,
                              name: nameController.text,
                              amount: parsedAmount));
                      await BlocProvider.of<ProductoBloc>(context).stream.first;
                      BlocProvider.of<ContenedorBloc>(context)
                          .add(GetAllContenedoresEvent());
                    } else {
                      BlocProvider.of<ContenedorBloc>(context).add(
                          CreateContainerEvent(
                              name: nameController.text,
                              category: categoryController.text));
                    }

                    amountController.clear();
                    nameController.clear();
                    categoryController.clear();
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    "Aceptar",
                    textAlign: TextAlign.end,
                    style: GoogleFonts.roboto(
                        color: Colors.indigo, fontWeight: FontWeight.w500),
                  )),
            )
          ],
        ),
      ),
    );
  }
}

class _CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelValue;
  final bool isAmount;
  final bool? isValidAmount;
  final bool isProductTabSelected;

  const _CustomTextField({
    Key? key,
    required this.controller,
    required this.labelValue,
    required this.isAmount,
    this.isValidAmount,
    required this.isProductTabSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (!isProductTabSelected && isAmount) controller.text = '0';
    return TextField(
      readOnly: (!isProductTabSelected && isAmount) ? true : false,
      controller: controller,
      cursorColor: Colors.indigo,
      keyboardType: (isAmount) ? TextInputType.number : TextInputType.name,
      decoration:
          _buildinputdecoration(labelValue, isValidAmount: isValidAmount),
      onTap: isAmount
          ? () {
              if (!isValidAmount!) {
                BlocProvider.of<CreateDialogBloc>(context)
                    .add(ChangeAmountInputErrorEvent(isValidAmount: true));
                return;
              }
            }
          : null,
    );
  }
}

InputDecoration _buildinputdecoration(String? labelValue,
    {bool? isValidAmount}) {
  return InputDecoration(
    hintStyle: GoogleFonts.roboto(color: Colors.black54),
    enabledBorder: OutlineInputBorder(
      borderRadius: const BorderRadius.all(Radius.circular(5)),
      borderSide: BorderSide(
          color: Colors.indigo[200]!, width: 1, style: BorderStyle.solid),
    ),
    errorBorder: isValidAmount != null && !isValidAmount
        ? const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            borderSide: BorderSide(
                color: Colors.red, width: 1, style: BorderStyle.solid))
        : null,
    errorText:
        isValidAmount != null && !isValidAmount ? 'Cantidad inválida' : null,
    focusedBorder: OutlineInputBorder(
      borderRadius: const BorderRadius.all(Radius.circular(10)),
      borderSide: BorderSide(color: Colors.indigo[400]!, width: 2),
    ),
    labelText: labelValue,
    labelStyle: const TextStyle(color: Colors.black54),
    contentPadding: const EdgeInsets.all(10),
    counterText: '',
  );
}
