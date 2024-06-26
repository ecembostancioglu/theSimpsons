import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:thesimpsons/bloc/auth_bloc.dart';
import 'package:thesimpsons/constants/color_constants.dart';
import 'package:thesimpsons/constants/text_constants.dart';
import 'package:thesimpsons/providers/remember_me_provider.dart';
import 'package:thesimpsons/screens/create_account_page.dart';
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
  final resetEmailController = TextEditingController();
  bool _obscureText = true;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    resetEmailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final rememberMeProvider = Provider.of<RememberMeProvider>(context);

    if (rememberMeProvider.isChecked) {
      emailController.text = rememberMeProvider.email;
    }
    showAlertDialog(BuildContext context) {
      AlertDialog alert = AlertDialog(
        title: const Text(TextConstants.alertTitle),
        content: const Text(TextConstants.alertMessage),
        actions: [
          TextButton(
            child: const Text(TextConstants.ok),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      );
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );
    }
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
                Column(
                  children: [
                    TextFormFieldWidget( //Email TextField
                        hintText: TextConstants.emailAddress,
                        labelText: TextConstants.emailAddress,
                        obscureText: false,
                        validate: (value) => authValidator.emailValidator(value),
                        textEditingController: emailController),
                    TextFormFieldWidget( //Password TextField
                        hintText: TextConstants.password,
                        labelText: TextConstants.password,
                        validate: (value) => authValidator.passwordValidator(value),
                        suffixIcon: GestureDetector( //Visible password
                          onTap: (){
                            setState(() {
                              _obscureText = !_obscureText;
                            });
                          },
                          child: Icon(_obscureText
                              ? Icons.visibility
                              : Icons.visibility_off,
                              color: ColorConstants.grey),
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
                              Transform.translate( //Checkbox
                                offset: Offset(0, -12.w),
                                child: Checkbox(
                                    activeColor: ColorConstants.checkboxColor,
                                    value:  rememberMeProvider.isChecked,
                                    onChanged: (value){
                                      rememberMeProvider.setRememberMe(
                                          value ?? false, emailController.text);
                                    }),
                              ),
                              Text(  //Checkbox Text
                                TextConstants.rememberMe,
                                style: TextStyle(color: ColorConstants.grey),
                              ),
                            ],
                          ),
                          TextButton(  //Forgot Password
                            onPressed: (){
                                 showModalBottomSheet(
                                  backgroundColor: ColorConstants.black,
                                  context: context, builder: (context)
                              => Column(
                                children: [
                                  Padding(
                                      padding: EdgeInsets.all(16.w),
                                      child: TextFormFieldWidget(
                                        textEditingController:resetEmailController,
                                        labelText: TextConstants.emailAddress,
                                        obscureText: false,
                                        hintText: TextConstants.emailAddress,
                                      ),),
                                  ElevatedButtonWidget(
                                    backgroundColor: ColorConstants.yellow,
                                    buttonText:TextConstants.resetButton,
                                    buttonTextColor: ColorConstants.black,
                                    onPressed: (){
                                        if(resetEmailController.text != ""){
                                          context.read<AuthBloc>().add(ResetEmail(resetEmailController.text));
                                          showAlertDialog(context);
                                        }
                                      },)
                                ],
                              ));
                            },
                            child: Text(TextConstants.forgotPassword,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: ColorConstants.yellow),),
                          )
                        ],
                      ),
                    ),
                    BlocConsumer<AuthBloc,AuthState>(
                      listener: (context,state){
                        if (state is AuthSuccessState){
                          rememberMeProvider.setRememberMe(
                              rememberMeProvider.isChecked, emailController.text);
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
                        return ElevatedButtonWidget( //Login Now Button
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
                    )],
                ),
                Padding(//Dont have any account? Text and Create One Button
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
