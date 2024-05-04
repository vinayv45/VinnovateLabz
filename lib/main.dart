import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskapp/bloc/courses/course_bloc.dart';
import 'package:taskapp/bloc/courses/course_event.dart';
import 'package:taskapp/bloc/login/login_bloc.dart';
import 'package:taskapp/bloc/search_course/search_course_bloc.dart';
import 'package:taskapp/bloc/search_course/search_course_event.dart';
import 'package:taskapp/screens/courses/course_screen.dart';
import 'package:taskapp/screens/login/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (Firebase.apps.isEmpty) {
    if (!Platform.isIOS) {
      await Firebase.initializeApp(
        options: const FirebaseOptions(
          apiKey: 'AIzaSyBnmATJ6D4s2fZ7Jzn4ktwQUt20Oj0D2XE',
          appId: 'com.app.taskapp',
          messagingSenderId: '',
          projectId: 'taskapp-96747',
        ),
      );
    } else {
      await Firebase.initializeApp(
        name: 'taskapp',
        options: const FirebaseOptions(
          apiKey: 'AIzaSyD1JFkjrvIkrtXteAVgwvjihYKh0ZF5yyo',
          appId: '1:106170442370:ios:380c358416c64521688a9b',
          messagingSenderId: '106170442370',
          projectId: 'taskapp-96747',
          iosBundleId: 'com.app.taskapp',
        ),
      );
    }
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    return MultiBlocProvider(
      providers: [
        BlocProvider<LoginBloc>(
          create: (BuildContext context) => LoginBloc(),
        ),
        BlocProvider<CourseBloc>(
          create: (BuildContext context) =>
              CourseBloc()..add(const CoursesLoadedEvent(limit: 15)),
        ),
        BlocProvider<SearchCourseBloc>(
          create: (BuildContext context) =>
              SearchCourseBloc()..add(const SearchCourseLoadedEvent()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: false,
        ),
        home: user == null ? LoginScreen() : const CourseScreen(),
      ),
    );
  }
}
