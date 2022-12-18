import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inbox/layout/user_model.dart';
import 'package:inbox/models/social_cubit/social_cubit.dart';
import 'package:inbox/models/userCubit/user_cubit.dart';
import 'package:inbox/shared/links.dart';
import 'package:inbox/shared/widgets/text_field_style_1.dart';

class SettingsScreen extends StatelessWidget {
  SettingsScreen({Key? key, }) : super(key: key);

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController birthdayController = TextEditingController();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController bioController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  // final UserModel userModel;

  @override
  Widget build(BuildContext context) {

        return Scaffold(
          appBar: AppBar(
            title: const Text(
              'Settings',
              style: TextStyle(color: Color(0x6F000000), fontSize: 24),
            ),
            iconTheme: const IconThemeData(color: Colors.black45),
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.all(4.0),
                  padding: const EdgeInsets.all(2.0),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color(0x6B000000),
                      width: 4.0,
                    ),
                  ),
                  child: Stack(
                    children: [
                      Image.network(backgroundProfilePicture),
                      Positioned(
                        right: 0,
                        child: TextButton(
                          onPressed: () {},
                          child: Row(
                            children: const [
                              Text(
                                'Edit ',
                                style: TextStyle(color: Color(0xFFFFFFFF)),
                              ),
                              Icon(
                                Icons.edit,
                                size: 14,
                                color: Color(0xFF000000),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 8.0,
                        left: 8.0,
                        child: Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: const Color(0xFFFFFFFF),
                              radius: 40,
                              child: CircleAvatar(
                                backgroundImage: NetworkImage(profilePicture),
                                radius: 38,
                              ),
                            ),
                            TextButton(
                              onPressed: () {},
                              child: Row(
                                children: const [
                                  Text(
                                    'Change profile picture ... ',
                                    style: TextStyle(color: Color(0xFFFFFFFF)),
                                  ),
                                  Icon(
                                    Icons.edit,
                                    size: 14,
                                    color: Color(0xFF000000),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            decoration: const BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                    width: 2.0,
                                    color: Color(0x77000000),
                                  )),
                            ),
                            child: const Text(
                              'Personal Information       ',
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                          TextButton(onPressed: () {}, child: const Text(
                              'Change info'))
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: TextFieldStyle1(
                              controller: firstNameController,
                              readOnly: true,
                              editable: false,
                              label: 'First name',
                            ),
                          ),
                          SizedBox(width: 16.0,),
                          Expanded(
                            child: TextFieldStyle1(
                              controller: lastNameController,
                              readOnly: true,
                              editable: false,
                              label: 'Last name',
                            ),
                          ),
                        ],
                      ),
                      TextFieldStyle1(
                        controller: emailController,
                        readOnly: true,
                        editable: false,
                        label: 'E-mail',
                      ),
                      TextFieldStyle1(
                        controller: birthdayController,
                        readOnly: true,
                        editable: false,
                        label: 'Birthday',
                      ),
                      TextFieldStyle1(
                        controller: titleController,
                        readOnly: true,
                        editable: false,
                        label: 'Title',
                      ),
                      TextFieldStyle1(
                        controller: bioController,
                        readOnly: true,
                        editable: false,
                        label: 'bio',
                      ),
                      TextFieldStyle1(
                        controller: passwordController,
                        readOnly: true,
                        editable: false,
                        label: 'Password',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );


  }
}
