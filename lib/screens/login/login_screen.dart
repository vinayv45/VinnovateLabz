import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskapp/bloc/login/login_bloc.dart';
import 'package:taskapp/bloc/login/login_state.dart';
import 'package:taskapp/config/appcolor.dart';
import 'package:taskapp/screens/courses/course_screen.dart';
import 'package:taskapp/screens/login/widgets/circle_image_widget.dart';
import 'package:taskapp/screens/login/widgets/forgot_password.dart';
import 'package:taskapp/screens/login/widgets/password_field.dart';
import 'package:taskapp/screens/login/widgets/submit_button.dart';
import 'package:taskapp/screens/login/widgets/useremail_field.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: AppColor.greyColor,
      body: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is LoginSuccess) {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            showDialog<void>(
              context: context,
              builder: (_) => const SuccessDialog(),
            );

            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const CourseScreen(),
              ),
            );
          }
          if (state is LoginFailure) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(content: Text(state.error)),
              );
          }
        },
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: size * 0.15,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Card(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  color: AppColor.whiteColor,
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const CircleImageWidget(),
                        UserEmailField(usernameController: usernameController),
                        const SizedBox(height: 15),
                        PasswordField(passwordController: passwordController),
                        SubmitButton(
                            usernameController: usernameController,
                            passwordController: passwordController,
                            formkey: _formKey),
                        const SizedBox(height: 50)
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
