class UserModel {
  final String email;
  // final String password;
  final String phone;
  final String name;
  final String nickname;
  final String birthday;
  final String city;
  final String gender;
  final String profilePicture;
  final String backgroundPicture;
  final String bio;
  bool isEmailVerified = false;
  final String uid;

  UserModel({
    required this.nickname,
    required this.birthday,
    required this.city,
    required this.gender,
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
        bio: json['bio'],
        birthday: json['birthday'],
        city: json['city'],
        gender: json['gender'],
        nickname: json['nickname'],
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'phone': phone,
        'email': email,
        'uid': uid,
        'isEmailVerified': isEmailVerified,
        'profilePicture': profilePicture,
        'backgroundPicture': backgroundPicture,
        'bio': bio,
        'birthday': birthday,
        'city': city,
        'gender': gender,
        'nickname': nickname,
      };
}
