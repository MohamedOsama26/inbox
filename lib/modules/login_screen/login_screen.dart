import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inbox/modules/signup_screen/signup_screen.dart';
import 'package:inbox/shared/widgets/checkbox_style_1.dart';
import 'package:page_transition/page_transition.dart';
import '../../models/login_cubit/login_cubit.dart';
import '../../shared/widgets/text_field_style_1.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final RegExp emailValid = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  bool isPassword = true;
  bool rememberUser = false;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginCubit>(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {},
        builder: (context, state){
          if (state is LoginLoadingState) {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else if (state is LoginErrorState) {
            return Scaffold(
              body: Center(
                child: SizedBox(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Sorry Something went wrong'),
                      Text(state.error),
                      MaterialButton(
                        onPressed: () =>
                            LoginCubit.get(context).reloadLoginPage(),
                        child: const Text('Reload'),
                      )
                    ],
                  ),
                ),
              ),
            );
          }
          return Scaffold(
            body: SingleChildScrollView(
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 100.0, left: 20.0, right: 20.0, bottom: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        'Hello! Welcome back!',
                        style: TextStyle(
                            fontSize: Theme.of(context)
                                .textTheme
                                .headline5!
                                .fontSize),
                      ),
                      Text(
                        'Hello again, You’ve been missed!',
                        style: TextStyle(
                            fontSize:
                                Theme.of(context).textTheme.headline6!.fontSize,
                            color: Colors.black26),
                      ),
                      const SizedBox(height: 40.0),
                      Form(
                        key: formKey,
                        child: Column(
                          children: [
                            TextFieldStyle1(
                              controller: emailController,
                              label: 'Email Address',
                              inputType: TextInputType.emailAddress,
                              hint: 'Enter your email',
                              validationFunction: (input) {
                                if (input == null ||
                                    input.isEmpty ||
                                    !emailValid.hasMatch(input)) {
                                  return 'Please enter valid Email';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 10.0),
                            TextFieldStyle1(
                              controller: passwordController,
                              label: 'Password',
                              hint: 'Enter your password',
                              inputType: isPassword
                                  ? TextInputType.visiblePassword
                                  : TextInputType.text,
                              isPassword: isPassword,
                              icon: isPassword
                                  ? const Icon(Icons.visibility)
                                  : const Icon(Icons.visibility_off),
                              onTab: () => setState(() {
                                isPassword = !isPassword;
                              }),
                              validationFunction: (input) {
                                if (input == null || input.isEmpty) {
                                  return 'Please enter your Password';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 12.0),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                CheckboxStyle1(
                                  isChecked: rememberUser,
                                  clickFunction: () => setState(() {
                                    rememberUser = !rememberUser;
                                  }),
                                  text: 'Remember me',
                                ),
                                const Spacer(),
                                TextButton(
                                  onPressed: () {},
                                  child: Text(
                                    'Forgot Password',
                                    style: TextStyle(
                                      fontSize: Theme.of(context)
                                          .textTheme
                                          .titleSmall!
                                          .fontSize,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 40.0,
                            ),
                            SizedBox(
                              width: double.infinity,
                              height: 44.0,
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(4.0),
                                    ),
                                  ),
                                ),
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    LoginCubit.get(context).login(context,
                                        email: emailController.text,
                                        password: passwordController.text,
                                        remember: rememberUser);
                                  }
                                },
                                child: Text(
                                  'Login',
                                  style: TextStyle(
                                    fontSize: Theme.of(context)
                                        .textTheme
                                        .titleMedium!
                                        .fontSize,
                                  ),
                                ),
                                // color: Theme.of(context).primaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 80,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Expanded(
                            child: Divider(
                              thickness: 1.0,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Or Login with',
                              style: TextStyle(
                                  fontSize: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .fontSize,
                                  color: Colors.black54),
                            ),
                          ),
                          const Expanded(
                              child: Divider(
                            thickness: 1.0,
                          )),
                        ],
                      ),
                      const SizedBox(
                        height: 16.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                            width: 140.0,
                            child: OutlinedButton(
                              onPressed: () => print('Facebook'),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Icon(
                                    Icons.facebook,
                                    color: Colors.blue,
                                  ),
                                  SizedBox(
                                    width: 6.0,
                                  ),
                                  Text(
                                    'Facebook',
                                    style: TextStyle(color: Colors.black54),
                                  )
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 140.0,
                            child: OutlinedButton(
                              onPressed: () => print('Google'),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Icon(
                                    IconData(
                                      0xf1a0,
                                      fontFamily: 'icons',
                                    ),
                                    color: Colors.deepOrangeAccent,
                                  ),
                                  SizedBox(
                                    width: 6.0,
                                  ),
                                  Text(
                                    'Google',
                                    style: TextStyle(color: Colors.black54),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Dont\'t have an account?  ',
                            style: TextStyle(
                                color: Colors.black54,
                                fontSize: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .fontSize),
                          ),
                          TextButton(
                              onPressed: () => Navigator.pushReplacement(
                                    context,
                                    PageTransition(
                                      child: const SignupScreen(),
                                      type: PageTransitionType.leftToRight,
                                    ),
                                  ),
                              child: const Text('Sign UP'))
                        ],
                      ),
                      // MaterialButton(
                      //   onPressed: () => LoginCubit.get(context).makeError(),
                      //   child: const Text('Make Error'),
                      // ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
