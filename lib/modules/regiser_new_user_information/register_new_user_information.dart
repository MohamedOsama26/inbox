import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inbox/models/register_cubit/register_cubit.dart';
import 'package:inbox/modules/main_page.dart';
import 'package:inbox/shared/links.dart';
import 'package:inbox/shared/widgets/custom_dropdown_button.dart';
import 'package:inbox/shared/widgets/text_field_style_1.dart';
import 'package:intl/intl.dart';

class RegisterNewUserInformation extends StatefulWidget {
  const RegisterNewUserInformation({
    Key? key,
    required this.email,
    required this.password,
    required this.phone,
  }) : super(key: key);

  final String email;
  final String password;
  final String phone;

  @override
  State<RegisterNewUserInformation> createState() =>
      _RegisterNewUserInformationState();
}

class _RegisterNewUserInformationState
    extends State<RegisterNewUserInformation> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController nicknameController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController birthDayController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController bioController = TextEditingController();
  final TextEditingController currentCity = TextEditingController();
  final TextEditingController titleController = TextEditingController();
  final List<String> cities = [
    'Cairo',
    'Alexandria',
    'Giza',
    'Qalyubia',
    'Port Said',
    'Suez',
    'Gharbia',
    'Dakahlia',
    'Asyut',
    'Fayoum',
    'Sharqia',
    'Ismailia',
    'Aswan',
    'Beheira',
    'Minya',
    'Damietta',
    'Luxor',
    'Qena',
    'Beni Suef',
    'Sohag',
    'Monufia',
    'Red Sea',
    'Kafr el-Sheikh',
    'North Sinai',
    'Matruh',
    'New Valley',
    'South Sinai',
  ];
  String gender = 'Male';

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit, RegisterState>(
      listener: (context,state){
        if(state is RegisterSuccessState){
          print('=====> Here in register screen the id should be passed to main page by navigation after regestering and been in success state : ${state.id}');
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> MainPage(state.id)));
        }
      },
  builder: (context, state) {
    // if(state is RegisterSuccessState){
    //   Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const MainPage()));
    // }
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: const Color(0x8B000000),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Welcome',
                style: TextStyle(
                    fontSize: Theme.of(context).textTheme.headline5!.fontSize),
              ),
              Text(
                'We wanna know more about you!',
                style: TextStyle(
                    fontSize: Theme.of(context).textTheme.headline6!.fontSize,
                    color: Colors.black26),
              ),
              const SizedBox(height: 40.0),
              Form(
                key: formKey,
                child: Column(
                  children: [
                    TextFieldStyle1(
                      controller: nameController,
                      label: 'First name',
                      validationFunction: (value){
                        if(value == null || value.trim().isEmpty){
                          return 'Your first name is required';
                        }
                        return null;
                      },
                    ),
                    TextFieldStyle1(
                      controller: nicknameController,
                      label: 'Last name',
                      validationFunction: (value){
                        if(value == null || value.trim().isEmpty){
                          return 'Your last name is required';
                        }
                        return null;
                      },
                    ),
                    TextFieldStyle1(controller: bioController, label: 'bio...'),
                    TextFieldStyle1(controller: titleController, label: 'Title'),
                    GestureDetector(
                        child:
                        TextFieldStyle1(
                          onTab: (){
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
                                  birthDayController.text = formattedDate;
                                });
                              }
                            });
                          },

                          controller: birthDayController,
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
                                birthDayController.text = formattedDate;
                              });
                            }
                          });
                        }
                        ),
                    CustomDropdownButton(items: cities, label: 'City',dropdownValue: currentCity),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: RadioListTile(
                              title: const Text('Male'),
                              value: 'Male',
                              groupValue: gender,
                              onChanged: (val) {
                                setState(() {
                                  gender = 'Male';
                                });
                              }),
                        ),
                        Expanded(
                          child: RadioListTile(
                              title: const Text('Female'),
                              value: 'Female',
                              groupValue: gender,
                              onChanged: (val) {
                                setState(() {
                                  gender = 'Female';
                                });
                              }),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30,),
                    SizedBox(
                      width: 100,
                      child: ElevatedButton(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              RegisterCubit.get(context).register(
                                context,
                                email: widget.email,
                                password: widget.password,
                                phone: widget.phone,
                                firstName: nameController.text,
                                lastName: nicknameController.text,
                                bio: bioController.text,
                                birthday: birthDayController.text,
                                backgroundPicture: backgroundProfilePicture,
                                city: currentCity.text,
                                gender: gender,
                                profilePicture: profilePicture,
                                title: titleController.text == '' ? '...': titleController.text,
                              );
                            }
                          },
                          child: const Text('Let\'s go')),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  },
);
  }
}
