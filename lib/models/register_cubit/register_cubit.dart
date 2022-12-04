// import 'package:cloud_firestore/cloud_f`irestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inbox/layout/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:inbox/layout/user_model.dart';
// import 'package:inbox/modules/home_screen/home_screen.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitialState());

  static RegisterCubit get(context) => BlocProvider.of(context);

  void register(
    context, {
    required String email,
    required String password,
    required String phone,
    required String name,
    required String profilePicture,
    required String backgroundPicture,
    required String bio,
        bool isEmailVerified = false,
  }) {
    emit(RegisterLoadingState());

    FirebaseAuth.instance
        .createUserWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((value) async {
      creatingUser(
        email: email,
        phone: phone,
        name: name,
        uid: value.user!.uid,
        backgroundPicture: backgroundPicture,
        bio: bio,
        profilePicture: profilePicture,
        isEmailVerified: isEmailVerified,
      );

      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('uid', value.user!.uid);

      emit(RegisterSuccessState());
    }).catchError((error) {
      error = error.toString();
      String err = error.substring(error.indexOf(']') + 1, error.indexOf('.'));
      // print(err);
      emit(RegisterErrorState(err));
    });
  }

  void reloadRegisterPage() {
    emit(RegisterInitialState());
  }

  void creatingUser({
    required String name,
    required String email,
    required String phone,
    required String uid,
    bool isEmailVerified = false,
    required String profilePicture,
    required String backgroundPicture,
    required String bio,
  }) {
    UserModel userModel = UserModel(
        uid: uid,
        email: email,
        phone: phone,
        name: name,
        isEmailVerified: isEmailVerified,
        profilePicture: profilePicture,
        bio: bio,
        backgroundPicture: backgroundPicture);

    FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .set(userModel.toJson());
    //     .then((value) {
    //   emit(CreatingUserSuccessState());
    // }).catchError((error) {
    //   emit(CreatingUserErrorState(error.toString()));
    // });
  }
}
