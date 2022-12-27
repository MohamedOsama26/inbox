import 'package:flutter/material.dart';

class CustomDropdownButton extends StatefulWidget {
  CustomDropdownButton({
    Key? key,
    required this.items,
    required this.controller,
    required this.label,
    this.validationFunction,
    this.currentCity,
  }) : super(key: key);

  final String? Function(String?)? validationFunction;
  final TextEditingController controller;
  final List<String> items;
  final String label;
  String? currentCity;

  @override
  State<CustomDropdownButton> createState() => _CustomDropdownButtonState();
}

class _CustomDropdownButtonState extends State<CustomDropdownButton> {


  @override
  Widget build(BuildContext context) {
    print(widget.currentCity);
    return Column(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.only(top: 8.0, bottom: 6.0),
          child: Text(
            widget.label,
            style: TextStyle(
              fontSize: Theme.of(context).textTheme.titleMedium?.fontSize,
            ),
          ),
        ),
        DropdownButtonHideUnderline(
          child: DropdownButtonFormField(
            itemHeight: null,
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.symmetric(vertical: 4, horizontal: 16),
              border: OutlineInputBorder(
                  borderSide: BorderSide(width: 2, color: Colors.black45)),
            ),
            value: widget.currentCity,
            icon: const Icon(Icons.arrow_drop_down),
            items: widget.items
                .map((city) => DropdownMenuItem(
                      value: city,
                      child: Text(city),
                    ))
                .toList(),
            onChanged: (String? value) {
              setState(() {
                widget.controller.text = value.toString();
              });
            },
            isExpanded: true,
            borderRadius: BorderRadius.circular(4),
            validator: widget.validationFunction,
          ),
        ),
      ],
    );
  }
}
