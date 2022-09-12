import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stock_app/api/api.dart';
import 'package:stock_app/api/models/models.dart';

part 'producto_event.dart';
part 'producto_state.dart';

class ProductoBloc extends Bloc<ProductoEvent, ProductoState> {
  List<Producto> products = [];

  ProductoBloc() : super(ProductoInitial()) {
    on<GetAllProductosEvent>((event, emit) async {
      final response = await Api.httpGet('/getAllProducts');
      final List<Producto> products =
          List<Producto>.from(response.map((x) => Producto.fromMap(x)));
      this.products = products;
      emit(state.copyWith(products: products));
    });

    on<GetProductsByContainerIdEvent>((event, emit) async {
      final response =
          await Api.httpGet('/getProductsByContainerId?id=${event.id}');
      final List<Producto> products =
          List<Producto>.from(response.map((x) => Producto.fromMap(x)));
      this.products = products;
      emit(state.copyWith(products: products));
    });

    on<FilterProductsEvent>((event, emit) async {
      final List<Producto> filteredProducts = products
          .where((element) => element.nombre
              .toLowerCase()
              .contains(event.pattern.toLowerCase()))
          .toList();

      emit(state.copyWith(products: filteredProducts));
    });

    add(GetAllProductosEvent());
  }
}
