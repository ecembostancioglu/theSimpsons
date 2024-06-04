
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ElevatedButtonWidget extends StatelessWidget {
  const ElevatedButtonWidget({
    required this.backgroundColor,
    required this.buttonText,
    required this.buttonTextColor,
    required this.onPressed,
    super.key,
  });

  final Color? backgroundColor;
  final String buttonText;
  final Color? buttonTextColor;
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal : 10.w),
      child: SizedBox(
        height: 60,
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: backgroundColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.r)),
            ),
            onPressed: onPressed,
            child: Text(buttonText,
              style: TextStyle(color: buttonTextColor,fontSize: 18.sp),)),
      ),
    );
  }
}