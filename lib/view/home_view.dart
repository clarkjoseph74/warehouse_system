import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:warehouse_system/logic/home/cubit/home_cubit.dart';
import 'package:warehouse_system/widgets/custom_text.dart';
import 'package:warehouse_system/widgets/on_hover.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = HomeCubit.get(context);
          return Row(
            children: [
              Container(
                width: width * 0.32,
                height: height,
                color: Colors.blue,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      buildListTile(
                          text: "اضف منتج",
                          onTap: () {
                            cubit.setCurrentPageIndex(0);
                          }),
                      buildListTile(
                          text: "اعرض المنتجات",
                          onTap: () {
                            cubit.setCurrentPageIndex(1);
                          }),
                      buildListTile(
                          text: "عملية بيع",
                          onTap: () {
                            cubit.setCurrentPageIndex(2);
                          }),
                      buildListTile(
                          text: "عرض الفواتير",
                          onTap: () {
                            cubit.setCurrentPageIndex(3);
                          })
                    ],
                  ),
                ),
              ),
              Expanded(
                child: cubit.screens[cubit.currentPageIndex],
              )
            ],
          );
        },
      ),
    );
  }
}

Widget buildListTile({required String text, required Function onTap}) {
  return Padding(
    padding: const EdgeInsets.all(25.0),
    child: OnHover(
      child: Container(
        decoration: BoxDecoration(
            color: Colors.blue[300], borderRadius: BorderRadius.circular(10)),
        child: GestureDetector(
          onTap: () {
            onTap();
          },
          child: ListTile(
            title: CustomText(
              text: text,
              color: Colors.white,
            ),
            trailing: Icon(
              Icons.arrow_forward_ios,
              color: Colors.white,
            ),
          ),
        ),
      ),
    ),
  );
}
