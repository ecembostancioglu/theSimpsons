import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thesimpsons/bloc/auth_bloc.dart';
import 'package:thesimpsons/constants/color_constants.dart';
import 'package:thesimpsons/constants/text_constants.dart';
import 'package:thesimpsons/screens/login_page.dart';
import 'package:thesimpsons/widgets/elevated_button_widget.dart';


class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.black,
      body: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is AuthSuccessState) {
            final user = state.user;
            return ListView(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 250.w),
                  child: Center(
                    child: Text(
                      '${user.name} ${user.surname}',
                      style: TextStyle(
                        color: ColorConstants.yellow,
                        fontSize: 24.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 300.w),
                  child: ElevatedButtonWidget(
                    backgroundColor: ColorConstants.yellow,
                    buttonText: TextConstants.logout,
                    buttonTextColor: ColorConstants.black,
                    onPressed: () {
                      context.read<AuthBloc>().add(SignOut());
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginPage(),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          } else {
           return const Center(
             child: CircularProgressIndicator(),
           );
          }
        },
      ),
    );
  }
}
