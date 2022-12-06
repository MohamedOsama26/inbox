import 'package:flutter/material.dart';

class CustomDropdownButton extends StatefulWidget {
  CustomDropdownButton({Key? key, required this.items, this.dropdownValue, required this.label}) : super(key: key);

  String? dropdownValue;
  final List<String> items;
  final String label;

  @override
  State<CustomDropdownButton> createState() => _CustomDropdownButtonState();
}

class _CustomDropdownButtonState extends State<CustomDropdownButton> {
  @override
  Widget build(BuildContext context) {
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
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(vertical: 4,horizontal: 16),

              border: OutlineInputBorder(borderSide: BorderSide(width: 2,color: Colors.black45) ),
            ),
            value: widget.dropdownValue,
            icon: Icon(Icons.arrow_drop_down),
            items: widget.items
                .map((city) => DropdownMenuItem(
              child: Text(city),
              value: city,
            ))
                .toList(),
            onChanged: (city) {
              setState(() {
                widget.dropdownValue = city.toString();
              });
            },
            isExpanded: true,
            borderRadius: BorderRadius.circular(4),


            // isExpanded: true,
            // isDense: true,
          ),
        ),
      ],
    );
  }
}