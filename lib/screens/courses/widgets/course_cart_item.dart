import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:taskapp/config/appcolor.dart';
import 'package:taskapp/models/course_result.dart';

class CourseItem extends StatelessWidget {
  final CourseResult course;

  const CourseItem({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColor.whiteColor,
        borderRadius: BorderRadius.circular(10),
      ),
      height: 110,
      width: double.infinity,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 110,
            width: 100,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.network(
                course.image!,
                height: 110,
                width: 100,
                fit: BoxFit.contain,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  course.title!,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  course.category!,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: [
                    RatingBar.builder(
                      initialRating:
                          double.parse(course.rating!.rate!.toString()),
                      minRating: 1,
                      itemSize: 15.0,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemPadding: EdgeInsets.zero,
                      itemBuilder: (context, _) => const Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (rating) {},
                    ),
                    const SizedBox(width: 10),
                    Text("(${course.rating!.rate!})"),
                    const SizedBox(width: 2),
                    const Text("1"),
                    const Spacer(),
                    Text("\$ ${course.price.toString()}"),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
        ],
      ),
    );
  }
}
