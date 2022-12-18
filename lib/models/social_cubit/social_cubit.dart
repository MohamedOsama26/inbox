import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inbox/layout/user_model.dart';

part 'social_state.dart';

class SocialCubit extends Cubit<SocialState> {
  SocialCubit() : super(SocialInitial());

  static SocialCubit get(context) => BlocProvider.of(context);

  UserModel? model;

  void getUserData(String? id) {
    emit(ProfileInfoLoadingState());

    FirebaseFirestore.instance.collection('users').doc(id).get().then((value) {
      model = UserModel.fromJson(value.data()!);

      emit(ProfileInfoSuccessState());
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
    required String bio
}){
    emit(ProfileInfoLoadingState());

    Map<String,dynamic> updatedModel = {
      'firstName':firstName,
      'lastName':lastName,
      'email':email,
      'birthday': birthday,
      'title': title,
      'bio': bio
    };

    FirebaseFirestore.instance.collection('users').doc(id).update(updatedModel).catchError((err){
      emit(ProfileInfoErrorState(err.toString()));
    });
  }

}
