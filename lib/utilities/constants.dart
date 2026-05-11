import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const apiKey = "a11aa2a251d8621b8faa7f477d0c6405";
final kMainBackgroundColor = Colors.blue[300];
const KTitleColor = Colors.black;
const KLightColor = Colors.white;
const kMidColor = Color(0XFFE9EBF0);
const KHintColor = Color(0XFF747878);
const KTextFeildTextStyle = TextStyle(
    fontSize: 14,
    color: KHintColor,
    fontWeight: FontWeight.bold
);
var KTitleTextStyle = GoogleFonts.lato(
    fontSize: 26,
    color: KTitleColor,
    fontWeight: FontWeight.w900,
);
const KTextFeildDecoration = InputDecoration(
    fillColor: kMidColor,
    filled: true,
    contentPadding: EdgeInsets.only(left: 14.0),
    border: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(18)),
        borderSide: BorderSide.none
    ),
    hintText: "Enter City Name",
  hintStyle: KTextFeildTextStyle,
  prefix: Padding(
    padding: EdgeInsets.only(top:10.0),
    child: Icon(Icons.search, color: KHintColor, size: 32,),
  )
);
const KCardTextStyle = TextStyle(color: KLightColor ,fontSize: 20, fontWeight: FontWeight.bold);