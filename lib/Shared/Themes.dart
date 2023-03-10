import 'package:flutter/material.dart';


// Color theme
Color BackgroundColor = Color.fromARGB(255, 230, 219, 221);
Color TabColor = Color.fromARGB(255, 254, 53, 98);

// Font theme
TextStyle header10 =
    const TextStyle(fontFamily: "Inter",fontSize: 10,color: Colors.black,fontWeight: FontWeight.w500);
TextStyle header12 =
    const TextStyle(fontFamily: "Inter",fontSize: 12,color: Colors.black,fontWeight: FontWeight.w700);
TextStyle header14 =
    const TextStyle(fontFamily: "Inter",fontSize: 14,color: Colors.black,fontWeight: FontWeight.w500);
TextStyle header16 =
    const TextStyle(fontFamily: "Inter",fontSize: 16,color: Colors.black,fontWeight: FontWeight.w500);
TextStyle header18 =
    const TextStyle(fontFamily: "Inter",fontSize: 18,color: Colors.black,fontWeight: FontWeight.w700);

// Styles 
Decoration normalRadius = const BoxDecoration(
  color: Colors.white,
  borderRadius: BorderRadius.all(Radius.circular(64)),
);

Decoration cardRadiusShadow = const BoxDecoration(
  borderRadius: BorderRadius.all(Radius.circular(8)),
  boxShadow: [
    BoxShadow(
      color: Color.fromRGBO(0, 0, 0, 0.25),
      spreadRadius: 0,
      blurRadius: 4,
      offset:
          Offset(0, 5), // changes posit ion of shadow
    ),
  ],
);

Decoration circularCardRadiusShadow = const BoxDecoration(
  borderRadius: BorderRadius.all(Radius.circular(68)),
  boxShadow: [
    BoxShadow(
      color: Color.fromRGBO(0, 0, 0, 0.25),
      spreadRadius: 0,
      blurRadius: 4,
      offset:
          Offset(0, 5), // changes posit ion of shadow
    ),
  ],
);




// Device Height and Width - Responsivness
double getScreenWidthOfContext(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

double getScreenHeightOfContext(BuildContext context) {
  return MediaQuery.of(context).size.height;
}
