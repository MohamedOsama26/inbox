import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inbox/layout/user_model.dart';
import 'package:inbox/main.dart';
import 'package:inbox/models/social_cubit/social_cubit.dart';
import 'package:inbox/shared/links.dart';
import 'package:inbox/shared/widgets/custom_dropdown_button.dart';
import 'package:inbox/shared/widgets/text_field_style_1.dart';
import 'package:intl/intl.dart';


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
  final TextEditingController currentCity = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  bool isReadOnly = false;
  bool isEditable = true;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();



  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialState>(
        listener: (context, state) {
          print('---------------------------------------------------');
          print('Here the listener of blocConsumer in settings screen');
          print('The current state is ${state}');
          print('---------------------------------------------------');
        },
        builder: (context, state) {
          print('---------------------------------------------------');
          print('Here the builder of blocConsumer in settings screen');
          print('The current state is ${state}');
          print('---------------------------------------------------');
          if (state is ProfileInfoSuccessState) {
            firstNameController.text = SocialCubit.get(context).model!.firstName;
            lastNameController.text  = SocialCubit.get(context).model!.lastName;
            emailController.text     = SocialCubit.get(context).model!.email;
            titleController.text     = SocialCubit.get(context).model!.title;
            bioController.text       = SocialCubit.get(context).model!.bio;
            birthdayController.text  = SocialCubit.get(context).model!.birthday;
            currentCity.text         = SocialCubit.get(context).model!.city;
            phoneController.text     = SocialCubit.get(context).model!.phone;
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
                    if (checkChanges(SocialCubit.get(context).model!)) {
                      await showDialog(
                          context: context,
                          builder: (cntxt) => AlertDialog(
                                actions: [

                                  // Edit database
                                  TextButton(
                                    onPressed: () {
                                      if (formKey.currentState!.validate()) {
                                        SocialCubit.get(context).updatePersonalInfo(
                                          id: uid,
                                          email: emailController.text,
                                          firstName: firstNameController.text,
                                          lastName: lastNameController.text,
                                          bio: bioController.text,
                                          birthday: birthdayController.text,
                                            title: titleController.text == '' ? '...': titleController.text,
                                          currentCity: currentCity.text,
                                          phone: phoneController.text,

                                        );
                                      }
                                      Navigator.of(context)..pop()..pop();
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
                                actionsPadding: const EdgeInsets.symmetric(horizontal: 18.0),
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
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: TextFieldStyle1(
                                    controller: firstNameController,
                                    // readOnly: isReadOnly,
                                    // editable: isEditable,
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
                                    // readOnly: isReadOnly,
                                    // editable: isEditable,
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
                              // readOnly: isReadOnly,
                              // editable: isEditable,
                              label: 'E-mail',
                            ),
                            GestureDetector(
                                child:
                                TextFieldStyle1(
                                  controller: birthdayController,
                                  label: 'Birthday',
                                  readOnly: true,
                                  editable: false,
                                  validationFunction: (value){
                                    if( value == null || value.trim().isEmpty){
                                      return 'Your birthday is required';
                                    }
                                    return null;
                                  },
                                ),
                                onTap: () {
                                  showDatePicker(
                                    context: context,
                                    initialDate: DateTime(
                                        1999, DateTime.now().month, DateTime.now().day),
                                    firstDate: DateTime(1900),
                                    lastDate: DateTime.now(),
                                  ).then((value) {
                                    if (value != null) {
                                      String formattedDate =
                                      DateFormat('d/MM/yyyy').format(value);
                                      setState(() {
                                        birthdayController.text = formattedDate;
                                      });
                                    }
                                  });
                                }
                            ),
                            TextFieldStyle1(
                              controller: phoneController,
                              label: 'Phone',
                            ),
                            TextFieldStyle1(
                              controller: titleController,
                              // readOnly: isReadOnly,
                              // editable: isEditable,
                              label: 'Title',
                            ),
                            TextFieldStyle1(
                              controller: bioController,
                              // readOnly: isReadOnly,
                              // editable: isEditable,
                              label: 'bio',
                            ),
                            CustomDropdownButton(items: cities, label: 'City',dropdownValue: currentCity),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }if(state is ProfileInfoLoadingState){
            SocialCubit.get(context).getUserData(uid);
            return const Scaffold(body: Center(child: Text('Loading State'),),);
          }else if(state is ProfileInfoErrorState){
            return Scaffold(body: Text(state.error),);
          }else {
          SocialCubit.get(context).getUserData(uid);
          return Scaffold(
            body: Center(
              child: Text('the current state is : $state'),
            ),
          );
        }
      },
      );
  }


  bool checkChanges(UserModel model){
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
