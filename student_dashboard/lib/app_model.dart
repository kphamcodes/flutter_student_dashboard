import 'package:scoped_model/scoped_model.dart';
import 'package:student_dashboard/course.dart';
import 'package:student_dashboard/student.dart';

class AppModel extends Model {
  final Student student;

  final List<Course> courseCatalog = const [
    Course(
      code: 'CS101',
      name: 'Programming Essentials',
      instructor: 'John Doe',
    ),
    Course(
      code: 'CS102',
      name: 'Data Structures & Algorithms',
      instructor: 'Jane Doe',
    ),
    Course(
      code: 'CS103',
      name: 'Computer Systems',
      instructor: 'Bill Gates',
    ),
    Course(
      code: 'CS121',
      name: 'Programming Essentials II',
      instructor: 'John Doe',
    ),
    Course(
      code: 'CS124',
      name: 'Compiler Language',
      instructor: 'John Smith',
    ),
    Course(
      code: 'CS130',
      name: 'Operating Systems',
      instructor: 'Bill Gates',
    ),
    Course(
      code: 'CS132',
      name: 'Cyber Security',
      instructor: 'John Connor',
    ),
    Course(
      code: 'CS137',
      name: 'Mobile Software Engr',
      instructor: 'Leslie Reyes',
    ),
    Course(
      code: 'CS138',
      name: 'Database Systems I',
      instructor: 'Daphne Chen',
    ),
  ];

  final List<Course> enrolledCourses = [];

  AppModel({required this.student});

  //List<Course> get courses => List.unmodifiable(_courses);

  void addCourse(Course newCourse) {
    final exists = enrolledCourses.any((course) => course.code == newCourse.code);
    if (!exists) {
      enrolledCourses.add(newCourse);
      notifyListeners();
    }
  }

//   void addCourses(Iterable<Course> newCourses) {
//     var changed = false;
//     for (final course in newCourses) {
//       final exists = enrolledCourses.any((existing) => existing.code == course.code);
//       if (!exists) {
//         enrolledCourses.add(course);
//         changed = true;
//       }
//     }
//     if (changed) {
//       notifyListeners();
//     }
//   }
}
