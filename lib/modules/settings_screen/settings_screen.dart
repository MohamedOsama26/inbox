import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inbox/layout/user_model.dart';
import 'package:inbox/main.dart';
import 'package:inbox/models/social_cubit/social_cubit.dart';
import 'package:inbox/shared/links.dart';
import 'package:inbox/shared/widgets/text_field_style_1.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController birthdayController = TextEditingController();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController bioController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isReadOnly = true;
  bool isEditable = false;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  // String buttonContent = 'Change info';

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SocialCubit>(
      create: (context) => SocialCubit()..getUserData(uid),
      child: BlocConsumer<SocialCubit, SocialState>(
        listener: (context, state) {
          if (state is ProfileInfoSuccessState) {
            firstNameController.text =
                SocialCubit.get(context).model!.firstName;
            lastNameController.text = SocialCubit.get(context).model!.lastName;
            emailController.text = SocialCubit.get(context).model!.email;
            titleController.text = SocialCubit.get(context).model!.title;
            bioController.text = SocialCubit.get(context).model!.bio;
            birthdayController.text = SocialCubit.get(context).model!.birthday;
          }
        },
        builder: (context, state) {
          if (state is ProfileInfoSuccessState) {
            return Scaffold(
              appBar: AppBar(
                title: const Text(
                  'Settings',
                  style: TextStyle(color: Color(0x6F000000), fontSize: 24),
                ),
                iconTheme: const IconThemeData(color: Colors.black45),
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
                leading: IconButton(
                  icon: const Icon(Icons.chevron_left),
                  onPressed: () async {
                    print('============================== Pressed ================================');
                    print(SocialCubit.get(context).model);
                    print('============================== Pressed ================================');
                    if (checkChanges(SocialCubit.get(context).model!)) {
                      await showDialog(
                          context: context,
                          builder: (cntxt) => AlertDialog(
                                actions: [

                                  // Edit database
                                  TextButton(
                                    onPressed: () async{
                                      if (formKey.currentState!.validate()) {
                                        SocialCubit.get(context).updatePersonalInfo(
                                          id: uid,
                                          email: emailController.text,
                                          firstName: firstNameController.text,
                                          lastName: lastNameController.text,
                                          bio: bioController.text,
                                          birthday: birthdayController.text,
                                            title: titleController.text == '' ? '...': titleController.text
                                        );
                                      }
                                      await Navigator.of(context)..pop()..pop();
                                      print('getting');
                                      SocialCubit.get(context).getUserData(uid);
                                      print(SocialCubit.get(context).model!.bio);
                                    },
                                    child: const Text('Keep'),
                                  ),

                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context)..pop()..pop();
                                    },
                                    child: const Text('Discard'),
                                  ),
                                  TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Text('Cancel')),
                                ],
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 12.0, horizontal: 20.0),
                                content: const Text(
                                    'Do you want to keep changes in your personal information'),
                                actionsPadding: EdgeInsets.symmetric(horizontal: 18.0),
                              ));
                    }else{
                      Navigator.pop(context);
                    }
                  },
                ),
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
                                    backgroundImage:
                                        NetworkImage(profilePicture),
                                    radius: 38,
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {},
                                  child: Row(
                                    children: const [
                                      Text(
                                        'Change profile picture ... ',
                                        style:
                                            TextStyle(color: Color(0xFFFFFFFF)),
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
                      child: Form(
                        key: formKey,
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
                                TextButton(
                                    onPressed: () {
                                      setState(() {
                                        isReadOnly = !isReadOnly;
                                        isEditable = !isEditable;
                                        print('readOnly : $isReadOnly');
                                        print('Editable : $isEditable');
                                        print('====================');
                                      });
                                    },
                                    child: Text(isReadOnly
                                        ? 'Change info'
                                        : 'Keep Changes'))
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: TextFieldStyle1(
                                    controller: firstNameController,
                                    readOnly: isReadOnly,
                                    editable: isEditable,
                                    label: 'First name',
                                    validationFunction: (value){
                                      if(value == null || value.trim().isEmpty){
                                        return 'Your first name is required';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                const SizedBox(
                                  width: 16.0,
                                ),
                                Expanded(
                                  child: TextFieldStyle1(
                                    controller: lastNameController,
                                    readOnly: isReadOnly,
                                    editable: isEditable,
                                    label: 'Last name',
                                    validationFunction: (value){
                                      if(value == null || value.trim().isEmpty){
                                        return 'Your last name is required';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ],
                            ),
                            TextFieldStyle1(
                              controller: emailController,
                              readOnly: isReadOnly,
                              editable: isEditable,
                              label: 'E-mail',
                            ),
                            TextFieldStyle1(
                              controller: birthdayController,
                              readOnly: isReadOnly,
                              editable: false,
                              label: 'Birthday',
                            ),
                            TextFieldStyle1(
                              controller: titleController,
                              readOnly: isReadOnly,
                              editable: isEditable,
                              label: 'Title',
                            ),
                            TextFieldStyle1(
                              controller: bioController,
                              readOnly: isReadOnly,
                              editable: isEditable,
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
                    ),
                  ],
                ),
              ),
            );
          }
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        },
      ),
    );
  }


  bool checkChanges(UserModel model){
    print('check Changes');
    return (firstNameController.text !=
        model.firstName ||
        lastNameController.text !=
            model.lastName ||
        emailController.text !=
            model.email ||
        birthdayController.text !=
            model.birthday ||
        titleController.text !=
            model.title ||
        bioController.text !=
            model.bio);
  }
}
