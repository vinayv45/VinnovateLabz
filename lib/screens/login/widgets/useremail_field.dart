import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskapp/bloc/login/login_bloc.dart';
import 'package:taskapp/bloc/login/login_event.dart';
import 'package:taskapp/bloc/login/login_state.dart';
import 'package:taskapp/config/appcolor.dart';

class UserEmailField extends StatelessWidget {
  const UserEmailField({
    super.key,
    required this.usernameController,
  });

  final TextEditingController usernameController;

  @override
  Widget build(BuildContext context) {
    final loginBloc = BlocProvider.of<LoginBloc>(context);
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.only(
            left: 15,
            right: 15,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Email",
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
                      return "enter email";
                    }
                    return null;
                  },
                  onChanged: (String username) {
                    loginBloc.add(UsernameChanged(username: username));
                  },
                  controller: usernameController,
                  decoration: const InputDecoration(
                    fillColor: AppColor.greyColor,
                    filled: true,
                    contentPadding: EdgeInsets.only(
                      top: 14,
                      left: 10,
                    ),
                    prefixIcon: Icon(
                      Icons.email,
                      color: AppColor.dartGreyColor,
                    ),
                    hintText: 'Email',
                    border: InputBorder.none,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
