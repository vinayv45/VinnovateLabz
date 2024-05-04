import 'package:equatable/equatable.dart';
import 'package:taskapp/models/course_result.dart';

abstract class CourseState extends Equatable {
  const CourseState();

  @override
  List<Object> get props => [];
}

class CourseInitialState extends CourseState {}

class CourseLoadingState extends CourseState {}

class CourseLoadedState extends CourseState {
  final List<CourseResult> courses;

  const CourseLoadedState({required this.courses});

  @override
  List<Object> get props => [courses];
}

class CourseErrorState extends CourseState {
  final String message;

  const CourseErrorState({required this.message});

  @override
  List<Object> get props => [message];
}
