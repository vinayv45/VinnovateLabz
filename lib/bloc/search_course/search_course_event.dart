import 'package:equatable/equatable.dart';

abstract class SearchCourseEvent extends Equatable {
  const SearchCourseEvent();
}

class SearchCourseLoadedEvent extends SearchCourseEvent {
  const SearchCourseLoadedEvent();

  @override
  List<Object> get props => [];
}

class SearchCoursesEvent extends SearchCourseEvent {
  final String searchText;
  const SearchCoursesEvent({required this.searchText});

  @override
  List<Object> get props => [searchText];
}
