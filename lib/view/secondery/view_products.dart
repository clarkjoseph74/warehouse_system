import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:warehouse_system/helper/boxes.dart';
import 'package:warehouse_system/logic/products_logic/cubit/products_cubit.dart';
import 'package:warehouse_system/models/product.dart';
import 'package:warehouse_system/view/secondery/edit_product.dart';
import 'package:warehouse_system/widgets/custom_text.dart';
import 'package:warehouse_system/widgets/custom_text_field.dart';

class ViewProducts extends StatelessWidget {
  var searchController = TextEditingController(text: "");
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(28.0),
      child: Container(
        child: Center(
            child: BlocConsumer<ProductsCubit, ProductsState>(
          listener: (context, state) {},
          builder: (context, state) {
            var cubit = ProductsCubit.get(context);
            return ValueListenableBuilder<Box<Product>>(
              valueListenable: Boxes.getProducts().listenable(),
              builder: (context, box, child) {
                final products =
                    box.values.toList().cast<Product>().reversed.toList();
                return Scrollbar(
                  isAlwaysShown: true,
                  interactive: true,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        CUstomTextField(
                          width: MediaQuery.of(context).size.width,
                          controller: searchController,
                          hint: "بــحـث",
                          validator: (val) {},
                          onChange: (val) {
                            cubit.search(searchController.text, products);
                          },
                        ),
                        Expanded(
                          child: ListView.separated(
                              separatorBuilder: (context, index) {
                                return const SizedBox(
                                  height: 20,
                                );
                              },
                              itemBuilder: (context, index) => Container(
                                  decoration: BoxDecoration(
                                      color: Colors.grey[200],
                                      borderRadius: BorderRadius.circular(15)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                CustomText(
                                                  text: "أسم المنتج : ",
                                                  size: 20,
                                                  color: Colors.blue,
                                                ),
                                                CustomText(
                                                  text: cubit.searchedList
                                                              .length ==
                                                          0
                                                      ? products[index]
                                                          .productName
                                                      : cubit
                                                          .searchedList[index]
                                                          .productName,
                                                  size: 20,
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                CustomText(
                                                  text: "سعر الشراء : ",
                                                  size: 20,
                                                  color: Colors.blue,
                                                ),
                                                CustomText(
                                                  text: cubit.searchedList
                                                              .length ==
                                                          0
                                                      ? products[index]
                                                          .buyPrice
                                                          .toString()
                                                      : cubit
                                                          .searchedList[index]
                                                          .buyPrice
                                                          .toString(),
                                                  size: 20,
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                CustomText(
                                                  text: "سعر البيع : ",
                                                  size: 20,
                                                  color: Colors.blue,
                                                ),
                                                CustomText(
                                                  text: cubit.searchedList
                                                              .length ==
                                                          0
                                                      ? products[index]
                                                          .sellPtice
                                                          .toString()
                                                      : cubit
                                                          .searchedList[index]
                                                          .sellPtice
                                                          .toString(),
                                                  size: 20,
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                CustomText(
                                                  text: "الكمية : ",
                                                  size: 20,
                                                  color: Colors.blue,
                                                ),
                                                CustomText(
                                                  text: cubit.searchedList
                                                              .length ==
                                                          0
                                                      ? products[index]
                                                          .quantity
                                                          .toString()
                                                      : cubit
                                                          .searchedList[index]
                                                          .quantity
                                                          .toString(),
                                                  size: 20,
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        Spacer(),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 18.0),
                                          child: Row(
                                            children: [
                                              IconButton(
                                                  onPressed: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) => EditProduct(
                                                              product: cubit
                                                                          .searchedList
                                                                          .length ==
                                                                      0
                                                                  ? products[
                                                                      index]
                                                                  : cubit.searchedList[
                                                                      index]),
                                                        ));
                                                  },
                                                  icon: Icon(
                                                    Icons.edit,
                                                    size: 34,
                                                    color: Colors.blue,
                                                  )),
                                              BlocConsumer<ProductsCubit,
                                                  ProductsState>(
                                                listener: (context, state) {},
                                                builder: (context, state) {
                                                  var cubit = ProductsCubit.get(
                                                      context);
                                                  return IconButton(
                                                      onPressed: () {
                                                        cubit.deleteProduct(
                                                            product: cubit
                                                                        .searchedList
                                                                        .length ==
                                                                    0
                                                                ? products[
                                                                    index]
                                                                : cubit.searchedList[
                                                                    index]);
                                                      },
                                                      icon: Icon(
                                                        Icons.delete,
                                                        size: 34,
                                                        color: Colors.red,
                                                      ));
                                                },
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  )),
                              itemCount: cubit.searchedList.length == 0
                                  ? products.length
                                  : cubit.searchedList.length),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        )),
      ),
    );
  }

  // getProfitRate({required double buyNumber, required double sellNumber}) {
  //   var regex = RegExp(r"([.]*0)(?!.*\d)");
  //   var result = (((sellNumber - buyNumber) / buyNumber) * 100)
  //       .toString()
  //       .replaceAll(regex, '');
  //   return result;
  // }
}
