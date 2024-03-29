import 'package:flutter/material.dart';

class ResizeTextField extends StatefulWidget {

  final TextEditingController commentController;
  final bool multiLine;
  final double height;
  final EdgeInsets padding;

  const ResizeTextField({
    Key? key,
    required this.commentController,
    required this.multiLine,
    required this.padding,
    this.height = 40,
  }) : super(key: key);

  @override
  State<ResizeTextField> createState() => _ResizeTextFieldState();

}


class _ResizeTextFieldState extends State<ResizeTextField> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  RegExp reg = RegExp(r"^[\u0621-\u064A0-9 ]");
  bool _isMatch = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
      ),
      height: widget.height,
      decoration: BoxDecoration(
          color: const Color(0xaffffff),
          borderRadius: BorderRadius.circular(6),
        border: Border.all(color: const Color(0xFFBBBBBB))
      ),
      child: TextFormField(
        textAlignVertical: TextAlignVertical.center,
        onChanged: (input) {
          setState(() {
            _isMatch = reg.hasMatch(widget.commentController.text);
          });
        },
        textDirection: _isMatch ? TextDirection.rtl : TextDirection.ltr,
        controller: widget.commentController,
        expands: widget.multiLine? true : false,
        maxLines: widget.multiLine? null: 1,
        minLines:  null,
        keyboardType: TextInputType.multiline,
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.zero,
          hintText: 'Write comment ...',
          hintStyle: TextStyle(
            color: Color(0x32000000),
          ),
            focusColor: Color(0xFF00FF73), border: InputBorder.none,
        ),

        cursorColor: Colors.transparent,
        style: const TextStyle(
          decorationColor: Colors.transparent,
          color: Color(0xCA000000),
          letterSpacing: 1.0,
          wordSpacing: 1,
        ),
      ),
    );
  }
}
