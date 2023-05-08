import 'package:flutter/material.dart';

class CustomTextFormSign extends StatelessWidget {
  final String hint;
  final TextEditingController mycontroller;
  final String? Function(String?) valid;
  final Widget? prefixIcon;
  const CustomTextFormSign({
    super.key,
    required this.hint,
    required this.mycontroller,
    required this.valid, this.prefixIcon
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: TextFormField(
        
        validator: valid,
        controller: mycontroller,
        decoration: InputDecoration(
          prefixIcon: prefixIcon,
            enabledBorder: const OutlineInputBorder(
              //borderSide: BorderSide(color: Colors.redAccent, width: 1),
            ),
            focusedBorder: const OutlineInputBorder(
              //borderSide: BorderSide(color: Colors.redAccent),
            ),
            focusColor: Colors.redAccent,
            hoverColor: Colors.redAccent,
            hintText: hint,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
            border: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black, width: 1),
                borderRadius: BorderRadius.all(Radius.circular(10)))),
      ),
    );
  }
}
