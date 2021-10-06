import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:warehouse_system/helper/boxes.dart';
import 'package:warehouse_system/logic/products_logic/cubit/products_cubit.dart';
import 'package:warehouse_system/models/product.dart';
import 'package:warehouse_system/view/secondery/add_product.dart';
import 'package:warehouse_system/widgets/custom_text.dart';

// ignore: must_be_immutable
class BuyOperationView extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var quantityController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              buildAddProductField(
                  text: "اسم العميل : ",
                  controller: nameController,
                  validator: (val) {
                    if (val!.isEmpty) {
                      return "Cannot be empty";
                    } else {
                      return '';
                    }
                  }),
              buildAddProductField(
                  text: "الكمية : ",
                  controller: quantityController,
                  type: TextInputType.number,
                  validator: (val) {
                    if (val!.isNotEmpty) {
                      return '';
                    } else {
                      return "Cannot be empty";
                    }
                  }),
              BlocConsumer<ProductsCubit, ProductsState>(
                listener: (context, state) {},
                builder: (context, state) {
                  var cubit = ProductsCubit.get(context);
                  return ValueListenableBuilder<Box<Product>>(
                    valueListenable: Boxes.getProducts().listenable(),
                    builder: (context, box, child) {
                      final products = box.values.cast<Product>().toList();
                      return Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Row(
                          children: [
                            CustomText(text: "أختر منتج : "),
                            DropdownButton(
                                value: cubit.intialValue,
                                onChanged: (value) {
                                  cubit.changeDropDownValue(value);
                                },
                                items: products
                                    .map((element) => DropdownMenuItem(
                                        value: element.productName,
                                        child: CustomText(
                                          text: element.productName,
                                        )))
                                    .toList()),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
              const SizedBox(
                height: 20,
              ),
              BlocConsumer<ProductsCubit, ProductsState>(
                listener: (context, state) {},
                builder: (context, state) {
                  var cubit = ProductsCubit.get(context);
                  return ElevatedButton(
                    style: ButtonStyle(
                        shape: MaterialStateProperty.all<OutlinedBorder>(
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)))),
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        var date = DateTime.now();
                        var formatedDate = DateFormat.yMd().format(date);
                        print(formatedDate.toString());
                        cubit.addInvoice(
                            username: nameController.text,
                            productName: cubit.intialValue,
                            dateTime: formatedDate.toString(),
                            qunatity: int.parse(quantityController.text));

                        nameController.clear();
                        quantityController.clear();
                      }
                    },
                    child: CustomText(
                      text: "Add",
                      color: Colors.white,
                    ),
                  );
                },
              )
            ],
          ),
        ),
      );
    });
  }
}
