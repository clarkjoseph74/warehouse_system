import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:warehouse_system/logic/products_logic/cubit/products_cubit.dart';
import 'package:warehouse_system/widgets/custom_text.dart';
import 'package:warehouse_system/widgets/custom_text_field.dart';

// ignore: must_be_immutable
class AddProduct extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var quantityController = TextEditingController();
  var sellPriceController = TextEditingController();
  var buyPriceController = TextEditingController();
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
                  text: "اسم المنتج : ",
                  controller: nameController,
                  validator: (val) {
                    if (val!.isEmpty) {
                      return "Cannot be empty";
                    } else {
                      return '';
                    }
                  }),
              buildAddProductField(
                  text: "سعر الشراء : ",
                  controller: buyPriceController,
                  validator: (val) {
                    if (val!.isEmpty) {
                      print(val);
                      return "Cannot be empty";
                    } else {
                      return '';
                    }
                  }),
              buildAddProductField(
                  text: "سعر البيع : ",
                  controller: sellPriceController,
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
                        cubit.addProduct(
                            name: nameController.text,
                            qunatity: int.parse(quantityController.text),
                            buyPrice: double.parse(buyPriceController.text),
                            sellPrice: double.parse(sellPriceController.text));
                        nameController.clear();
                        quantityController.clear();
                        buyPriceController.clear();
                        sellPriceController.clear();
                      }
                    },
                    child: CustomText(
                      text: "Upload",
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

Widget buildAddProductField(
    {required text,
    required controller,
    required Function(String?)? validator,
    type = TextInputType.text}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 28.0, vertical: 10),
    child: Row(
      children: [
        CustomText(text: text),
        CUstomTextField(
          controller: controller,
          validator: validator!,
        )
      ],
    ),
  );
}
