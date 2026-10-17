enum ActivityType { payment, request }

class Activity {
  const Activity(
      {required this.type, required this.title, required this.date});
  final ActivityType type;
  final String title;
  final DateTime date;
}
