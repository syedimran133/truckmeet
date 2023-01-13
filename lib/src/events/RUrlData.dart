class RUrlData {
  final String facebook_native;
  final String facebook_web;
  final String google_native;
  final String google_web;
  final String insta_native;
  final String insta_web;
  final String twitter_native;
  final String twitter_web;

  const RUrlData({
    required this.facebook_native,
    required this.facebook_web,
    required this.google_native,
    required this.google_web,
    required this.insta_native,
    required this.insta_web,
    required this.twitter_native,
    required this.twitter_web,

  });

  factory RUrlData.fromMap(Map<dynamic, dynamic> map) {
    return RUrlData(
      facebook_native: map['facebook_native'] ?? '',
      facebook_web: map['facebook_web'] ?? '',
      google_native: map['google_native'] ?? '',
      google_web: map['google_web'] ?? '',
      insta_native: map['insta_native'] ?? '',
      insta_web: map['insta_web'] ?? '',
      twitter_native: map['twitter_native'] ?? '',
      twitter_web: map['twitter_web'] ?? '',
    );
  }
}
