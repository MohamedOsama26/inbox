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
      emit(ProfileInfoSuccessState(model:model));
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

  String? profileUrl;
  String? newUrl;

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
        print(profileUrl);
        getUserData(id);
        reloadPersonalInfo(id);
      });

  }

  final ImagePicker imagePicker = ImagePicker();
  String? profileImage;
  String? coverImage;

  Future<String?> updateProfileImage() async {
    emit(ProfileInfoLoadingState());
    String? url;
    final XFile? pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      String image = pickedFile.path;
    uploadProfileImage(image: image).then((url){emit(ProfileInfoSuccessState(newUrl: url,model: model));});
    } else {
      print(' No Image Selected');
      emit(ProfileImageErrorState());
    }
    return url;
  }

  void updateCoverImage() async {
    final XFile? pickedFile =
        await imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      coverImage = pickedFile.path;
      // emit(CoverImageSuccessState());
    } else {
      print(' No Image Selected');
      emit(CoverImageErrorState());
    }
  }

  Future<String> uploadProfileImage({String? id,String? image}) async {
    TaskSnapshot snapshot = await FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(image!).pathSegments.last}')
        .putFile(File(image));
    String url = await snapshot.ref.getDownloadURL(); // .then((value) {
    return url;
  }
}
