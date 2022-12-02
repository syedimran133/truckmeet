
class UserData{

  final String device;
  final String email;
  final String loginDate;
  final String name;
  final String phone;
  final String subscribed;
  final String uid;
  final String userType;
  const UserData({
    required this.device,
    required this.email,
    required this.loginDate,
    required this.name,
    required this.phone,
    required this.subscribed,
    required this.uid,
    required this.userType,
  });
  factory UserData.fromMap(Map<dynamic, dynamic> map) {
    return UserData(
      device: map['device'] ?? '',
      email: map['email'] ?? '',
      loginDate: map['loginDate'] ?? '',
      name: map['name'] ?? '',
      phone: map['phone'] ?? '',
      subscribed: map['subscribed'] ?? '',
      uid: map['uid'] ?? '',
      userType: map['userType'] ?? '',
    );
  }
}