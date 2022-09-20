import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stock_app/historial/historial.dart';
import 'package:stock_app/widgets/widgets.dart';

class HistoryView extends StatelessWidget {
  const HistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final double cardHeight = (size.width * 15) / 100;
    final TextEditingController controller = TextEditingController();

    return BlocBuilder<HistorialBloc, HistorialState>(
        builder: ((context, state) => SizedBox(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                    child: CustomSearchBar(
                        controller: controller,
                        hintText: "Buscar productos",
                        onChanged: ((pattern) => BlocProvider.of<HistorialBloc>(context).add(FilterHistorysEvent(pattern)))),
                  ),
                  const SizedBox(height: 5),
                  SizedBox(
                    height: (state.historys.isEmpty) ? cardHeight : (size.height * 62) / 100,
                    child: (state.historys.isEmpty)
                        ? EmptyHistoryCard(height: cardHeight)
                        : ListView.builder(
                            padding: EdgeInsets.zero,
                            itemCount: state.historys.length,
                            itemBuilder: (BuildContext context, int index) => HistoryCard(history: state.historys[index], height: cardHeight)),
                  ),
                ],
              ),
            )));
  }
}
