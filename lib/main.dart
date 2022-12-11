import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inbox/firebase_options.dart';
import 'package:inbox/models/register_cubit/register_cubit.dart';
import 'package:inbox/modules/login_screen/login_screen.dart';
import 'package:inbox/modules/main_page.dart';
import 'package:inbox/shared/bloc_observer.dart';
import 'package:shared_preferences/shared_preferences.dart';

String? uid;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SharedPreferences preferences = await SharedPreferences.getInstance();
  uid = preferences.getString('uid');
  Bloc.observer = MyBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<RegisterCubit>(
          create: (BuildContext context) => RegisterCubit(),
        ),
        // BlocProvider<SocialCubit>(
        //   create: (BuildContext context) => SocialCubit(),
        // ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: uid != null ? MainPage(uid) : const LoginScreen(),
      ),
    );
  }
}
