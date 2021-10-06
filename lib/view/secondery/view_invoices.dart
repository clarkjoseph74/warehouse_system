import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:warehouse_system/helper/boxes.dart';
import 'package:warehouse_system/logic/products_logic/cubit/products_cubit.dart';
import 'package:warehouse_system/models/invoice.dart';

import 'package:warehouse_system/widgets/custom_text.dart';
import 'package:warehouse_system/widgets/custom_text_field.dart';

// ignore: must_be_immutable
class ViewInvoices extends StatelessWidget {
  var searchController = TextEditingController();
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
            return ValueListenableBuilder<Box<Invoice>>(
              valueListenable: Boxes.getInvoices().listenable(),
              builder: (context, box, child) {
                final invoices =
                    box.values.toList().cast<Invoice>().reversed.toList();

                return Scrollbar(
                  isAlwaysShown: true,
                  interactive: true,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            CustomText(
                              text: "أجمالي الدخل : ",
                              size: 22,
                            ),
                            CustomText(
                              text: cubit.totalRevenue.toString(),
                              color: Colors.green,
                              size: 22,
                            ),
                          ],
                        ),
                        CUstomTextField(
                          width: MediaQuery.of(context).size.width,
                          controller: searchController,
                          hint: "بــحـث",
                          validator: (val) {},
                          onChange: (val) {
                            cubit.searchInvoice(
                                searchController.text, invoices);
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
                                                  text: "أسم ألعميل : ",
                                                  size: 20,
                                                  color: Colors.blue,
                                                ),
                                                CustomText(
                                                  text: cubit.invoiceSearchedList
                                                              .length ==
                                                          0
                                                      ? invoices[index].username
                                                      : cubit
                                                          .invoiceSearchedList[
                                                              index]
                                                          .username,
                                                  size: 20,
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                CustomText(
                                                  text: "أسم المنتج : ",
                                                  size: 20,
                                                  color: Colors.blue,
                                                ),
                                                CustomText(
                                                  text: cubit.invoiceSearchedList
                                                              .length ==
                                                          0
                                                      ? invoices[index]
                                                          .productName
                                                          .toString()
                                                      : cubit
                                                          .invoiceSearchedList[
                                                              index]
                                                          .productName,
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
                                                  text: cubit.invoiceSearchedList
                                                              .length ==
                                                          0
                                                      ? invoices[index].dateTime
                                                      : cubit
                                                          .invoiceSearchedList[
                                                              index]
                                                          .dateTime,
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
                                                  text: cubit.invoiceSearchedList
                                                              .length ==
                                                          0
                                                      ? invoices[index]
                                                          .quantity
                                                          .toString()
                                                      : cubit
                                                          .invoiceSearchedList[
                                                              index]
                                                          .quantity
                                                          .toString(),
                                                  size: 20,
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                CustomText(
                                                  text: "صافي الربح : ",
                                                  size: 20,
                                                  color: Colors.blue,
                                                ),
                                                Row(
                                                  children: [
                                                    CustomText(
                                                      text: cubit.invoiceSearchedList
                                                                  .length ==
                                                              0
                                                          ? invoices[index]
                                                              .profit
                                                              .toString()
                                                          : cubit
                                                              .invoiceSearchedList[
                                                                  index]
                                                              .profit
                                                              .toString(),
                                                      size: 20,
                                                    ),
                                                    CustomText(
                                                        size: 20,
                                                        color:
                                                            Colors.lightGreen,
                                                        text: " جنية مصر  ")
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        Spacer(),
                                        Padding(
                                          padding: const EdgeInsets.all(28.0),
                                          child: IconButton(
                                              onPressed: () {
                                                cubit.deleteInvoice(cubit
                                                            .invoiceSearchedList
                                                            .length ==
                                                        0
                                                    ? invoices[index]
                                                    : cubit.invoiceSearchedList[
                                                        index]);
                                              },
                                              icon: Icon(
                                                Icons.delete,
                                                color: Colors.red,
                                                size: 30,
                                              )),
                                        )
                                      ],
                                    ),
                                  )),
                              itemCount: cubit.invoiceSearchedList.length == 0
                                  ? invoices.length
                                  : cubit.invoiceSearchedList.length),
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
}
