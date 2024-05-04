import 'package:equatable/equatable.dart';
import 'package:taskapp/models/course_result.dart';

abstract class SearchCourseState extends Equatable {
  const SearchCourseState();

  @override
  List<Object> get props => [];
}

class SearchCourseInitialState extends SearchCourseState {}

class SearchCourseLoadingState extends SearchCourseState {}

class SearchCourseLoadedState extends SearchCourseState {
  final List<CourseResult> courses;

  const SearchCourseLoadedState({required this.courses});

  @override
  List<Object> get props => [courses];
}

class SearchCourseErrorState extends SearchCourseState {
  final String message;

  const SearchCourseErrorState({required this.message});

  @override
  List<Object> get props => [message];
}
