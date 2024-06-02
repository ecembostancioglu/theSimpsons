import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thesimpsons/bloc/auth_bloc.dart';
import 'package:thesimpsons/constants/color_constants.dart';
import 'package:thesimpsons/constants/text_constants.dart';
import 'package:thesimpsons/screens/login_page.dart';
import 'package:thesimpsons/utils/validators/auth_validators.dart';
import 'package:thesimpsons/widgets/elevated_button_widget.dart';
import 'package:thesimpsons/widgets/textform_widget.dart';
import 'home_page.dart';

class CreateAccountPage extends StatefulWidget {
  const CreateAccountPage({Key? key}) : super(key: key);

  @override
  State<CreateAccountPage> createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends State<CreateAccountPage> {

  final _formKey = GlobalKey<FormState>();
  final AuthValidators authValidator = AuthValidators();

  final _nameController = TextEditingController();
  final _surnameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _obscureText = true;


  @override
  void dispose() {
    _nameController.dispose();
    _surnameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.black,
      body: Form(
        key: _formKey,
        child: ListView(
          children: [
            Center(
                child: Padding(
                  padding: EdgeInsets.all(20.w),
                  child: Text(TextConstants.createAccount,
                    style: TextStyle(color: ColorConstants.yellow,fontSize: 24.sp),),
                )),
            TextFormFieldWidget(
                textEditingController: _nameController,
                labelText: TextConstants.name,
                hintText: TextConstants.name,
                obscureText: false),
            TextFormFieldWidget(
                textEditingController: _surnameController,
                labelText: TextConstants.surname,
                hintText: TextConstants.surname,
                obscureText: false),
            TextFormFieldWidget(
                textEditingController: _emailController,
                labelText: TextConstants.emailAddress,
                hintText: TextConstants.emailAddress,
                validate: (val) => authValidator.emailValidator(val),
                obscureText: false),
            TextFormFieldWidget(
                textEditingController: _passwordController,
                labelText: TextConstants.password,
                hintText: TextConstants.password,
                validate: (val) => authValidator.passwordValidator(val),
                obscureText: _obscureText,
                suffixIcon: GestureDetector(
                  onTap: (){
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                  child: Icon(_obscureText
                      ? Icons.visibility : Icons.visibility_off,color: ColorConstants.grey),
                )),
            SizedBox(height: 200.w),
            BlocConsumer<AuthBloc,AuthState>(
              listener: (context,state){
                if(state is AuthSuccessState){
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomePage()));
                } else if (state is AuthFailureState){
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(TextConstants.failed),
                    ),
                  );
                }
              },
              builder: (context,state){
                return  ElevatedButtonWidget(
                  backgroundColor: ColorConstants.yellow,
                  buttonTextColor:ColorConstants.black,
                  buttonText:TextConstants.createAccount,
                  onPressed: (){
                    if(_formKey.currentState!.validate()){
                      BlocProvider.of<AuthBloc>(context).add(
                          SignUpUser(
                              _emailController.text.trim(),
                              _passwordController.text.trim()));
                    }
                  });
              },
            ),
            SizedBox(height: 10.w),
            ElevatedButtonWidget(
              backgroundColor: ColorConstants.red,
              buttonTextColor:ColorConstants.white,
              buttonText:TextConstants.cancel,
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginPage()));
              }),
          ],
        ),
      ),
    );
  }
}
