class UserModel {
  final String email;
  final String phone;
  final String name;
  final String uid;
  final String profilePicture;
  final String backgroundPicture;
  final String bio;

  bool isEmailVerified = false;

  UserModel({
    required this.profilePicture,
    required this.backgroundPicture,
    required this.bio,
    required this.isEmailVerified,
    required this.name,
    required this.uid,
    required this.email,
    required this.phone,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
      email: json['email'],
      name: json['name'],
      phone: json['phone'],
      uid: json['uid'],
      isEmailVerified: json['isEmailVerified'],
      profilePicture: json['profilePicture'],
      backgroundPicture: json['backgroundPicture'],
      bio: json['bio']);

  Map<String, dynamic> toJson() => {
        'name': name,
        'phone': phone,
        'email': email,
        'uid': uid,
        'isEmailVerified': isEmailVerified,
        'profilePicture': profilePicture,
        'backgroundPicture': backgroundPicture,
        'bio': bio,
      };
}
