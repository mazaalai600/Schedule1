class UserModel {
  UserModel({
    required this.userId,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.username,
    required this.phone,
    required this.fcmToken,
    required this.createdAt,
    required this.role,
    required this.profileImage,
  });

  String userId;
  String firstName;
  String lastName;
  String username;
  String phone;
  String fcmToken;
  String email;
  String role;
  String createdAt;
  String profileImage;

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      userId: json['userId'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      username: json['username'],
      phone: json['phone'],
      fcmToken: json['fcmToken'],
      email: json['email'],
      createdAt: json['createdAt'],
      role: json['role'],
      profileImage: json['profileImage'] ?? '',
    );
  }
  toJson() {
    return {
      "userId": userId,
      "firstName": firstName,
      "lastName": lastName,
      "email": email,
      "phone": phone,
      'fcmToken': fcmToken,
      "username": username,
      'createdAt': createdAt,
      'role': role,
      'profileImage': profileImage,
    };
  }
}
