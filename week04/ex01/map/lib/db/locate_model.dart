class Location {
  final int id;
  final int year;
  final int month;
  final int day;
  final int hour;
  final int minute;
  final double latitude;
  final double longitude;

  Location({
    required this.id,
    required this.year,
    required this.month,
    required this.day,
    required this.hour,
    required this.minute,
    required this.latitude,
    required this.longitude,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'year': year,
      'month': month,
      'day': day,
      'hour': hour,
      'minute': minute,
      'latitude': latitude,
      'longitude': longitude,
    };
  }

  @override
  String toString() {
    return 'Location{time: $year-$month-$day $hour:$minute latitude: $latitude, longitude: $longitude}';
  }
}
