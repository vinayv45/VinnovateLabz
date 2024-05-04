import 'package:flutter/material.dart';
import 'package:taskapp/config/appcolor.dart';

class CircleImageWidget extends StatelessWidget {
  const CircleImageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 30,
        ),
        Container(
          width: 150,
          height: 150,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
          ),
          child: ClipOval(
            child: Image.asset(
              'assets/images/circleimage.png',
              fit: BoxFit.cover,
              width: 150,
              height: 150,
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        const Text(
          "Log In",
          style: TextStyle(
            color: AppColor.backColor,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 15,
        ),
      ],
    );
  }
}
