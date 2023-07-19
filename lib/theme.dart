import 'package:flutter/material.dart';


BoxDecoration neuRecEmboss = BoxDecoration(
  color: const Color(0xFF1d2124),
  borderRadius: BorderRadius.circular(10),
  shape:BoxShape.rectangle,
  boxShadow: const [
    // BoxShadow(
    // color: Color(0xFF414141),
    // offset: Offset(-2, -2),
    // blurRadius: 1,
    // spreadRadius: 1),
    BoxShadow(
      color: Color(0xFF151515),
      offset:  Offset(-2, -2),
      blurRadius: 1,
      spreadRadius: 1),
  ]
);


BoxDecoration convexButton = BoxDecoration(
  // color: Color(0xFF070809),
  shape:BoxShape.circle,
  gradient: const LinearGradient(
    begin: Alignment.bottomRight,
    end: Alignment.topLeft,
    colors: <Color>[
      Color(0xFF1a1d20),
      Color(0xFF1c1f22),
      Color(0xFF1d2124),
      Color(0xFF1f2326),
      Color(0xFF212428),
      Color(0xFF22262a),
      Color(0xFF24282c),
      Color(0xFF262a2e),
      Color(0xFF282c31),
      Color(0xFF292e33),
      Color(0xFF2b3035),
      Color(0xFF2d3237)
    ],
  ),
  border: Border.all(color: Color(0xFF2C2F35)),
  // Border(
  //   top: BorderSide(color: Color(0xFF2C2F35)),
  //   left: BorderSide(color: Color(0xFF2C2F35)),
  //   right: BorderSide(color: Color(0xFF2A2E34)),
  //   bottom: BorderSide(color: Color(0xFF2A2E34)),
  // ),
  boxShadow: const [
    BoxShadow(
      color: Color(0xFF414141),
      offset: Offset(-2, -2),
      blurRadius: 5,
      spreadRadius: 2),
    BoxShadow(
      color: Color(0xFF151515),
      offset:  Offset(2, 2),
      blurRadius: 5,
      spreadRadius: 2),
  ]
);

BoxDecoration box = BoxDecoration(
  color: const Color(0xFF34393E),
  borderRadius: BorderRadius.circular(10),
  shape:BoxShape.rectangle,
  border: Border.all(
    color: const Color(0xFF3D4249)
  ),
  boxShadow: const [
    BoxShadow(
      color: Color(0xFF151515),
      offset:  Offset(1, 1),
      blurRadius: 30,
      spreadRadius: 0.5),
  ]
);
