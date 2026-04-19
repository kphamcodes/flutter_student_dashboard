class Student {
  final String name;
  final String major;
  final DateTime enrollmentDate;
  final List<String>? hobbies;

  // Constructor using a concise syntax (syntactic sugar)
  Student({required this.name, required this.major, required this.enrollmentDate, this.hobbies = const[]});

  String dtString () {
    String month;
    switch(enrollmentDate.month){
      case 1:
        month = 'January, ';
        break;
      case 2:
        month = 'February, ';
        break;
      case 3:
        month = 'March, ';
        break;
      case 4:
        month = 'April, ';
        break;
      case 5:
        month = 'May, ';
        break;
      case 6:
        month = 'June, ';
        break;
      case 7:
        month = 'July, ';
        break;
      case 8:
        month = 'August, ';
        break;
      case 9:
        month = 'September, ';
        break;
      case 10:
        month = 'October, ';
        break;
      case 11:
        month = 'November, ';
        break;
      case 12:
        month = 'December, ';
        break;
      default:
        month = 'Invalid Date';
    }

    return month + enrollmentDate.year.toString();
  }

}