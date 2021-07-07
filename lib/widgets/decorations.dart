import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

InputDecoration fieldDecoration(String hintText) {
  return InputDecoration(
    filled: true,
    fillColor: Colors.white,
    hintText: hintText,
    hintStyle: TextStyle(color: Color(0xFF7B7B7B)),
    labelStyle: TextStyle(color: Colors.black),
    contentPadding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
      borderSide: BorderSide(
        color: Colors.blue,
      ),
    ),
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
      borderSide: BorderSide(
        color: Colors.red,
      ),
    ),
  );
}
