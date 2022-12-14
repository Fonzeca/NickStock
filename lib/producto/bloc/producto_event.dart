part of 'producto_bloc.dart';

abstract class ProductoEvent {
  const ProductoEvent();
}

class GetAllProductosEvent extends ProductoEvent {}

class GetProductsByContainerIdEvent extends ProductoEvent {
  final int id;

  GetProductsByContainerIdEvent(this.id);
}

class FilterProductsEvent extends ProductoEvent {
  final String pattern;

  FilterProductsEvent(this.pattern);
}

class CreateProductEvent extends ProductoEvent {
  final String name;
  final int amount;
  final int containerId;

  CreateProductEvent({required this.name, required this.amount, required this.containerId});
}

class DeleteProductEvent extends ProductoEvent {
  final int id;

  DeleteProductEvent(this.id);
}

class AddProductStockById extends ProductoEvent {
  final int id;
  final int amount;

  AddProductStockById({required this.id, required this.amount});
}

class RemoveProductStockById extends ProductoEvent {
  final int id;
  final int amount;

  RemoveProductStockById({required this.id, required this.amount});
}
