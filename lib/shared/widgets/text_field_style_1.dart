import 'package:flutter/material.dart';

class TextFieldStyle1 extends StatelessWidget {

  const TextFieldStyle1({
    Key? key,
    this.isPassword = false,
    this.inputType = TextInputType.text,
    this.hint = '',
    this.label = '',
    this.icon,
    this.editable = true,
    this.onTab,
    required this.controller,
    this.readOnly = false,
    this.validationFunction,
    this.textInputAction = TextInputAction.next,
  }) : super(key: key);

  final bool isPassword;
  final TextInputType inputType;
  final String hint;
  final String label;
  final Widget? icon;
  final bool editable;
  final VoidCallback? onTab;
  final TextEditingController controller;
  final bool readOnly;
  final String? Function(String?)? validationFunction;
  final TextInputAction? textInputAction;



  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.only(top: 8.0, bottom: 6.0),
          child: Text(
            label,
            style: TextStyle(
                fontSize: Theme.of(context).textTheme.titleMedium?.fontSize,
            ),
          ),
        ),
        SizedBox(
          child: TextFormField(
            textInputAction: textInputAction,
            readOnly: readOnly,
            controller: controller,
            enabled: editable,
            keyboardType: inputType,
            obscureText: isPassword,
            autocorrect: !isPassword,
            decoration: InputDecoration(
              errorStyle: TextStyle(
                color: Theme.of(context).errorColor
              ),
              contentPadding: const EdgeInsets.only(
                  top: 4.0, bottom: 4.0, right: 0.0, left: 16.0),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4.0),
                borderSide: const BorderSide(width: 2,color: Colors.black45)
              ),
              hintText: hint,
              suffixIcon: SizedBox(
                height: 20,
                width: 20,
                child: GestureDetector(
                  onTap: onTab,
                  child: icon,
                ),
              ),
            ),
            validator: validationFunction,
          ),
        ),
      ],
    );
  }
}


