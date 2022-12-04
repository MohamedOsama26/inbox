import 'package:flutter/material.dart';

class CheckboxStyle1 extends StatelessWidget {
  const CheckboxStyle1({Key? key, this.isChecked = false, required this.clickFunction, this.text}) : super(key: key);

  final bool isChecked;
  final VoidCallback clickFunction;
  final String? text;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: clickFunction,
      child: Row(
        children: [
          Container(
            width: 20.0,
            height: 20.0,
            padding: const EdgeInsets.all(2.5),
            margin: const EdgeInsets.symmetric(horizontal: 8.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(7.0),
              border: Border.all(color: Theme.of(context).primaryColor, width: 2.0),
            ),
            child: Container(
              decoration: BoxDecoration(
                color: isChecked
                    ? Theme.of(context).primaryColor
                    : Theme.of(context).colorScheme.onPrimary,
                borderRadius: BorderRadius.circular(4.0),
              ),
            ),
          ),
          text!=null? Text(
            text!,
            style: TextStyle(
              fontSize: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .fontSize,
            ),
          ): const SizedBox(),
        ],
      ),
    );
  }
}
