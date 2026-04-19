import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:student_dashboard/app_model.dart';
import 'package:student_dashboard/app_theme.dart';
import 'package:student_dashboard/course_list_screen.dart';
import 'package:student_dashboard/registration_screen.dart';
import 'package:student_dashboard/student.dart';

final Student student1 = Student(
  name: 'Khoi Pham',
  major: 'B.S. Computer Engineering',
  enrollmentDate: DateTime(2026, 8),
  hobbies: const [
    'Cybersecurity',
    'Computer Network',
    'Machine Learning',
    'Semiconductor',
  ],
);

void main() {
  runApp(MyApp(model: AppModel(student: student1)));
}

class MyApp extends StatelessWidget {
  final AppModel model;

  const MyApp({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return ScopedModel<AppModel>(
      model: model,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Student Dashboard',
        theme: buildAppTheme(),
        home: const AppShell(),
      ),
    );
  }
}

class AppShell extends StatefulWidget {
  const AppShell({super.key});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  int _currentIndex = 0;

  void _selectTab(int index) {
    if (_currentIndex == index) return;
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screens = [
      const _ProfileScreen(),
      const CourseListScreen(),
      RegistrationScreen(onShowCourseList: () => _selectTab(1)),
    ];

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              ColorPalette.seashell,
              ColorPalette.seashell,
              ColorPalette.obsidian,
            ],
            stops: [0.0, 0.8, 1.0],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 250),
                  transitionBuilder: (child, animation) {
                    final slide = Tween<Offset>(
                      begin: const Offset(0.04, 0),
                      end: Offset.zero,
                    ).animate(animation);
                    return FadeTransition(
                      opacity: animation,
                      child: SlideTransition(position: slide, child: child),
                    );
                  },
                  child: KeyedSubtree(
                    key: ValueKey(_currentIndex),
                    child: IndexedStack(
                      index: _currentIndex,
                      children: screens,
                    ),
                  ),
                ),
              ),
              _BottomNavigationBar(
                currentIndex: _currentIndex,
                onTap: _selectTab,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ProfileScreen extends StatelessWidget {
  const _ProfileScreen();

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<AppModel>(
      builder: (context, child, model) {
        final student = model.student;
        return SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          child: Column(
            children: [
              ProfileCard(student: student),
              const SizedBox(height: 28),
              const CourseAssignmentCard(
                title: 'CMPE 137',
                assignments: [
                  'Assignment 1',
                  'Assignment 2',
                  'Assignment 3',
                ],
              ),
              const SizedBox(height: 8),
              const CourseAssignmentCard(
                title: 'CMPE 138',
                assignments: [
                  'Assignment 4',
                  'Assignment 5',
                  'Assignment 6',
                ],
              ),
              const SizedBox(height: 8),
              const CourseAssignmentCard(
                title: 'CMPE 139',
                assignments: [
                  'Assignment 7',
                  'Assignment 8',
                  'Assignment 9',
                ],
              ),
              const SizedBox(height: 80),
            ],
          ),
        );
      },
    );
  }
}

class _BottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const _BottomNavigationBar({
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Container(
      height: 56,
      margin: const EdgeInsets.fromLTRB(4, 0, 4, 12),
      decoration: BoxDecoration(
        color: colors.secondary,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Expanded(
            child: _BottomBarItem(
              icon: Icons.home,
              isSelected: currentIndex == 0,
              onTap: () => onTap(0),
            ),
          ),
          Expanded(
            child: _BottomBarItem(
              icon: Icons.calendar_month_outlined,
              isSelected: currentIndex == 1,
              onTap: () => onTap(1),
            ),
          ),
          Expanded(
            child: _BottomBarItem(
              icon: Icons.assignment,
              isSelected: currentIndex == 2,
              onTap: () => onTap(2),
            ),
          ),
          const Expanded(
            child: _BottomBarItem(
              icon: Icons.person,
              isSelected: false,
            ),
          ),
        ],
      ),
    );
  }
}

class _BottomBarItem extends StatelessWidget {
  final IconData icon;
  final bool isSelected;
  final VoidCallback? onTap;

  const _BottomBarItem({
    required this.icon,
    required this.isSelected,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final iconColor = isSelected ? colors.primary : colors.onSecondary;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Center(
        child: Icon(icon, color: iconColor, size: 30),
      ),
    );
  }
}

class ProfileCard extends StatelessWidget {
  final Student student;

  const ProfileCard({super.key, required this.student});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.only(right: 6, bottom: 6),
      decoration: BoxDecoration(
        color: colors.primary,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: colors.primary,
            blurRadius: 12,
            offset: const Offset(4, 4),
          ),
        ],
      ),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.fromLTRB(18, 18, 18, 20),
        decoration: BoxDecoration(
          color: colors.secondary,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CircleAvatar(
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
                          style: TextStyle(
                            color: colors.onSecondary,
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          student.major,
                          style: TextStyle(
                            color: colors.onSecondary,
                            fontSize: 13,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Enrolled: ${student.dtString()}',
                          style: TextStyle(
                            color: colors.onSecondary,
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
            Text(
              'Interests',
              style: TextStyle(
                color: colors.onSecondary,
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
                  icon: Image.asset('lib/assets/cyber_sec.png'),
                  label: student.hobbies != null && student.hobbies!.isNotEmpty
                      ? student.hobbies![0]
                      : 'Cybersecurity',
                ),
                InterestTile(
                  icon: Image.asset('lib/assets/network.png'),
                  label: student.hobbies != null && student.hobbies!.length > 1
                      ? student.hobbies![1]
                      : 'Computer Network',
                ),
                InterestTile(
                  icon: Image.asset('lib/assets/machine_learning.png'),
                  label: student.hobbies != null && student.hobbies!.length > 2
                      ? student.hobbies![2]
                      : 'Machine Learning',
                ),
                InterestTile(
                  icon: Image.asset('lib/assets/semicon.png'),
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
    final colors = Theme.of(context).colorScheme;

    return Container(
      width: 72,
      height: 60,
      decoration: BoxDecoration(
        color: colors.primary,
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
            style: TextStyle(
              color: colors.onPrimary,
              fontSize: 9,
              height: 1.1,
            ),
          ),
        ],
      ),
    );
  }
}

class CourseAssignmentCard extends StatelessWidget {
  final String title;
  final List<String> assignments;

  const CourseAssignmentCard({
    super.key,
    required this.title,
    required this.assignments,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Container(
      height: 145,
      width: double.infinity,
      decoration: BoxDecoration(
        color: colors.secondary,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Container(
            width: 112,
            decoration: BoxDecoration(
              color: colors.primary,
              borderRadius: const BorderRadius.only(
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
                    style: TextStyle(
                      color: colors.onSecondary,
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
                        style: TextStyle(
                          color: colors.onSecondary,
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
