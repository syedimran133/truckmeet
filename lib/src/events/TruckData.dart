class TruckData {
  final String description;
  final String hq;
  final String model;
  final String ownership_status;
  final String tq;
  final String truck_transmission;
  final String imran_url;

  const TruckData({
    required this.description,
    required this.hq,
    required this.model,
    required this.ownership_status,
    required this.tq,
    required this.truck_transmission,
    required this.imran_url,
  });

  factory TruckData.fromMap(Map<dynamic, dynamic> map) {
    return TruckData(
      description: map['description'] ?? '',
      hq: map['hq'] ?? '',
      model: map['model'] ?? '',
      ownership_status: map['ownership_status'] ?? '',
      tq: map['tq'] ?? '',
      truck_transmission: map['truck_transmission'] ?? '',
      imran_url: map['imran_url'] ?? '',
    );
  }
}
