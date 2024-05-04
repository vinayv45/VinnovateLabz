import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:taskapp/bloc/search_course/search_course_event.dart';
import 'package:taskapp/bloc/search_course/search_course_state.dart';
import 'package:taskapp/config/api_url.dart';
import 'package:taskapp/models/course_result.dart';

class SearchCourseBloc extends Bloc<SearchCourseEvent, SearchCourseState> {
  List<CourseResult> _allCourses = [];
  SearchCourseBloc() : super(SearchCourseInitialState()) {
    on<SearchCourseLoadedEvent>(_loadCourse);
    on<SearchCoursesEvent>(_searchCourse);
  }

  _loadCourse(
      SearchCourseLoadedEvent event, Emitter<SearchCourseState> emit) async {
    try {
      emit(SearchCourseLoadingState());
      final response = await get(Uri.parse(ApiUrl.searchCourse));
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        var courseList = List<CourseResult>.from(
            data.map((json) => CourseResult.fromJson(json)));
        _allCourses = courseList;
        emit(SearchCourseLoadedState(courses: courseList));
      } else {
        emit(const SearchCourseErrorState(message: 'Failed to load.'));
      }
    } on Exception catch (e) {
      emit(SearchCourseErrorState(message: e.toString()));
    }
  }

  _searchCourse(SearchCoursesEvent event, Emitter<SearchCourseState> emit) {
    String searchString = event.searchText;
    if (searchString.length >= 3) {
      try {
        var filteredCourses = _allCourses
            .where((course) =>
                course.title
                    .toLowerCase()
                    .contains(searchString.toLowerCase()) ||
                course.description
                    .toLowerCase()
                    .contains(searchString.toLowerCase()))
            .toList();
        emit(SearchCourseLoadedState(courses: filteredCourses));
      } catch (e) {
        emit(SearchCourseErrorState(message: e.toString()));
      }
    } else {
      emit(const SearchCourseErrorState(message: 'No item found.'));
    }
  }

  void setAllCourses(List<CourseResult> courses) {
    _allCourses = courses;
  }
}
