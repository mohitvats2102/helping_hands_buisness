import 'package:flutter/material.dart';

const Color kaccentColor = Color(0xFFFF8038);
const Color kprimaryColor = Color(0xFF033249);

const TextStyle kloginText = TextStyle(
  color: Color(0xFFFF8038),
  fontSize: 50,
  fontWeight: FontWeight.w400,
);

const BoxDecoration kloginContainerDecoration = BoxDecoration(
  boxShadow: [
    BoxShadow(
      color: Colors.black12,
      offset: Offset(10, -6),
      spreadRadius: 2,
      blurRadius: 20,
    ),
    BoxShadow(
      color: Colors.black12,
      offset: Offset(-20, -6),
      spreadRadius: 0,
      blurRadius: 40,
    )
  ],
  color: Colors.white,
  borderRadius: BorderRadius.only(
    topLeft: Radius.circular(40),
  ),
);

const InputDecoration klogininput = InputDecoration(
  prefixIcon: Icon(
    Icons.person,
    color: Color(0xFFFF8038),
  ),
  //hintText: 'E-mail address',
  labelText: 'Name',
  labelStyle: TextStyle(color: Color(0xFFFF8038)),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(
      color: Color(0xFFFF8038),
    ),
    borderRadius: BorderRadius.all(
      Radius.circular(
        10,
      ),
    ),
  ),
  border: OutlineInputBorder(
    borderSide: BorderSide(
      color: Color(0xFFFF8038),
    ),
    borderRadius: BorderRadius.all(
      Radius.circular(
        10,
      ),
    ),
  ),
);
