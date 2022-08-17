

import 'package:flutter/material.dart';

Widget getCommonTextEditingController(TextEditingController controller,String hintText){
  return  Container(
    margin: const EdgeInsets.all(12),
    child: TextField(
      controller: controller,
      decoration:  InputDecoration(
        filled: true,
        fillColor: const Color(0xFFF2F2F2),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(4)),
          borderSide: BorderSide(width: 1,color: Colors.red),
        ),
        disabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(4)),
          borderSide: BorderSide(width: 1,color: Colors.orange),
        ),
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(4)),
          borderSide: BorderSide(width: 1,color: Colors.grey),
        ),
        border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            borderSide: BorderSide(width: 1,)
        ),
        errorBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            borderSide: BorderSide(width: 1,color: Colors.black)
        ),
        focusedErrorBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            borderSide: BorderSide(width: 1,color: Colors.yellowAccent)
        ),
        hintText: hintText,
        hintStyle: const TextStyle(fontSize: 16,color: Color(0xFFB3B1B1)),

      ),
    ),
  );
}