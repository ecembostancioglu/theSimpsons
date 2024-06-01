import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thesimpsons/constants/color_constants.dart';
import 'package:thesimpsons/constants/text_constants.dart';
import 'package:thesimpsons/widgets/elevated_button_widget.dart';
import 'package:thesimpsons/widgets/textform_widget.dart';

class CreateAccountPage extends StatefulWidget {
  const CreateAccountPage({Key? key}) : super(key: key);

  @override
  State<CreateAccountPage> createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends State<CreateAccountPage> {

  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final surnameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool _obscureText = true;

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
                  child: Text('Create Account',
                    style: TextStyle(color: ColorConstants.yellow,fontSize: 24.sp),),
                )),
            TextFormFieldWidget(
                textEditingController: nameController,
                labelText: 'Name',
                hintText: 'Name',
                obscureText: false),
            TextFormFieldWidget(
                textEditingController: surnameController,
                labelText: 'Surname',
                hintText: 'Surname',
                obscureText: false),
            TextFormFieldWidget(
                textEditingController: emailController,
                labelText: TextConstants.emailAddress,
                hintText: TextConstants.emailAddress,
                obscureText: false),
            TextFormFieldWidget(
                textEditingController: passwordController,
                labelText: TextConstants.password,
                hintText: TextConstants.password,
                obscureText: true,
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
            ElevatedButtonWidget(
              backgroundColor: ColorConstants.yellow,
              buttonTextColor:ColorConstants.black,
              buttonText:TextConstants.createAccount,
              onPressed: (){},),
            SizedBox(height: 10.w),
            ElevatedButtonWidget(
              backgroundColor: ColorConstants.red,
              buttonTextColor:ColorConstants.white,
              buttonText:TextConstants.cancel,
              onPressed: (){},),
          ],
        ),
      ),
    );
  }
}
