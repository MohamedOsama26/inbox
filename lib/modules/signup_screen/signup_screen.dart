import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inbox/models/register_cubit/register_cubit.dart';
import 'package:inbox/modules/login_screen/login_screen.dart';
import 'package:inbox/modules/regiser_new_user_information/register_new_user_information.dart';
import 'package:inbox/shared/widgets/checkbox_style_1.dart';
import 'package:page_transition/page_transition.dart';
import '../../shared/widgets/text_field_style_1.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final RegExp emailValid = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  final RegExp phoneValid = RegExp(r"^01[0125][0-9]{8}$");
  bool isPassword = true;
  bool rememberUser = false;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<RegisterCubit>(
      create: (context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterState>(
          listener: (context, state) {
        // if(state is )
      }, builder: (context, state) {
        if (state is RegisterLoadingState) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (state is RegisterErrorState) {
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
                          RegisterCubit.get(context).reloadRegisterPage(),
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
                    top: 80.0, left: 20.0, right: 20.0, bottom: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      'Create Account',
                      style: TextStyle(
                          fontSize:
                              Theme.of(context).textTheme.headline5!.fontSize),
                    ),
                    Text(
                      'Connect with your Friends Today!',
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
                          const SizedBox(
                            height: 10.0,
                          ),
                          TextFieldStyle1(
                            controller: phoneController,
                            label: 'Phone Number',
                            inputType: TextInputType.phone,
                            hint: 'Enter your mobile number',
                            validationFunction: (input) {
                              if (input == null ||
                                  input.isEmpty ||
                                  !phoneValid.hasMatch(input)) {
                                return 'Please enter valid Phone number';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          TextFieldStyle1(
                            controller: passwordController,
                            label: 'Password',
                            hint: 'Enter your password',
                            inputType: TextInputType.visiblePassword,
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
                          CheckboxStyle1(
                            isChecked: rememberUser,
                            clickFunction: () => setState(() {
                              rememberUser = !rememberUser;
                            }),
                            text: 'I agree to the terms and conditions',
                          ),
                          const SizedBox(
                            height: 20.0,
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
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          RegisterNewUserInformation(
                                        email: emailController.text,
                                        password: passwordController.text,
                                        phone: phoneController.text,
                                      ),
                                    ),
                                  );
                                }
                              },
                              child: Text(
                                'Sign Up',
                                style: TextStyle(
                                  fontSize: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .fontSize,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 70),
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
                            'Or Sign Up with',
                            style: TextStyle(
                              fontSize: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .fontSize,
                              color: Colors.black54,
                            ),
                          ),
                        ),
                        const Expanded(
                            child: Divider(
                          thickness: 1.0,
                        )),
                      ],
                    ),
                    const SizedBox(height: 16.0),
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
                                  Icons.g_mobiledata_rounded,
                                  color: Colors.deepOrangeAccent,
                                  size: 36,
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
                          'Already have an account?',
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
                              child: const LoginScreen(),
                              type: PageTransitionType.rightToLeft,
                            ),
                          ),
                          child: const Text('Login'),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
