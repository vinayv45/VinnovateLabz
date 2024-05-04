import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskapp/bloc/courses/course_bloc.dart';
import 'package:taskapp/bloc/courses/course_state.dart';
import 'package:taskapp/models/course_result.dart';
import 'package:taskapp/screens/courses/widgets/course_cart_item.dart';
import 'package:taskapp/widget/pagination_list.dart';

class CourseCard extends StatefulWidget {
  const CourseCard({
    super.key,
  });

  @override
  State<CourseCard> createState() => _CourseCardState();
}

int totalCount = 0;

Future<List<CourseResult>> fetch(BuildContext context, int index) async {
  final courseBloc = BlocProvider.of<CourseBloc>(context);

  await courseBloc.loadCourses(index);
  return await BlocProvider.of<CourseBloc>(context)
      .stream
      .firstWhere((state) => state is CourseLoadedState)
      .then((state) {
    if (state is CourseLoadedState) {
      totalCount = state.courses.length;

      return state.courses;
    } else {
      return [];
    }
  });
}

class _CourseCardState extends State<CourseCard> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CourseBloc, CourseState>(builder: (context, state) {
      if (state is CourseLoadedState) {
        return Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 15,
              ),
              Expanded(
                child: PaginationList<CourseResult>(
                  shrinkWrap: true,
                  onLoading: const Center(
                    child: CircularProgressIndicator(
                      color: Colors.black,
                    ),
                  ),
                  separatorWidget: Container(
                    margin: const EdgeInsets.only(top: 10),
                  ),
                  itemBuilder:
                      (BuildContext context, CourseResult courseResult) {
                    return CourseItem(course: courseResult);
                  },
                  pageFetch: (int index) {
                    return fetch(context, index);
                  },
                  onError: (dynamic error) => const Center(
                    child: Text('Something Went Wrong'),
                  ),
                  onEmpty: const Center(
                    child: Text('Empty List'),
                  ),
                ),
              ),
            ],
          ),
        );
      }
      return const Center(
        child: CircularProgressIndicator(),
      );
    });
  }
}
