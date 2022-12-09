import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inbox/layout/user_model.dart';

import 'package:shared_preferences/shared_preferences.dart';


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
    required String nickname,
    required String birthday,
    required String city,
    required String gender,
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
        nickname: nickname,
        birthday: birthday,
        city: city,
        gender: gender,
      );

      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('uid', value.user!.uid);

      emit(RegisterSuccessState());
    }).catchError((error) {
      error = error.toString();
      String err = error.substring(error.indexOf(']') + 1, error.indexOf('.'));

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(

          // padding: EdgeInsets.symmetric(vertical: 20.0,horizontal: 25),
          backgroundColor: Colors.transparent,
          elevation: 0,
          content: Container(
            padding: EdgeInsets.symmetric(vertical: 8.0,horizontal: 16),
            decoration: BoxDecoration(
                color: const Color(0x8C000000),
                borderRadius: BorderRadius.circular(50)
            ),
            margin: const EdgeInsets.symmetric(horizontal : 16.0,),
            height: 50,
            child:  Center(
              child: Text(err,
                textAlign: TextAlign.center,
                // style: TextStyle(
                //     fontSize: 20,
                //     color: Color(0xDAFFFFFF)
                // ),
              ),
            ),
          ),
          duration: Duration(seconds: 2),
        ),
      );
      Navigator.of(context).pop();
      print('This is the error :     ===== >>>    $err');
      emit(RegisterInitialState());
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
    required String nickname,
    required String birthday,
    required String city,
    required String gender,
  }) {
    UserModel userModel = UserModel(
        uid: uid,
        email: email,
        phone: phone,
        name: name,
        isEmailVerified: isEmailVerified,
        profilePicture: profilePicture,
        bio: bio,
        backgroundPicture: backgroundPicture,
        nickname: nickname,
        birthday: birthday,
        city: city,
        gender: gender
    );

    print('=============================>>> Here creatnig user');

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
