import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:warehouse_system/helper/boxes.dart';
import 'package:warehouse_system/models/invoice.dart';
import 'package:warehouse_system/models/product.dart';

part 'products_state.dart';

class ProductsCubit extends Cubit<ProductsState> {
  ProductsCubit() : super(ProductsInitial()) {
    getTotalRev();
  }
  static ProductsCubit get(BuildContext context) => BlocProvider.of(context);

  Future addProduct(
      {required String name,
      required int qunatity,
      required double buyPrice,
      required double sellPrice}) async {
    final product = Product()
      ..productName = name
      ..quantity = qunatity
      ..buyPrice = buyPrice
      ..sellPtice = sellPrice;

    final productBox = Boxes.getProducts();
    productBox.add(product);

    emit(ProductAdded());
  }

  Future editProduct(
      {required Product product,
      required String name,
      required int qunatity,
      required double buyPrice,
      required double sellPrice}) async {
    product.productName = name;
    product.quantity = qunatity;
    product.buyPrice = buyPrice;
    product.sellPtice = sellPrice;
    // final box = Boxes.getProducts();
    // box.put(product.key, product);
    product.save();

    emit(ProductEdit());
  }

  void deleteProduct({required Product product}) {
    product.delete();
    emit(ProductDeleted());
  }

  List<Product> searchedList = [];
  void search(text, List<Product> list) {
    searchedList = [];
    list.forEach((element) {
      if (element.productName.contains(text)) {
        searchedList.add(element);
      }
    });
    emit(Searching());
  }

  List<Invoice> invoiceSearchedList = [];
  void searchInvoice(text, List<Invoice> list) {
    invoiceSearchedList = [];
    list.forEach((element) {
      if (element.username.contains(text)) {
        invoiceSearchedList.add(element);
      }
    });
    emit(Searching());
  }

  Future addInvoice({
    required String username,
    required String productName,
    required String dateTime,
    required int qunatity,
  }) async {
    late Product product;
    final productBox = Boxes.getProducts();
    productBox.values.forEach((element) {
      if (element.productName == productName) {
        product = element;
      }
    });

    final invoice = Invoice()
      ..productName = product.productName
      ..quantity = qunatity
      ..username = username
      ..dateTime = dateTime
      ..profit = (product.sellPtice - product.buyPrice) * qunatity;
    print("Invoice Added");
    final invoiceBox = Boxes.getInvoices();
    invoiceBox.add(invoice);
    getTotalRev();
    emit(InvoiceAdded());
  }

  void deleteInvoice(Invoice invoice) {
    invoice.delete();
    emit(ProductDeleted());
  }

  double totalRevenue = 0;
  getTotalRev() {
    totalRevenue = 0;
    final invoices = Boxes.getInvoices();
    invoices.values.forEach((element) {
      totalRevenue += element.profit;
    });
  }

  var intialValue;
  changeDropDownValue(Object? val) {
    intialValue = val;
    emit(DropDownMenu());
  }
}
