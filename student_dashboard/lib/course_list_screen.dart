import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:student_dashboard/app_model.dart';
import 'package:student_dashboard/app_theme.dart';
import 'package:student_dashboard/course.dart';

class CourseListScreen extends StatelessWidget {
  const CourseListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return ScopedModelDescendant<AppModel>(
      builder: (context, child, model) {
        final courses = model.enrolledCourses;

        return Scaffold(
          backgroundColor:  Colors.transparent,
          body: SafeArea(
  
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                      child: Column(
                        children: [
                          
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            decoration: BoxDecoration(
                              color: colors.secondary,
                              borderRadius: BorderRadius.circular(22),
                              boxShadow: [
                                BoxShadow(
                                  color: colors.primary,
                                  blurRadius: 10,
                                  offset: const Offset(4, 4),
                                ),
                              ],
                            ),
                            child: Text(
                              'Course List',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: colors.onSecondary,
                                fontSize: 22,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          const SizedBox(height: 24),
                          ...courses.map((course) => Padding(
                                padding: const EdgeInsets.only(bottom: 18),
                                child: _CourseListCard(course: course),
                              )),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
      },
    );
  }
}

class _CourseListCard extends StatelessWidget {
  final Course course;

  const _CourseListCard({required this.course});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            height: 30,
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              color: ColorPalette.denim,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(14),
                topRight: Radius.circular(14),
              ),
            ),
            child: Text(
              course.code,
              style: TextStyle(
                color: colors.onPrimary,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(12, 16, 12, 14),
            decoration: BoxDecoration(
              color: colors.secondary,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(14),
                bottomRight: Radius.circular(14),
              ),
            ),
            child: Column(
              children: [
                _CourseInfoRow(label: 'Course Name:', value: course.name),
                const SizedBox(height: 12),
                _CourseInfoRow(label: 'Course Code:', value: course.code),
                const SizedBox(height: 12),
                _CourseInfoRow(
                  label: 'Course Instructor:',
                  value: course.instructor,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CourseInfoRow extends StatelessWidget {
  final String label;
  final String value;

  const _CourseInfoRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 82,
          child: Text(
            label,
            style: TextStyle(
              color: colors.onSecondary,
              fontSize: 10,
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              color: colors.onSecondary,
              fontSize: 10,
            ),
          ),
        ),
      ],
    );
  }
}
