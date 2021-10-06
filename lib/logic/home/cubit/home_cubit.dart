import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:warehouse_system/view/secondery/add_product.dart';
import 'package:warehouse_system/view/secondery/buy_operation_view.dart';
import 'package:warehouse_system/view/secondery/view_invoices.dart';
import 'package:warehouse_system/view/secondery/view_products.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  static HomeCubit get(BuildContext context) => BlocProvider.of(context);

  int currentPageIndex = 0;
  List<Widget> screens = [
    AddProduct(),
    ViewProducts(),
    BuyOperationView(),
    ViewInvoices(),
  ];
  setCurrentPageIndex(int index) {
    currentPageIndex = index;
    print(index);
    emit(ChangeScreen());
  }
}
