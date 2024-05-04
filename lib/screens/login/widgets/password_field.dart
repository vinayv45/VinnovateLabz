import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskapp/bloc/login/login_bloc.dart';
import 'package:taskapp/bloc/login/login_event.dart';
import 'package:taskapp/config/appcolor.dart';
import 'package:taskapp/screens/login/widgets/forgot_password.dart';

import '../login_screen.dart';

class PasswordField extends StatefulWidget {
  PasswordField({
    super.key,
    required this.passwordController,
  });

  final TextEditingController passwordController;

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    final loginBloc = BlocProvider.of<LoginBloc>(context);
    return Padding(
      padding: const EdgeInsets.only(
        left: 15,
        right: 15,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Password",
            style: TextStyle(color: AppColor.backColor),
          ),
          const SizedBox(height: 10),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextFormField(
              validator: (String? value) {
                if (value!.isEmpty) {
                  return "enter password";
                }
                return null;
              },
              onChanged: (password) {
                loginBloc.add(PasswordChanged(password: password));
              },
              controller: widget.passwordController,
              decoration: InputDecoration(
                fillColor: AppColor.greyColor,
                filled: true,
                suffixIcon: GestureDetector(
                  child: Icon(
                    _isObscure ? Icons.visibility : Icons.visibility_off,
                    color: AppColor.dartGreyColor,
                  ),
                  onTap: () {
                    _isObscure = !_isObscure;
                    setState(() {});
                    BlocProvider.of<LoginBloc>(context)
                        .add(TogglePasswordVisibility());
                  },
                ),
                prefixIcon: const Icon(
                  Icons.lock,
                  color: AppColor.dartGreyColor,
                ),
                hintText: 'Password',
                border: InputBorder.none,
              ),
              obscureText: _isObscure,
            ),
          ),
          const Align(
            alignment: Alignment.centerRight,
            child: ForgotPasswordButton(),
          ),
        ],
      ),
    );
  }
}
