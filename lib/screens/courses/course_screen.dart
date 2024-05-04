import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:taskapp/config/appcolor.dart';
import 'package:taskapp/screens/courses/search_course_screen.dart';
import 'package:taskapp/screens/courses/widgets/course_card.dart';
import 'package:taskapp/screens/login/login_screen.dart';

class CourseScreen extends StatelessWidget {
  const CourseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.greyColor,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () async {
            await FirebaseAuth.instance.signOut();
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (_) => LoginScreen()));
          },
          icon: const Icon(
            Icons.logout,
            color: AppColor.backColor,
          ),
        ),
        elevation: 1,
        centerTitle: true,
        backgroundColor: AppColor.whiteColor,
        title: const Text(
          "academy",
          style: TextStyle(
            color: AppColor.backColor,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => SearchCourseScreen(),
                ),
              );
            },
            icon: const Icon(
              Icons.search,
              color: AppColor.backColor,
            ),
          )
        ],
      ),
      body: const CourseCard(),
    );
  }
}
