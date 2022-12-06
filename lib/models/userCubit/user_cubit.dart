import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserInitial());

  void openIntro()async{
    emit(UserLoading());
    String? uid;
    SharedPreferences.getInstance().then((preference){
     uid = preference.getString('uid');
     if(uid!= null){

     }
    });

  }
}
