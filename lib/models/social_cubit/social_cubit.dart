import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:inbox/layout/user_model.dart';

part 'social_state.dart';

class SocialCubit extends Cubit<SocialState> {
  SocialCubit() : super(SocialInitial());

  static SocialCubit get(context) => BlocProvider.of(context);


  final ImagePicker imagePicker = ImagePicker();
  UserModel? model;
  String? profileImage;
  String? coverImage;

  void getUserData(String? id) async {
    emit(ProfileInfoLoadingState());
    FirebaseFirestore.instance.collection('users').doc(id).get().then((value) {
      model = UserModel.fromJson(value.data()!);
      emit(ProfileInfoSuccessState(model: model));
    }).catchError((error) {
      emit(ProfileInfoErrorState(error.toString()));
    });
  }

  void reloadPersonalInfo(String? id) {
    emit(ProfileInfoReloadingState());
    FirebaseFirestore.instance.collection('users').doc(id).get().then((value) {
      model = UserModel.fromJson(value.data()!);
      emit(ProfileInfoSuccessState(model: model));
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
      'firstName': firstName,
      'lastName': lastName,
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
      uploadImage(image: image).then((url) {
        profileImage = url;
        emit(ProfileInfoSuccessState(newProfileUrl: url, model: model,newCoverUrl: coverImage));
      });
    } else {
      print(' No Image Selected');
      emit(ProfileImageErrorState());
    }
  }

  Future<void> updateCoverImage() async {
    final XFile? pickedFile =
    await imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      String image = pickedFile.path;
      uploadImage(image: image).then((url) {
        coverImage = url;
        emit(ProfileInfoSuccessState(newCoverUrl: url, model: model,newProfileUrl: profileImage));
      });
    } else {
      print(' No Image Selected');
      emit(ProfileImageErrorState());
    }
  }

  Future<String> uploadImage({String? id, String? image}) async {
    TaskSnapshot snapshot = await FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(image!).pathSegments.last}')
        .putFile(File(image));
    String url = await snapshot.ref.getDownloadURL(); // .then((value) {
    return url;
  }
}
