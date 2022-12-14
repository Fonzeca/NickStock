import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stock_app/contenedor/contenedor.dart';

class ContainerView extends StatelessWidget {
  const ContainerView({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final double cardWidth = (size.width * 46) / 100;
    final double height = (size.height * 24) / 100;

    return BlocBuilder<ContenedorBloc, ContenedorState>(
        builder: ((context, state) => SizedBox(
            height: height,
            child: (state.containers.isEmpty)
                ? EmptyContainerCard(
                    width: cardWidth,
                  )
                : PageView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: (state.containers.length / 2).ceil(),
                    itemBuilder: (BuildContext context, int index) {
                      return _ContainersPage(
                        height: height,
                        cardWidth: cardWidth,
                        containers: state.containers,
                        index: index * 2,
                        cardSelectedId: state.cardSelectedId,
                      );
                    }))));
  }
}

class _ContainersPage extends StatelessWidget {
  final double height;
  final double cardWidth;
  final List<dynamic> containers;
  final int index;
  final int cardSelectedId;

  const _ContainersPage({
    Key? key,
    required this.height,
    required this.cardWidth,
    required this.containers,
    required this.index,
    required this.cardSelectedId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(height: height, width: 10),
        ContainerCard(
          container: containers[index],
          width: cardWidth,
          cardSelectedId: cardSelectedId,
        ),
        SizedBox(height: height, width: 10),
        if (index + 1 < containers.length) ContainerCard(container: containers[index + 1], width: cardWidth, cardSelectedId: cardSelectedId),
      ],
    );
  }
}
