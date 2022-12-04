import 'package:flutter/material.dart';

class RegisterNewUserInformation extends StatefulWidget {
  const RegisterNewUserInformation({Key? key}) : super(key: key);

  @override
  State<RegisterNewUserInformation> createState() => _RegisterNewUserInformationState();
}

class _RegisterNewUserInformationState extends State<RegisterNewUserInformation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Color(0xFF0000FF),
      ),
    );
  }
}
