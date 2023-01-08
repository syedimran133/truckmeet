class UrlData {
  final String about_us;
  final String privacy_policy;
  final String tnc;

  const UrlData({
    required this.about_us,
    required this.privacy_policy,
    required this.tnc

  });

  factory UrlData.fromMap(Map<dynamic, dynamic> map) {
    return UrlData(
      about_us: map['about_us'] ?? '',
      privacy_policy: map['privacy_policy'] ?? '',
      tnc: map['tnc'] ?? '',
    );
  }
}
