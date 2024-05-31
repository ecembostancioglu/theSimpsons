import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thesimpsons/constants/color_constants.dart';
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
  bool _isChecked = true;

  void onChecked(bool value){}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
              child: Image.asset(TextConstants.background,
              fit: BoxFit.cover)),
          Align(
            alignment: Alignment.topCenter,
            child: Image.asset(TextConstants.logo,
            width: 250.w),
          ),
          Form(
            key: _formKey,
            child: ListView(
              children: [
                SizedBox(height: 400.w),
                TextFormFieldWidget(
                  hintText: TextConstants.emailAddress,
                    labelText: TextConstants.emailAddress,
                    obscureText: false,
                    textEditingController: emailController),
                TextFormFieldWidget(
                    hintText: TextConstants.password,
                    labelText: TextConstants.password,
                    suffixIcon: GestureDetector(
                      onTap: (){
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                      child: Icon(_obscureText
                          ? Icons.visibility : Icons.visibility_off,color: ColorConstants.grey),
                    ),
                    obscureText: _obscureText,
                    textEditingController:passwordController),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Transform.translate(
                            offset: Offset(0, -12.w),
                            child: Checkbox(
                              activeColor: ColorConstants.checkboxColor,
                                value: _isChecked,
                                onChanged: (bool? value){
                                  onChecked(value!);
                                }),
                          ),
                          GestureDetector(
                            onTap: () => print(TextConstants.rememberMe),
                            child: Text(
                              TextConstants.rememberMe,
                              style: TextStyle(color: ColorConstants.grey),
                            ),
                          )

                        ],
                      ),
                       Text(
                        TextConstants.forgotPassword,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                            color: ColorConstants.yellow),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal : 10.w),
                  child: SizedBox(
                    height: 60,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                         shape: RoundedRectangleBorder(
                             borderRadius: BorderRadius.circular(10.r)),
                        primary: ColorConstants.yellow
                      ),
                        onPressed: (){},
                        child: Text(TextConstants.loginNow,
                          style: TextStyle(color: ColorConstants.black,fontSize: 18.sp),)),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(5.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(TextConstants.dontHaveanAccount,
                          style: TextStyle(color: ColorConstants.grey,fontSize: 14.sp)),
                      TextButton(onPressed: (){}, child: Text(TextConstants.createOne,
                        style:TextStyle(color: ColorConstants.yellow,fontSize: 14.sp),))
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),


    );
  }
}

