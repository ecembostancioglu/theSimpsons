import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
              child: Image.asset('assets/images/background.png',
              fit: BoxFit.cover)),
          Align(
            alignment: Alignment.topCenter,
            child: Image.asset('assets/images/logo.png',
            width: 250.w),
          ),
        ],
      ),
    );
  }
}
