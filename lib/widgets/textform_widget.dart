import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/color_constants.dart';

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
      padding: EdgeInsets.symmetric(vertical: 5.w, horizontal: 10.w),
      child: SizedBox(
        height: 60.w,
        child: TextFormField(
          controller: textEditingController,
          obscureText: obscureText,
          style: TextStyle(color: ColorConstants.grey,fontSize: 18.sp),
          decoration: InputDecoration(
              hintText: hintText,
              labelText: labelText,
              hintStyle: TextStyle(color: ColorConstants.grey,fontSize: 18.sp),
              labelStyle: TextStyle(color: ColorConstants.grey,fontSize: 18.sp),
              filled: true,
              fillColor: ColorConstants.textFormFieldColor,
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
