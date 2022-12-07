import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inbox/models/register_cubit/register_cubit.dart';
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
  Widget build(BuildContext context1) {
    return BlocConsumer<RegisterCubit, RegisterState>(
  listener: (context, state) {},
  builder: (context, state) {
    print(state);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Color(0x8B000000),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // SizedBox(height: 30,),
              Text(
                'Welcome',
                style: TextStyle(
                    fontSize: Theme.of(context1).textTheme.headline5!.fontSize),
              ),
              Text(
                'We wanna know more about you!',
                style: TextStyle(
                    fontSize: Theme.of(context1).textTheme.headline6!.fontSize,
                    color: Colors.black26),
              ),
              const SizedBox(height: 40.0),
              Form(
                key: formKey,
                child: Column(
                  children: [
                    TextFieldStyle1(
                      controller: nameController,
                      label: 'Name',
                      validationFunction: (value){
                        if(value == null){
                          return 'Your name is required';
                        }
                        return null;
                      },
                    ),
                    TextFieldStyle1(
                      controller: nicknameController,
                      label: 'Nickname',
                    ),
                    TextFieldStyle1(controller: bioController, label: 'bio...'),
                    GestureDetector(
                        child: TextFieldStyle1(
                          controller: birthDayController,
                          label: 'Birthday',
                          readOnly: true,
                          editable: false,
                        ),
                        onTap: () {
                          print('tabbed');
                          showDatePicker(
                            context: context1,
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
                        }),
                    CustomDropdownButton(items: cities, label: 'City',dropdownValue: currentCity.text),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: RadioListTile(
                              title: Text('Male'),
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
                              title: Text('Female'),
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
                    TextButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            RegisterCubit.get(context1).register(
                              context1,
                              email: widget.email,
                              password: widget.password,
                              phone: widget.phone,
                              name: nameController.text,
                              nickname: nicknameController.text,
                              bio: bioController.text,
                              birthday: birthDayController.text,
                              backgroundPicture: backgroundProfilePicture,
                              city: currentCity.text,
                              gender: gender,
                              profilePicture: profilePicture,
                            );
                          }
                          // print(genderController.text);
                        },
                        child: Text('Print')),
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
