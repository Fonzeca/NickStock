import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stock_app/api/models/models.dart';
import 'package:stock_app/contenedor/contenedor.dart';
import 'package:stock_app/historial/historial.dart';
import 'package:stock_app/home/home.dart';
import 'package:stock_app/producto/producto.dart';
import 'package:stock_app/widgets/widgets.dart';

class ContainerCard extends StatelessWidget {
  final Contenedor container;
  final double width;
  final int cardSelectedId;

  const ContainerCard({super.key, required this.container, required this.width, required this.cardSelectedId});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (() {
        final HomeBloc homeBloc = BlocProvider.of<HomeBloc>(context);
        final HistorialBloc historialBloc = BlocProvider.of<HistorialBloc>(context);
        final ProductoBloc productoBloc = BlocProvider.of<ProductoBloc>(context);

        if (cardSelectedId == container.id) {
          BlocProvider.of<ContenedorBloc>(context).add(SelectContainerCardEvent(-1));
          if (homeBloc.state.isInHistory) {
            homeBloc.add(ChangeTitleEvent('Todo el Historial'));
            historialBloc.add(GetAllHistorialesEvent());
          } else {
            homeBloc.add(ChangeTitleEvent('Todos los Productos'));
            productoBloc.add(GetAllProductosEvent());
          }
          return;
        }

        BlocProvider.of<ContenedorBloc>(context).add(SelectContainerCardEvent(container.id));
        if (homeBloc.state.isInHistory) {
          homeBloc.add(ChangeTitleEvent('Historial de ${container.nombre}'));
          historialBloc.add(GetHistoryByContainerIdEvent(container.id));
        } else {
          homeBloc.add(ChangeTitleEvent('Productos en ${container.nombre}'));
          productoBloc.add(GetProductsByContainerIdEvent(container.id));
        }
      }),
      child: Card(
        shape: cardSelectedId == container.id
            ? RoundedRectangleBorder(side: BorderSide(color: Colors.indigo[100]!, width: 2), borderRadius: const BorderRadius.all(Radius.circular(5)))
            : null,
        elevation: 2,
        margin: const EdgeInsets.only(top: 32, bottom: 10),
        color: Colors.indigo[50],
        child: Container(
          width: width,
          padding: const EdgeInsets.all(10),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.end, children: [
            Text(
              container.nombre,
              maxLines: 1,
              softWrap: false,
              overflow: TextOverflow.fade,
              style: GoogleFonts.roboto(fontWeight: FontWeight.w400, fontSize: 16, color: Colors.black54),
            ),
            const SizedBox(height: 35),
            Container(
              alignment: Alignment.bottomLeft,
              child: Column(
                children: [
                  CustomDetails(
                    label: "Categoría",
                    labelValue: container.categoria,
                    icon: Icon(
                      Icons.tag,
                      size: 30,
                      color: Colors.indigo[200],
                    ),
                  ),
                  const SizedBox(height: 10),
                  CustomDetails(
                    label: "Cantidad",
                    labelValue: '${container.cantidad}',
                    icon: Icon(
                      Icons.inventory_2_outlined,
                      size: 30,
                      color: Colors.indigo[200],
                    ),
                  ),
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
