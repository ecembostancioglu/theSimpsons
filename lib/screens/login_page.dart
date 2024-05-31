import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thesimpsons/constants/constants.dart';
import 'package:thesimpsons/constants/text_constants.dart';

import '../widgets/textform_widget.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
              child: Image.asset(background,
              fit: BoxFit.cover)),

          Align(
            alignment: Alignment.topCenter,
            child: Image.asset(logo,
            width: 250.w),
          ),
          Form(
            key: _formKey,
            child: ListView(
              children: [
                SizedBox(height: 400.w),
                TextFormFieldWidget(
                  hintText: emailAddress,
                    labelText: emailAddress,
                    obscureText: false,
                    textEditingController: emailController),
                TextFormFieldWidget(
                    hintText: password,
                    labelText: password,
                    suffixIcon: GestureDetector(
                      onTap: (){
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                      child: Icon(_obscureText
                          ? Icons.visibility : Icons.visibility_off,color: Colors.grey),
                    ),
                    obscureText: _obscureText,
                    textEditingController:passwordController),
              ],
            ),
          ),
        ],
      ),


    );
  }
}

