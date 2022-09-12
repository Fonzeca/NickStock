part of 'producto_bloc.dart';

class ProductoState {
  final List<Producto> products;

  const ProductoState({required this.products});

  ProductoState copyWith({List<Producto>? products}) {
    return ProductoState(products: products ?? this.products);
  }
}

class ProductoInitial extends ProductoState {
  ProductoInitial() : super(products: []);
}
