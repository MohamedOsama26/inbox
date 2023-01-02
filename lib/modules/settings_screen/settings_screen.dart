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
  final TextEditingController cityController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is ProfileInfoSuccessState) {
          setFieldsContent(state.model);
          String oldProfileImage = state.model!.profilePicture;
          String oldCoverImage = state.model!.backgroundPicture;

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
                  if (checkChanges(
                    model: state.model!,
                    newProfileImage: state.newProfileUrl,
                    oldProfileImage: state.model!.profilePicture,
                    newCoverImage: state.newCoverUrl,
                    oldCoverImage: state.model!.backgroundPicture,
                  )) {
                    await showDialog(
                        context: context,
                        builder: (cntxt) => AlertDialog(
                              actions: [
                                // Edit database
                                TextButton(
                                  onPressed: () {
                                    if (formKey.currentState!.validate()) {
                                      SocialCubit.get(context)
                                          .updatePersonalInfo(
                                        id: uid,
                                        email: emailController.text,
                                        firstName: firstNameController.text,
                                        lastName: lastNameController.text,
                                        bio: bioController.text,
                                        birthday: birthdayController.text,
                                        title: titleController.text == ''
                                            ? '...'
                                            : titleController.text,
                                        currentCity: cityController.text,
                                        phone: phoneController.text,
                                        backgroundPicture:
                                            state.newCoverUrl ?? oldCoverImage,
                                        profilePicture: state.newProfileUrl ??
                                            oldProfileImage,
                                      );
                                      // SocialCubit.get(context).uploadProfileImage(id: uid);
                                      Navigator.of(context)
                                        ..pop()
                                        ..pop();
                                    } else {
                                      Navigator.pop(context);
                                    }
                                  },
                                  child: const Text('Keep'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    state.newProfileUrl = null;
                                    Navigator.of(context)
                                      ..pop()
                                      ..pop();
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
                              actionsPadding:
                                  const EdgeInsets.symmetric(horizontal: 18.0),
                            ));
                  } else {
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
                    height: 250,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                          state.newCoverUrl ??
                              state.model!.backgroundPicture),
                      fit: BoxFit.cover
                      ),
                    ),
                    child: Stack(
                      children: [

                        Positioned(
                          right: 0,
                          child: TextButton(
                            onPressed: () async {
                              await SocialCubit.get(context).updateCoverImage();
                            },
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
                                  backgroundImage: NetworkImage(
                                      state.newProfileUrl ??
                                          state.model!.profilePicture),
                                  radius: 38,
                                ),
                              ),
                              TextButton(
                                onPressed: () async {
                                  await SocialCubit.get(context)
                                      .updateProfileImage();
                                },
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
                                  label: 'First name',
                                ),
                              ),
                              const SizedBox(
                                width: 16.0,
                              ),
                              Expanded(
                                child: TextFieldStyle1(
                                  controller: lastNameController,
                                  label: 'Last name',
                                ),
                              ),
                            ],
                          ),
                          TextFieldStyle1(
                            controller: emailController,
                            label: 'E-mail',
                          ),
                          GestureDetector(
                            child: TextFieldStyle1(
                              controller: birthdayController,
                              label: 'Birthday',
                              readOnly: true,
                              editable: false,
                            ),
                            onTap: () async {
                              DateTime? date = await showDatePicker(
                                context: context,
                                initialDate: DateTime(1999,
                                    DateTime.now().month, DateTime.now().day),
                                firstDate: DateTime(1900),
                                lastDate: DateTime.now(),
                              );
                              if (date != null) {
                                String formattedDate =
                                    DateFormat('d/MM/yyyy').format(date);
                                birthdayController.text = formattedDate;
                              }
                            },
                          ),
                          TextFieldStyle1(
                            controller: phoneController,
                            label: 'Phone',
                          ),
                          TextFieldStyle1(
                            controller: titleController,
                            label: 'Title',
                          ),
                          TextFieldStyle1(
                            controller: bioController,
                            label: 'bio',
                          ),
                          CustomDropdownButton(
                            items: cities,
                            label: 'City',
                            controller: cityController,
                            currentCity: state.model!.city,
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
        if (state is ProfileInfoLoadingState) {
          return const Scaffold(
            body: Center(
              child: Text('Loading'),
            ),
          );
        } else if (state is ProfileInfoErrorState) {
          return Scaffold(
            body: Text(state.error),
          );
        } else {
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

  bool checkChanges({
    required UserModel model,
    String? newCoverImage,
    String? newProfileImage,
    String? oldProfileImage,
    String? oldCoverImage,
  }) {
    return (firstNameController.text != model.firstName ||
        lastNameController.text != model.lastName ||
        emailController.text != model.email ||
        birthdayController.text != model.birthday ||
        titleController.text != model.title ||
        bioController.text != model.bio ||
        cityController.text != model.city ||
        newCoverImage != null ||
        newProfileImage != null);
  }

  void setFieldsContent(model) {
    if (firstNameController.text != model.firstName &&
        lastNameController.text != model.lastName &&
        emailController.text != model.email &&
        birthdayController.text != model.birthday &&
        titleController.text != model.title &&
        bioController.text != model.bio &&
        cityController.text != model.city) {
      firstNameController.text = model.firstName;
      lastNameController.text = model.lastName;
      emailController.text = model.email;
      titleController.text = model.title;
      bioController.text = model.bio;
      birthdayController.text = model.birthday;
      cityController.text = model.city;
      phoneController.text = model.phone;
    }
  }
}
