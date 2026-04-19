import 'package:flutter/material.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _courseController = TextEditingController();
  final TextEditingController _codeController = TextEditingController();
  final TextEditingController _instructorController = TextEditingController();

  final List<String> _searchResults = [];
  final List<String> _cartItems = [];

  int? _selectedSearchIndex;
  int? _selectedCartIndex;
  String? _searchError;

  final List<String> _allCourses = const [
    'CS101 | Programming Essentials | John Doe',
    'CS102 | Data Structures & Algorithms | Jane Doe',
    'CS103 | Computer Systems | Bill Gates',
    'CS121 | Programming Essentials II | John Doe',
    'CS124 | Compiler Language | John Smith',
    'CS130 | Operating Systems | Bill Gates',
    'CS132 | Cyber Security | John Connor',
    'CS137 | Mobile Software Engr | Leslie Reyes',
    'CS138 | Database Systems I | Daphne Chen',
  ];

  @override
  void dispose() {
    _courseController.dispose();
    _codeController.dispose();
    _instructorController.dispose();
    super.dispose();
  }

  String? _validateCourseCode(String? value) {
    final text = value?.trim() ?? '';

    if (text.isEmpty) return null;

    final regExp = RegExp(r'^CS\d{3}$');
    if (!regExp.hasMatch(text.toUpperCase())) {
      return 'Invalid Course Code';
    }

    return null;
  }

  void _submitSearch() {
    final courseQuery = _courseController.text.trim();
    final codeQuery = _codeController.text.trim();
    final instructorQuery = _instructorController.text.trim();

    if (courseQuery.isEmpty && codeQuery.isEmpty && instructorQuery.isEmpty) {
      setState(() {
        _searchResults.clear();
        _selectedSearchIndex = null;
        _searchError = null;
      });
      return;
    }

    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) {
      setState(() {
        _searchResults.clear();
        _selectedSearchIndex = null;
        _searchError = null;
      });
      return;
    }

    final results = _allCourses.where((course) {
      final lowerCourse = course.toLowerCase();

      final matchesCourse =
          courseQuery.isEmpty || lowerCourse.contains(courseQuery.toLowerCase());
      final matchesCode =
          codeQuery.isEmpty || lowerCourse.contains(codeQuery.toLowerCase());
      final matchesInstructor = instructorQuery.isEmpty ||
          lowerCourse.contains(instructorQuery.toLowerCase());

      return matchesCourse && matchesCode && matchesInstructor;
    }).toList();

    setState(() {
      _searchResults
        ..clear()
        ..addAll(results);
      _selectedSearchIndex = null;
      _searchError = results.isEmpty ? 'No matching courses found.' : null;
    });
  }

  void _addSelectedToCart() {
    if (_selectedSearchIndex == null) return;

    final selectedCourse = _searchResults[_selectedSearchIndex!];

    setState(() {
      if (!_cartItems.contains(selectedCourse)) {
        _cartItems.add(selectedCourse);
      }
      _selectedCartIndex = _cartItems.indexOf(selectedCourse);
    });
  }

  void _removeSelectedFromCart() {
    if (_selectedCartIndex == null) return;

    setState(() {
      _cartItems.removeAt(_selectedCartIndex!);
      _selectedCartIndex = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              colors.surface,
              colors.surface,
              colors.secondary,
            ],
            stops: const [0.0, 0.8, 1.0],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _RegistrationFormCard(
                        formKey: _formKey,
                        courseController: _courseController,
                        codeController: _codeController,
                        instructorController: _instructorController,
                        onSearch: _submitSearch,
                        codeValidator: _validateCourseCode,
                      ),
                      const SizedBox(height: 16),
                      _SectionCard(
                        title: 'Search Results:',
                        items: _searchResults,
                        selectedIndex: _selectedSearchIndex,
                        emptyMessage: _searchError ?? 'No courses yet',
                        onItemTap: (index) {
                          setState(() {
                            _selectedSearchIndex = index;
                          });
                        },
                        actionLabel: 'Add to Cart',
                        onActionPressed: _addSelectedToCart,
                      ),
                      const SizedBox(height: 16),
                      _SectionCard(
                        title: 'Cart:',
                        items: _cartItems,
                        selectedIndex: _selectedCartIndex,
                        emptyMessage: 'Cart is empty',
                        onItemTap: (index) {
                          setState(() {
                            _selectedCartIndex = index;
                          });
                        },
                        trailingButtons: [
                          _SmallActionButton(
                            label: 'Remove',
                            onPressed: _removeSelectedFromCart,
                          ),
                          const SizedBox(width: 8),
                          _SmallActionButton(
                            label: 'Enroll',
                            onPressed: () {},
                          ),
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
                  color: colors.secondary,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: _BottomBarItem(
                        icon: Icons.home,
                        isSelected: false,
                        onTap: () => Navigator.pop(context),
                      ),
                    ),
                    const Expanded(
                      child: _BottomBarItem(
                        icon: Icons.calendar_month_outlined,
                        isSelected: false,
                      ),
                    ),
                    const Expanded(
                      child: _BottomBarItem(
                        icon: Icons.assignment,
                        isSelected: true,
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RegistrationFormCard extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController courseController;
  final TextEditingController codeController;
  final TextEditingController instructorController;
  final VoidCallback onSearch;
  final String? Function(String?) codeValidator;

  const _RegistrationFormCard({
    required this.formKey,
    required this.courseController,
    required this.codeController,
    required this.instructorController,
    required this.onSearch,
    required this.codeValidator,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: colors.secondary,
        borderRadius: BorderRadius.circular(8),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 8,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 40,
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              color: colors.secondary,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
            ),
            alignment: Alignment.centerLeft,
            child: Text(
              'Course Registration',
              style: TextStyle(
                color: colors.onSecondary,
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 8),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Search By:',
                    style: TextStyle(
                      color: colors.onSecondary,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 18),
                  _RegistrationFieldRow(
                    label: 'Name:',
                    controller: courseController,
                  ),
                  const SizedBox(height: 12),
                  _RegistrationFieldRow(
                    label: 'Code:',
                    controller: codeController,
                    validator: codeValidator,
                  ),
                  const SizedBox(height: 12),
                  _RegistrationFieldRow(
                    label: 'Instructor:',
                    controller: instructorController,
                  ),
                  const SizedBox(height: 12),
                  Align(
                    alignment: Alignment.centerRight,
                    child: _SmallActionButton(
                      label: 'Search',
                      onPressed: onSearch,
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

class _RegistrationFieldRow extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final String? Function(String?)? validator;

  const _RegistrationFieldRow({
    required this.label,
    required this.controller,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 90,
          child: Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Text(
              label,
              style: TextStyle(
                color: colors.onSecondary,
                fontSize: 14,
              ),
            ),
          ),
        ),
        Expanded(
          child: TextFormField(
            controller: controller,
            validator: validator,
            style: TextStyle(color: colors.onSecondary),
            decoration: InputDecoration(
              isDense: true,
              filled: true,
              fillColor: const Color.fromARGB(255, 34, 33, 33),
              contentPadding: EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 10,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _SectionCard extends StatelessWidget {
  final String title;
  final List<String> items;
  final int? selectedIndex;
  final String emptyMessage;
  final ValueChanged<int>? onItemTap;
  final String? actionLabel;
  final VoidCallback? onActionPressed;
  final List<Widget>? trailingButtons;

  const _SectionCard({
    required this.title,
    required this.items,
    required this.selectedIndex,
    required this.emptyMessage,
    this.onItemTap,
    this.actionLabel,
    this.onActionPressed,
    this.trailingButtons,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 12),
      decoration: BoxDecoration(
        color: colors.surface,
        border: Border.all(color: Colors.black26),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: colors.onSurface,
              fontSize: 15,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 10),
          if (items.isEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Text(
                emptyMessage,
                style: TextStyle(
                  color: emptyMessage.contains('No matching')
                      ? Colors.red
                      : Colors.black54,
                  fontSize: 13,
                  fontWeight: emptyMessage.contains('No matching')
                      ? FontWeight.w600
                      : FontWeight.w400,
                ),
              ),
            )
          else
            ...List.generate(items.length, (index) {
              final item = items[index];
              final isSelected = selectedIndex == index;

              return Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: InkWell(
                  borderRadius: BorderRadius.circular(6),
                  onTap: onItemTap == null ? null : () => onItemTap!(index),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 10,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected ? colors.primary : colors.secondary,
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: colors.primary, width: 2),
                    ),
                    child: Text(
                      item,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: colors.onSecondary,
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              );
            }),
          if (trailingButtons != null)
            Align(
              alignment: Alignment.centerRight,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: trailingButtons!,
              ),
            )
          else if (actionLabel != null)
            Align(
              alignment: Alignment.centerRight,
              child: _SmallActionButton(
                label: actionLabel!,
                onPressed: onActionPressed ?? () {},
              ),
            ),
        ],
      ),
    );
  }
}

class _SmallActionButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  const _SmallActionButton({
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return SizedBox(
      height: 28,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          padding: EdgeInsets.zero,
          minimumSize: Size.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        child: Ink(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                colors.primary,
                colors.secondary,
              ],
            ),
          ),
          child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Text(
              label,
              style: TextStyle(
                color: colors.onPrimary,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
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
    this.isSelected = false,
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
        child: Icon(
          icon,
          color: iconColor,
          size: 28,
        ),
      ),
    );
  }
}

