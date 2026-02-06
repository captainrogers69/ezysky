import '/utils/constants/k_assets.dart';

class UserModel {
  final String? profilePic;
  final String? userName;
  final String? fullName;
  final String? userId;
  final String? email;
  const UserModel({
    required this.profilePic,
    required this.fullName,
    required this.userName,
    required this.userId,
    required this.email,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      profilePic: json['profilePic'] ?? KAssets.userNetworkImage,
      fullName: json['fullName'] ?? 'Unknown User',
      userName: json['userName'],
      userId: json['userId'],
      email: json['email'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "profilePic": profilePic,
      "userId": userId,
      "email": email,
      "userName": userName,
      "fullName": fullName,
    };
  }

  // add copy with if needed
}
