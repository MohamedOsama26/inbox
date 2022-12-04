import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inbox/modules/home_screen/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitialState());

  static LoginCubit get(context) => BlocProvider.of(context);

  void login (context,
      {required String email,
      required String password,
      required bool remember}) {

    emit(LoginLoadingState());
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) async {
      emit(LoginSuccessState());

      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('uid', value.user!.uid);

      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) =>  HomeScreen(),
          ));
    }).catchError((error) {
      error = error.toString();
      String err = error.substring(error.indexOf(']')+1,error.indexOf('.'));
      print(err);
      emit(LoginErrorState(err));
    });
  }

  void reloadLoginPage() {
    emit(LoginInitialState());
  }

  void makeError() {
    emit(LoginErrorState('Error Made'));
  }
}
