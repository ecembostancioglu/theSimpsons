import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thesimpsons/bloc/auth_bloc.dart';
import 'package:thesimpsons/constants/color_constants.dart';
import 'package:thesimpsons/constants/text_constants.dart';
import 'package:thesimpsons/screens/create_account.dart';
import 'package:thesimpsons/screens/home_page.dart';
import 'package:thesimpsons/utils/validators/auth_validators.dart';

import '../widgets/textform_widget.dart';
import '../widgets/elevated_button_widget.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final _formKey = GlobalKey<FormState>();
  final AuthValidators authValidator = AuthValidators();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool _obscureText = true;
  bool _isChecked = false;

  void _reloadRememberme(bool value){ //Checkbox rememberMe kodu
    setState(() {
      _isChecked = value;
    });
  }

  void _handleRememberme(bool value) {
    setState(() {
      _isChecked = value;
    });
    SharedPreferences.getInstance().then(
          (prefs) {
        prefs.setBool(TextConstants.remember_me, value); //RememberMe tercihine göre bool değerini kaydeder.
        prefs.setString(TextConstants.email, emailController.text); //RememberMe tercihine göre email kaydeder.
      },
    );
  }

  void _loadUserEmailPassword() async {

    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var email = prefs.getString(TextConstants.email) ?? ""; //Kaydedilmiş emaili Shared Preferencestan alır.
      var rememberMe = prefs.getBool(TextConstants.remember_me) ?? false; //Remember Me tercihini Shared Preferencestan alır.

      if (rememberMe) {
        setState(() {
          _isChecked = true;
        });
        emailController.text = email;
      }
    } catch (e) {
        print(e);
    }
  }

  @override
  void initState() {
    _loadUserEmailPassword();
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

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
                    validate: (value) => authValidator.emailValidator(value),
                    textEditingController: emailController),
                TextFormFieldWidget(
                    hintText: TextConstants.password,
                    labelText: TextConstants.password,
                    validate: (value) => authValidator.passwordValidator(value),
                    suffixIcon: GestureDetector(
                      onTap: (){
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                      child: Icon(_obscureText
                          ? Icons.visibility : Icons.visibility_off,color : ColorConstants.grey),
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
                                  _reloadRememberme(value!);
                                }),
                          ),
                          Text(
                            TextConstants.rememberMe,
                            style: TextStyle(color: ColorConstants.grey),
                          ),
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
                BlocConsumer<AuthBloc,AuthState>(
                 listener: (context,state){
                   if (state is AuthSuccessState){
                     _handleRememberme(_isChecked);
                     Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomePage()));
                   } else if(state is AuthFailureState){
                     ScaffoldMessenger.of(context).showSnackBar(
                       const SnackBar(
                         content: Text(TextConstants.checkYourEmail),
                       ),
                     );
                   }
                 },
                  builder: (context, state){
                   return ElevatedButtonWidget(
                     backgroundColor: ColorConstants.yellow,
                     buttonTextColor:ColorConstants.black,
                     buttonText:TextConstants.loginNow,
                     onPressed: (){
                       if (_formKey.currentState!.validate()){
                         BlocProvider.of<AuthBloc>(context).add(
                             SignInUser(emailController.text.trim(), passwordController.text.trim()));
                       } else {
                         ScaffoldMessenger.of(context).showSnackBar(
                           const SnackBar(
                             content: Text(TextConstants.tryAgain),
                           ),
                         );
                       }
                     },);
                  },
                ),
                Padding(
                  padding: EdgeInsets.all(5.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(TextConstants.dontHaveanAccount,
                          style: TextStyle(
                              color: ColorConstants.grey,fontSize: 14.sp)),
                      TextButton( onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const CreateAccountPage()));},
                          child: Text(TextConstants.createOne,
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


