import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:warehouse_system/view/home_view.dart';
import 'package:warehouse_system/widgets/custom_text.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  navigateTo() async {
    Future.delayed(Duration(seconds: 5))
        .then((value) => Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => Directionality(
                  textDirection: TextDirection.rtl, child: HomeView()),
            )));
  }

  @override
  void initState() {
    navigateTo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.blue[300],
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              LottieBuilder.asset(
                'assets/warehouse.json',
                height: 200,
                width: 200,
              ),
              CustomText(
                text: "Welcome To System",
                size: 40,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
