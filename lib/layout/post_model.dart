class PostModel {
  final String name;
  final String profileImage;
  final String uid;
  final String text;
  final String postImage;
  final String dateTime;

  PostModel({
    required this.uid,
    required this.name,
    required this.profileImage,
    required this.text,
    required this.postImage,
    required this.dateTime
  });

  factory PostModel.fromJson(Map<String, dynamic> json) => PostModel(
    name: json['name'],
    postImage: json['postImage'],
    uid: json['uid'],
    profileImage: json['profileImage'],
    text: json['text'],
    dateTime: json['dateTime'],
  );

  Map<String, dynamic> toJson() => {
    'uid': uid,
    'name': name,
    'profileImage': profileImage,
    'postImage': postImage,
    'text': text,
    'dateTime': dateTime,
  };
}
