import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TextFormFieldWidget extends StatelessWidget {
  const TextFormFieldWidget({
    required this.textEditingController,
    required this.labelText,
    required this.hintText,
    required this.obscureText,
    this.suffixIcon,
    Key? key}) : super(key: key);


  final TextEditingController textEditingController;
  final String labelText;
  final String hintText;
  final bool obscureText;
  final GestureDetector? suffixIcon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.w),
      child: SizedBox(
        height: 60.w,
        child: TextFormField(
          controller: textEditingController,
          obscureText: obscureText,
          style: TextStyle(color: Colors.grey,fontSize: 18.sp),
          decoration: InputDecoration(
              hintText: hintText,
              labelText: labelText,
              hintStyle: TextStyle(color: Colors.grey,fontSize: 18.sp),
              labelStyle: TextStyle(color: Colors.grey,fontSize: 18.sp),
              filled: true,
              fillColor: const Color(0xff1f2430),
              suffixIcon: suffixIcon,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.r))
              ),
          ),
        ),
      ),
    );
  }
}
