import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inbox/layout/user_model.dart';
import 'package:inbox/main.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'social_state.dart';

class SocialCubit extends Cubit<SocialState> {
  SocialCubit() : super(SocialInitial());

  static SocialCubit get(context) => BlocProvider.of(context);

  UserModel?   model;

  void getUserData (String? uid){
    emit(ProfileInfoLoadingState());
    // print('loading');
    // print(model.toString());

    FirebaseFirestore.instance.collection('users').doc(uid).get().then((value){
      // print('----------------------------------------------------');
      // print(value.data());
      // print('----------------------------------------------------');
      // print('================= Get From FireStore ${value.data()}');
      // value.data()?.forEach((key, value) {value!=null?value:'';});
      model = UserModel.fromJson(value.data()!);
      // print('Getting data');
      // print(model);
      emit(ProfileInfoSuccessState());
    }).catchError((error){
      // print(error.toString());
      emit(ProfileInfoErrorState(error.toString()));
    });
  }



}
