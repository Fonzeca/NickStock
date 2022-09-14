import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stock_app/api/api.dart';
import 'package:stock_app/api/models/models.dart';

part 'producto_event.dart';
part 'producto_state.dart';

class ProductoBloc extends Bloc<ProductoEvent, ProductoState> {
  List<Producto> products = [];
  bool isFiltering = false;
  String pattern = '';

  ProductoBloc() : super(ProductoInitial()) {
    on<GetAllProductosEvent>((event, emit) async {
      final response = await Api.httpGet('/getAllProducts');
      _saveProducts(response);
      emit(state.copyWith(products: products));
    });

    on<GetProductsByContainerIdEvent>((event, emit) async {
      final response =
          await Api.httpGet('/getProductsByContainerId?id=${event.id}');
      _saveProducts(response);
      emit(state.copyWith(products: products));
    });

    on<FilterProductsEvent>((event, emit) async {
      if (event.pattern.isEmpty) {
        isFiltering = false;
      }
      isFiltering = true;
      pattern = event.pattern;
      final List<Producto> filteredProducts = products
          .where((element) => element.nombre
              .toLowerCase()
              .contains(event.pattern.toLowerCase()))
          .toList();

      emit(state.copyWith(products: filteredProducts));
    });

    on<CreateProductEvent>((event, emit) async {
      await Api.httpPost(
          '/createProduct',
          Producto(
                  nombre: event.name,
                  cantidad: event.amount,
                  idContenedor: event.containerId)
              .toMap());
      add(GetAllProductosEvent());
    });

    add(GetAllProductosEvent());
  }

  _saveProducts(response) {
    final List<Producto> products =
        List<Producto>.from(response.map((x) => Producto.fromMap(x)));
    this.products = products;
    if (isFiltering) {
      add(FilterProductsEvent(pattern));
    }
  }
}
