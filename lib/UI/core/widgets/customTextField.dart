import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget customTextField(TextEditingController places, Icon sufixicon, String hint) {
  return TextField(
    controller: places,
    decoration: const InputDecoration(
      suffixIcon: Icon(Icons.search),
      fillColor: Colors.white,
      filled: true,
      border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide.none
      ),
      label: Text('Your Location'),
    ),
    onChanged: (String s) {
    },
  );
}