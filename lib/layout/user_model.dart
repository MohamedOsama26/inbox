class UserModel {
  final String email;
  final String phone;
  final String firstName;
  final String lastName;
  final String birthday;
  final String city;
  final String gender;
  final String profilePicture;
  final String backgroundPicture;
  final String bio;
  bool isEmailVerified = false;
  final String uid;

  UserModel({
    required this.lastName,
    required this.birthday,
    required this.city,
    required this.gender,
    required this.profilePicture,
    required this.backgroundPicture,
    required this.bio,
    required this.isEmailVerified,
    required this.firstName,
    required this.uid,
    required this.email,
    required this.phone,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        email: json['email'],
        firstName: json['firstName'],
        phone: json['phone'],
        uid: json['uid'],
        isEmailVerified: json['isEmailVerified'],
        profilePicture: json['profilePicture'],
        backgroundPicture: json['backgroundPicture'],
        bio: json['bio'],
        birthday: json['birthday'],
        city: json['city'],
        gender: json['gender'],
        lastName: json['lastName'],
      );

  Map<String, dynamic> toJson() => {
        'firstName': firstName,
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
        'lastName': lastName,
      };
}
