import 'package:equatable/equatable.dart';
import 'package:taskapp/models/course_result.dart';

abstract class CourseEvent extends Equatable {
  const CourseEvent();
}

class CoursesLoadedEvent extends CourseEvent {
  final int limit;

  const CoursesLoadedEvent({required this.limit});

  @override
  List<Object> get props => [limit];
}
