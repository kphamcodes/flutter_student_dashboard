class Course {
  final String code;
  final String name;
  final String instructor;

  const Course({
    required this.code,
    required this.name,
    required this.instructor,
  });

  bool matches({
    required String courseQuery,
    required String codeQuery,
    required String instructorQuery,
  }) {
    final nameValue = name.toLowerCase();
    final codeValue = code.toLowerCase();
    final instructorValue = instructor.toLowerCase();

    final matchesCourse =
        courseQuery.isEmpty || nameValue.contains(courseQuery.toLowerCase());
    final matchesCode =
        codeQuery.isEmpty || codeValue.contains(codeQuery.toLowerCase());
    final matchesInstructor = instructorQuery.isEmpty ||
        instructorValue.contains(instructorQuery.toLowerCase());

    return matchesCourse && matchesCode && matchesInstructor;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Course &&
        other.code == code &&
        other.name == name &&
        other.instructor == instructor;
  }

  @override
  int get hashCode => code.hashCode ^ name.hashCode ^ instructor.hashCode;
}
