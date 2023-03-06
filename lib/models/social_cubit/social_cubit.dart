import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:inbox/layout/post_model.dart';
import 'package:inbox/layout/user_model.dart';
import 'package:inbox/main.dart';

part 'social_state.dart';

class SocialCubit extends Cubit<SocialState> {
  SocialCubit() : super(SocialInitial());

  static SocialCubit get(context) => BlocProvider.of(context);

  final ImagePicker imagePicker = ImagePicker();
  UserModel? model;
  UserModel? userModel;
  PostModel? postModel;
  String? profileImage;
  String? coverImage;
  List<PostModel>? posts = [];

  void getUserData(String? id) {
    emit(ProfileInfoLoadingState());
    FirebaseFirestore.instance.collection('users').doc(id).get().then((value) {
      model = UserModel.fromJson(value.data()!);
      userModel = model;
    }).then((user) {
      getPosts().then((posts) {
        getLikes().then((likes) {
          getComments().then((comments) {
            emit(ProfileInfoSuccessState(
                model: model, posts: posts, likes: likes, comments: comments));
          }).catchError((error) {
            emit(CommentsPostErrorState(error));
          });
        }).catchError((error) {
          emit(LikePostErrorState(error));
        });
      }).catchError((error) {
        emit(GetPostsErrorState(error.toString()));
      });
    }).catchError((error) {
      emit(ProfileInfoErrorState(error.toString()));
    });
  }

  void reloadPersonalInfo(String? id) {
    emit(ProfileInfoReloadingState());
    FirebaseFirestore.instance.collection('users').doc(id).get().then((value) {
      model = UserModel.fromJson(value.data()!);
      userModel = model;
    }).then((user) {
      getPosts().then((posts) {
        getLikes().then((likes) {
          getComments().then((comments) {
            emit(ProfileInfoSuccessState(
                model: model, posts: posts, likes: likes, comments: comments));
          }).catchError((error) {
            emit(CommentsPostErrorState(error));
          });
        }).catchError((error) {
          emit(LikePostErrorState(error));
        });
      }).catchError((error) {
        emit(GetPostsErrorState(error.toString()));
      });
    }).catchError((error) {
      emit(ProfileInfoErrorState(error.toString()));
    });
  }

  void updatePersonalInfo({
    String? id,
    required String firstName,
    required String lastName,
    required String email,
    required String birthday,
    required String title,
    required String bio,
    required String currentCity,
    required String phone,
    required String backgroundPicture,
    required String profilePicture,
  }) async {
    emit(ProfileInfoLoadingState());

    Map<String, dynamic> updatedModel = {
      'firstName': firstName.trim(),
      'lastName': lastName.trim(),
      'email': email,
      'birthday': birthday,
      'title': title,
      'bio': bio,
      'phone': phone,
      'city': currentCity,
      'profilePicture': profilePicture,
      'backgroundPicture': backgroundPicture
    };

    FirebaseFirestore.instance
        .collection('users')
        .doc(id)
        .update(updatedModel)
        .then((_) {
      reloadPersonalInfo(id);
    });
  }

  Future<void> updateProfileImage() async {
    final XFile? pickedFile =
        await imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      String image = pickedFile.path;
      uploadImage(image: image, collection: 'users/').then((url) {
        profileImage = url;
        emit(ProfileInfoSuccessState(
            newProfileUrl: url, model: model, newCoverUrl: coverImage));
      });
    } else {
      print(' No Image Selected');
      emit(ImageErrorState());
    }
  }

  Future<void> updateCoverImage() async {
    final XFile? pickedFile =
        await imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      String image = pickedFile.path;
      uploadImage(image: image, collection: 'covers/').then((url) {
        coverImage = url;
        emit(ProfileInfoSuccessState(
            newCoverUrl: url, model: model, newProfileUrl: profileImage));
      });
    } else {
      print(' No Image Selected');
      emit(ImageErrorState());
    }
  }

  void removePostImage() {
    emit(PostImageLoadingState());
    postImage = null;
    emit(PostImageSuccessState());
  }

  File? postImage;
  Future<void> pickPostImage() async {
    emit(CreatePostLoadingState());
    final XFile? pickedFile =
        await imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      postImage = File(pickedFile.path);
      print('Picked');
      emit(CreatePostSuccessState());
    } else {
      print('No file Selected');
    }
  }

  void uploadPostImage({
    required String dateTime,
    required String text,
  }) {
    emit(CreatePostLoadingState());
    FirebaseStorage.instance
        .ref()
        .child('posts/${Uri.file(postImage!.path).pathSegments.last}')
        .putFile(postImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        createPost(dateTime: dateTime, text: text, postImage: value);
      }).catchError((error) {
        print(error);
        emit(CreatePostErrorsState());
      }).catchError((error) {
        print(error);
        emit(CreatePostErrorsState());
      });
    });
  }

  void createPost(
      {required String dateTime,
      required String text,
      String? postImage}) async {
    Map<String, dynamic> model = {
      'uid': userModel!.uid,
      'name': '${userModel!.firstName} ${userModel!.lastName}',
      'profileImage': userModel!.profilePicture,
      'text': text,
      'postImage': postImage ?? '',
      'dateTime': dateTime
    };

    FirebaseFirestore.instance.collection('posts').add(model).then((_) {
      emit(CreatePostSuccessState());
    }).catchError((error) {
      emit(CreatePostErrorsState());
    });
  }

  Future<String> uploadImage(
      {String? id, String? image, required String collection}) async {
    TaskSnapshot snapshot = await FirebaseStorage.instance
        .ref()
        .child('$collection/${Uri.file(image!).pathSegments.last}')
        .putFile(File(image));
    String url = await snapshot.ref.getDownloadURL();
    return url;
  }

  List<String> postsId = [];

  Future<List<PostModel>> getPosts() async {
    QuerySnapshot<Map<String, dynamic>> snapshot =
        await FirebaseFirestore.instance.collection('posts').get();
    List<PostModel> posts = [];
    for (var element in snapshot.docs) {
      postsId.add(element.id);
      posts.add(PostModel.fromJson(element.data()));
    }
    return posts;
  }

  Future<List<int>> getLikes() async {
    List<int> postLikes = [];
    QuerySnapshot<Map<String, dynamic>> likesSnapshot =
        await FirebaseFirestore.instance.collection('posts').get();
    for (var element in likesSnapshot.docs) {
      QuerySnapshot<Map<String, dynamic>> likes =
          await element.reference.collection('likes').get();
      postLikes.add(likes.docs.length);
    }
    return postLikes;
  }

  Future<List<int>> getComments() async {
    List<int> postComments = [];
    QuerySnapshot<Map<String, dynamic>> postsSnapshot =
        await FirebaseFirestore.instance.collection('posts').get();
    for (var post in postsSnapshot.docs) {
      QuerySnapshot<Map<String, dynamic>> comments =
          await post.reference.collection('comments').get();
      postComments.add(comments.docs.length);
    }
    return postComments;
  }

  void likePost(String postId) async {
    await FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .doc(uid)
        .set({'like': true});
  }

  Future<void> submitComment(String postId, String commentContent) async {
    print(uid);
    await FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('comments')
        .add({
      'uid': uid,
      'content': commentContent,
      'commentTime': DateTime.now(),
    });
  }

  List<UserModel> allUsers = [];

  Future<void> getAllUsers() async {
    // emit(GetAllUsersLoadingState());
    print('loading');
    allUsers = [];

    QuerySnapshot<Map<String, dynamic>> snapshots =
        await FirebaseFirestore.instance.collection('users').get();

    for (var doc in snapshots.docs) {
      // print(doc);
      UserModel user = UserModel.fromJson(doc.data());
      // print('${user.firstName} ${user.lastName}');
      if (user.uid != userModel?.uid) {
        allUsers.add(user);
      }
      // print(allUsers);
    }
    // print(allUsers);
    emit(GetAllUsersSuccessState(allUsers));
    print(allUsers.length);
    // print(allUsers);
    // print('--------');
  }

  Future<void> sendChatMessage({
    required String receiverId,
    required String messageContent,
    required String senderId,
  }) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userModel?.uid)
        .collection('chats').doc('messages')
        .collection('messages').add({
      'receiverId':receiverId,
      'messageContent':messageContent,
      'senderId':senderId,
      'dateTime': DateTime.now()
    });
  }
}
