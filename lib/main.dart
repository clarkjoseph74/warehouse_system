import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:warehouse_system/logic/home/cubit/home_cubit.dart';
import 'package:warehouse_system/logic/products_logic/cubit/products_cubit.dart';
import 'package:warehouse_system/models/invoice.dart';
import 'package:warehouse_system/models/product.dart';
import 'package:warehouse_system/view/home_view.dart';
import 'package:warehouse_system/view/splash.dart';

Future<void> main() async {
  debugDefaultTargetPlatformOverride = TargetPlatform.fuchsia;
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(ProductAdapter());
  Hive.registerAdapter(InvoiceAdapter());
  await Hive.openBox<Product>('products');
  await Hive.openBox<Invoice>('invoices');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => HomeCubit(),
        ),
        BlocProvider(
          create: (context) => ProductsCubit(),
        ),
      ],
      child: MaterialApp(
        title: 'Warehouse System',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Directionality(
            textDirection: TextDirection.rtl, child: SplashScreen()),
      ),
    );
  }
}
