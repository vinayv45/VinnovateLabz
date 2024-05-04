import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:taskapp/bloc/courses/course_event.dart';
import 'package:taskapp/bloc/courses/course_state.dart';
import 'package:taskapp/config/api_url.dart';
import 'package:taskapp/models/course_result.dart';

class CourseBloc extends Bloc<CourseEvent, CourseState> {
  CourseBloc() : super(CourseInitialState()) {
    on<CoursesLoadedEvent>(_loadCourse);
  }

  _loadCourse(CoursesLoadedEvent event, Emitter<CourseState> emit) async {
    try {
      final int limit = event.limit;
      final response = await get(Uri.parse("${ApiUrl.allCourse}=$limit"));
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        var courseList = List<CourseResult>.from(
            data.map((json) => CourseResult.fromJson(json)));
        emit(CourseLoadedState(courses: courseList));
      } else {
        emit(const CourseErrorState(message: 'Failed to load.'));
      }
    } on Exception catch (e) {
      emit(CourseErrorState(message: e.toString()));
    }
  }

  Future<void> loadCourses(int limit) async {
    add(CoursesLoadedEvent(limit: limit));
  }
}
