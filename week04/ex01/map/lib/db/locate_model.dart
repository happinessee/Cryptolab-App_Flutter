class Location {
  final int id;
  final int year;
  final int month;
  final int day;
  final int hour;
  final int minute;
  final double latitude;
  final double longitude;
  // year, month, day, hour, minute, 기록할 때 더 좋은 방식이 있는지 확인해보기 (효율성 / 용량)
  // 앱 내에서는 데이터가 많이 쌓이지 않아서 (사용자가 한 명이라서)
  // string으로 넣어서
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
