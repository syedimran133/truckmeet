
class EventsData{
  final double Latitude;
  final double Longitude;
  final bool allday;
  final String description;
  final String end_date;
  final String end_time;
  final String event_type;
  final String imran_url;
  final String location;
  final String meet_type;
  final String name;
  final String start_date;
  final String start_time;
  const EventsData({
    required this.Latitude,
    required this.Longitude,
    required this.allday,
    required this.description,
    required this.end_date,
    required this.end_time,
    required this.event_type,
    required this.imran_url,
    required this.location,
    required this.meet_type,
    required this.name,
    required this.start_date,
    required this.start_time,
  });
  factory EventsData.fromMap(Map<dynamic, dynamic> map) {
    return EventsData(
      Latitude: map['Latitude'] ?? 0.0,
      Longitude: map['Longitude'] ?? 0.0,
      allday: map['allday'] ?? false,
      description: map['description'] ?? '',
      end_date: map['end_date'] ?? '',
      end_time: map['end_time'] ?? '',
      event_type: map['event_type'] ?? '',
      imran_url: map['imran_url'] ?? '',
      location: map['location'] ?? '',
      meet_type: map['meet_type'] ?? '',
      name: map['name'] ?? '',
      start_date: map['start_date'] ?? '',
      start_time: map['start_time'] ?? '',
    );
  }
}