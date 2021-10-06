import 'package:hive_flutter/hive_flutter.dart';
import 'package:warehouse_system/models/invoice.dart';
import 'package:warehouse_system/models/product.dart';

class Boxes {
  static Box<Product> getProducts() => Hive.box<Product>('products');
  static Box<Invoice> getInvoices() => Hive.box<Invoice>('invoices');
}
