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

  UserModel? model;

  void getUserData(String? id) async {
    emit(ProfileInfoLoadingState());
    FirebaseFirestore.instance.collection('users').doc(id).get().then((value) {
      model = UserModel.fromJson(value.data()!);
      emit(ProfileInfoSuccessState(model));
    }).catchError((error) {
      emit(ProfileInfoErrorState(error.toString()));
    });
  }

  void reloadPersonalInfo(String? id) {
    emit(ProfileInfoReloadingState());
    FirebaseFirestore.instance.collection('users').doc(id).get().then((value) {
      model = UserModel.fromJson(value.data()!);
      emit(ProfileInfoSuccessState(model));
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
      'city': currentCity
    };

    FirebaseFirestore.instance
        .collection('users')
        .doc(id)
        .update(updatedModel)
        .catchError((error) {
      emit(ProfileInfoErrorState(error.toString()));
    });
  }

  final ImagePicker imagePicker = ImagePicker();
  File? profileImage;
  File? coverImage;

  void updateProfileImage() async {
    final XFile? pickedFile =
        await imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      emit(ProfileImageSuccessState());
    } else {
      print(' No Image Selected');
      emit(ProfileImageErrorState());
    }
  }

  void updateCoverImage() async {
    final XFile? pickedFile =
        await imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      coverImage = File(pickedFile.path);
      emit(CoverImageSuccessState());
    } else {
      print(' No Image Selected');
      emit(CoverImageErrorState());
    }
  }

  void uploadProfileImage() {
    FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {}).catchError((error) {});
    }).catchError((error) {});
  }
}
