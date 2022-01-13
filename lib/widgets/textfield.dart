import 'package:flutter/material.dart';

class CustomTextField {
  final String title;
  final String placeholder;
  final bool ispass;
  final int line;
  String err;
  late String _value;
  CustomTextField(
      {this.title = "",
      this.placeholder = "",
      this.ispass = false,
      this.err = "This field is mandatory.",
      this.line = 1,
  });
  TextEditingController controller = TextEditingController();
  TextFormField textFormField() {
    return TextFormField(
      controller: controller,
      maxLines: line, //this removed
      onChanged: (e) {
        _value = e;
      },
      validator: (e) => e!.isEmpty ? err : null,
      obscureText: ispass,
      cursorColor: Colors.indigoAccent,
      cursorHeight: 25,
      cursorWidth: 1,
      decoration: InputDecoration(
        errorStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
        hintText: placeholder,
        labelText: title,
        labelStyle: const TextStyle(
          color: Colors.indigoAccent,
        ),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(0),
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.indigoAccent,
          ),
        ),
      ),
    );
  }

  String get value {
    return _value;
  }
}
