part of 'products_cubit.dart';

@immutable
abstract class ProductsState {}

class ProductsInitial extends ProductsState {}

class ProductAdded extends ProductsState {}

class ProductEdit extends ProductsState {}

class ProductDeleted extends ProductsState {}

class Searching extends ProductsState {}

class InvoiceAdded extends ProductsState {}

class DropDownMenu extends ProductsState {}
