import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskapp/bloc/search_course/search_course_bloc.dart';
import 'package:taskapp/bloc/search_course/search_course_event.dart';
import 'package:taskapp/bloc/search_course/search_course_state.dart';
import 'package:taskapp/config/appcolor.dart';
import 'package:taskapp/screens/courses/widgets/course_cart_item.dart';

class SearchCourseScreen extends StatelessWidget {
  SearchCourseScreen({super.key});
  final searhController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final searchCourseBloc = BlocProvider.of<SearchCourseBloc>(context);
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: AppColor.backColor),
        elevation: 0,
        backgroundColor: Colors.white,
        title: Container(
          decoration: BoxDecoration(
            color: AppColor.greyColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: TextFormField(
            onChanged: (String searchCourse) {
              searchCourseBloc
                  .add(SearchCoursesEvent(searchText: searchCourse));
            },
            controller: searhController,
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.only(
                top: 14,
                left: 10,
              ),
              prefixIcon: Icon(
                Icons.search,
                color: AppColor.dartGreyColor,
              ),
              hintText: 'Search Course',
              border: InputBorder.none,
            ),
          ),
        ),
      ),
      body: const SearchCourseCard(),
    );
  }
}

class SearchCourseCard extends StatelessWidget {
  const SearchCourseCard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchCourseBloc, SearchCourseState>(
      builder: (context, state) {
        if (state is SearchCourseLoadedState) {
          var courses = state.courses;
          return Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 15,
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: courses.length,
                    itemBuilder: (_, index) {
                      var course = courses[index];
                      return Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: CourseItem(course: course),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        }
        if (state is SearchCourseLoadingState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is SearchCourseErrorState) {
          return Center(
            child: Text(state.message),
          );
        } else {
          return const Center(
            child: Text("Error"),
          );
        }
      },
    );
  }
}
