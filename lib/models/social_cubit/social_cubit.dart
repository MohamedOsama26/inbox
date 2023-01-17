import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:inbox/layout/post_model.dart';
import 'package:inbox/layout/user_model.dart';

import '../../main.dart';

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
    print('UID in social_cubit getUserDataFun. ==> $uid');
    print('ID in social_cubit getUserDataFun. ==> $id');
    emit(ProfileInfoLoadingState());
    FirebaseFirestore.instance.collection('users').doc(id).get().then((value) {
      model = UserModel.fromJson(value.data()!);
      userModel = model;
    }).then((user) {
      print('UID in social_cubit of the model ==> ${model?.uid}');
      getPosts().then((posts) {
        emit(ProfileInfoSuccessState(model: model, posts: posts));
      }).catchError((error) {
        emit(GetPostsErrorState(error.toString()));
      });
    }).catchError((error) {
      emit(ProfileInfoErrorState(error.toString()));
    });
  }

  // void reloadPersonalInfo(String? id) {
  //   emit(ProfileInfoReloadingState());
  //   FirebaseFirestore.instance.collection('users').doc(id).get().then((value) {
  //     model = UserModel.fromJson(value.data()!);
  //     emit(ProfileInfoSuccessState(model: model));
  //   }).catchError((error) {
  //     emit(ProfileInfoErrorState(error.toString()));
  //   });
  // }

  void reloadPersonalInfo(String? id) {
    emit(ProfileInfoReloadingState());
    FirebaseFirestore.instance.collection('users').doc(id).get().then((value) {
      model = UserModel.fromJson(value.data()!);
      userModel = model;
    }).then((user) {
      getPosts().then((posts) {
        emit(ProfileInfoSuccessState(model: model, posts: posts));
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

        print(value);
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
    String url = await snapshot.ref.getDownloadURL(); // .then((value) {
    return url;
  }

  List<String> postsId = [];
  List<int> postLikes = [] ;

  Future<List<PostModel>> getPosts() async {
    QuerySnapshot<Map<String, dynamic>> snapshot =
        await FirebaseFirestore.instance.collection('posts').get();
    List<PostModel> posts = [];
    for (var element in snapshot.docs) {
      QuerySnapshot<Map<String,dynamic>> snapshot = await element.reference.collection('likes').get();
      int likes = snapshot.docs.length;
      postLikes.add(likes);
      postsId.add(element.id);
      posts.add(PostModel.fromJson(element.data()));
    }

    return posts;
  }

  void likePost(String postId) async {
    await FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .doc(userModel?.uid)
        .set({'like' : true});

    print('like : $postId');

    //     .then((value) {
    //       emit(LikePostSuccessState());
    // })
    //     .catchError((error) {
    //       emit(LikePostErrorState(error.toString()));
    // });
  }
}
