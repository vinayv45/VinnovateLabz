import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskapp/bloc/login/login_bloc.dart';
import 'package:taskapp/bloc/login/login_event.dart';
import 'package:taskapp/bloc/login/login_state.dart';
import 'package:taskapp/config/appcolor.dart';

class SubmitButton extends StatelessWidget {
  const SubmitButton({
    super.key,
    required this.usernameController,
    required this.passwordController,
    required this.formkey,
  });

  final TextEditingController usernameController;
  final TextEditingController passwordController;
  final GlobalKey<FormState> formkey;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return state is LoginLoading
            ? const CircularProgressIndicator(color: Colors.red)
            : Padding(
                padding: const EdgeInsets.only(
                  left: 15,
                  right: 15,
                ),
                child: SizedBox(
                  height: 54,
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                      backgroundColor:
                          const MaterialStatePropertyAll(AppColor.redColor),
                    ),
                    onPressed: () {
                      if (formkey.currentState!.validate()) {
                        BlocProvider.of<LoginBloc>(context).add(
                          FormSubmitted(
                            username: usernameController.text,
                            password: passwordController.text,
                          ),
                        );
                      }
                    },
                    child: const Text("Login in"),
                  ),
                ),
              );
      },
    );
  }
}
