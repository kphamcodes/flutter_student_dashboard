import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:student_dashboard/student.dart';
import 'package:student_dashboard/registration_screen.dart';

class ColorPalette {
  static const obsidian = Color.fromARGB(255, 42, 42, 42);
  static const seashell = Color.fromARGB(255, 249, 245, 237);
  static const denim = Color.fromARGB(255, 94, 131, 174);
}

final Student student1 = Student(
  name: 'Khoi Pham',
  major: 'B.S. Computer Engineering',
  enrollmentDate: DateTime(2026, 8),
  hobbies: [
    'Cybersecurity',
    'Computer Network',
    'Machine Learning',
    'Semiconductor',
  ],
);

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Student Dashboard',
      theme: ThemeData(     
        useMaterial3: true,
        fontFamily: GoogleFonts.merriweatherSans().fontFamily,
        scaffoldBackgroundColor: ColorPalette.seashell,
        colorScheme: const ColorScheme(
          brightness: Brightness.light,
          primary: ColorPalette.denim,
          onPrimary: ColorPalette.seashell,
          secondary: ColorPalette.obsidian,
          onSecondary: ColorPalette.seashell,
          error: Colors.red,
          onError: ColorPalette.seashell,
          surface: ColorPalette.seashell,
          onSurface: ColorPalette.obsidian,
        ),
        textTheme: GoogleFonts.merriweatherSansTextTheme(),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: ColorPalette.obsidian,
          hintStyle: const TextStyle(color: ColorPalette.seashell),
          labelStyle: const TextStyle(color: ColorPalette.seashell),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: const BorderSide(color: ColorPalette.denim),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: const BorderSide(color: Colors.red),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: const BorderSide(color: Colors.red),
          ),
          errorStyle: const TextStyle(
            color: Colors.red,
            fontSize: 10,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: ColorPalette.denim,
            foregroundColor: ColorPalette.seashell,
            textStyle: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
      ),
      
      home: HomePage(student1),
    );
  }
}

class HomePage extends StatelessWidget {
  final Student student;

  const HomePage(this.student, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors:[
              ColorPalette.seashell,
              ColorPalette.seashell,
              ColorPalette.obsidian,
            ],
            stops: [0.0, 0.8, 1.0],
          ),
          
        ),
        child:SafeArea(
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                  child: Column(
                    children: [
                      ProfileCard(student: student),
                      const SizedBox(height: 28),

                      CourseCard(
                        title: 'CMPE 137',
                        assignments: const [
                          'Assignment 1',
                          'Assignment 2',
                          'Assignment 3',
                        ],
                      ),
                      const SizedBox(height: 8),

                      CourseCard(
                        title: 'CMPE 138',
                        assignments: const [
                          'Assignment 4',
                          'Assignment 5',
                          'Assignment 6',
                        ],
                      ),
                      const SizedBox(height: 8),

                      CourseCard(
                        title: 'CMPE 139',
                        assignments: const [
                          'Assignment 7',
                          'Assignment 8',
                          'Assignment 9',
                        ],
                      ),
                      const SizedBox(height: 80),
                    ],
                  ),
                ),
              ),

            Container(
              height: 56,
              margin: const EdgeInsets.fromLTRB(4, 0, 4, 12),
              decoration: BoxDecoration(
                color: ColorPalette.obsidian,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [

                  Expanded(
        child: BottomBarItem(
          icon: Icon(Icons.home, color: ColorPalette.seashell, size: 24),
        ),
      ),
      Expanded(
        child: BottomBarItem(
          icon: Icon(Icons.calendar_month_outlined, color: ColorPalette.seashell, size: 24),
        ),
      ),
      Expanded(
        child: BottomBarItem(
          icon: Icon(Icons.assignment, color: ColorPalette.seashell, size: 24),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const RegistrationScreen(),
              ),
            );
          },
        ),
      ),
      Expanded(
        child: BottomBarItem(
          icon: Icon(Icons.person, color: ColorPalette.seashell, size: 24),
        ),
      ),
                   
                ],
                
              ),
            ),
          ],
        ),
      ),
      )
      
      
    );
  }
}

class ProfileCard extends StatelessWidget {
  final Student student;

  const ProfileCard({
    super.key,
    required this.student,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(right: 6, bottom: 6),
      decoration: BoxDecoration(
        color: ColorPalette.denim,
        borderRadius: BorderRadius.circular(24),
        boxShadow: const[
          BoxShadow(
            color: ColorPalette.denim,
            blurRadius: 12,
            offset: Offset(4,4),
          ),

        ],
      ),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.fromLTRB(18, 18, 18, 20),
        decoration: BoxDecoration(
          color: ColorPalette.obsidian,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage('lib/assets/markiplier.jpg'),
                ),
                const SizedBox(width: 16),

                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          student.name,
                          style: const TextStyle(
                            color: ColorPalette.seashell,
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          student.major,
                          style: const TextStyle(
                            color: ColorPalette.seashell,
                            fontSize: 13,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Enrolled: ${student.dtString()}',
                          style: const TextStyle(
                            color: ColorPalette.seashell,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 18),

            const Text(
              'Interests',
              style: TextStyle(
                color: ColorPalette.seashell,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 12),

            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                InterestTile(
                  icon: Image.asset('lib/assets/cyber_sec.png',),
                  label: student.hobbies != null && student.hobbies!.isNotEmpty
                      ? student.hobbies![0]
                      : 'Cybersecurity',
                ),
                InterestTile(
                  icon: Image.asset(('lib/assets/network.png')),
                  label: student.hobbies != null && student.hobbies!.length > 1
                      ? student.hobbies![1]
                      : 'Computer Network',
                ),
                InterestTile(
                  icon: Image.asset(('lib/assets/machine_learning.png')),
                  label: student.hobbies != null && student.hobbies!.length > 2
                      ? student.hobbies![2]
                      : 'Machine Learning',
                ),
                InterestTile(
                  icon: Image.asset(('lib/assets/semicon.png')),
                  label: student.hobbies != null && student.hobbies!.length > 3
                      ? student.hobbies![3]
                      : 'Semiconductor',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class InterestTile extends StatelessWidget {
  final Widget icon;
  final String label;

  const InterestTile({
    super.key,
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 72,
      height: 60,
      decoration: BoxDecoration(
        color: ColorPalette.denim,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 25,
            width: 27,
            child: icon,
          ),
          
          const SizedBox(height: 4),
          
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: ColorPalette.seashell,
              fontSize: 9,
              height: 1.1,
            ),
          ),
        ],
      ),
    );
  }
}

class CourseCard extends StatelessWidget {
  final String title;
  final List<String> assignments;

  const CourseCard({
    super.key,
    required this.title,
    required this.assignments,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 145,
      width: double.infinity,
      decoration: BoxDecoration(
        color: ColorPalette.obsidian,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Container(
            width: 112,
            decoration: const BoxDecoration(
              color: ColorPalette.denim,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(14),
                bottomLeft: Radius.circular(14),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(14, 14, 12, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: ColorPalette.seashell,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 12),
                  ...assignments.map(
                    (assignment) => Padding(
                      padding: const EdgeInsets.only(bottom: 6),
                      child: Text(
                        assignment,
                        style: const TextStyle(
                          color: ColorPalette.seashell,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BottomBarItem extends StatelessWidget {
  final Widget icon;
  final VoidCallback? onTap;

  const BottomBarItem({
    super.key,
    required this.icon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Center(
        child: SizedBox(
        width: 24,
        height: 24,
        child: icon,
      ),
      )
    );
  }
}