import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:warehouse_system/logic/products_logic/cubit/products_cubit.dart';
import 'package:warehouse_system/models/product.dart';
import 'package:warehouse_system/view/secondery/add_product.dart';
import 'package:warehouse_system/widgets/custom_text.dart';

// ignore: must_be_immutable
class EditProduct extends StatelessWidget {
  final Product product;
  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var quantityController = TextEditingController();
  var sellPriceController = TextEditingController();
  var buyPriceController = TextEditingController();

  EditProduct({required this.product});
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(),
        body: Padding(
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
                          cubit.editProduct(
                              product: product,
                              name: nameController.text,
                              qunatity: int.parse(quantityController.text),
                              buyPrice: double.parse(buyPriceController.text),
                              sellPrice:
                                  double.parse(sellPriceController.text));
                          Navigator.pop(context);
                        }
                      },
                      child: CustomText(
                        text: "Edit",
                        color: Colors.white,
                      ),
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
