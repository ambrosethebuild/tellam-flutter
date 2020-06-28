import 'package:flutter/material.dart';

class TellamTextStyles {
  
  
  //Text Sized
  static TextStyle h1TitleTextStyle( {Color color = Colors.black, FontWeight fontWeight = FontWeight.w700} ){
    return TextStyle(fontSize: 25, fontWeight: fontWeight, color: color );
  }

  static TextStyle h2TitleTextStyle( {Color color = Colors.black, FontWeight fontWeight = FontWeight.w600} ){
    return TextStyle(fontSize: 22, fontWeight: fontWeight, color: color );
  }

  static TextStyle h3TitleTextStyle( {Color color = Colors.black, FontWeight fontWeight = FontWeight.w500} ){
    return TextStyle(fontSize: 20, fontWeight: fontWeight, color: color );
  }
  
  static TextStyle h4TitleTextStyle( {Color color = Colors.black, FontWeight fontWeight = FontWeight.w400} ){
    return TextStyle(fontSize: 17, fontWeight: fontWeight, color: color );
  }
  
  static TextStyle h5TitleTextStyle( {Color color = Colors.black, FontWeight fontWeight = FontWeight.w300} ){
    return TextStyle(fontSize: 15, fontWeight: fontWeight, color: color );
  }
  
  static TextStyle h6TitleTextStyle( {Color color = Colors.black, FontWeight fontWeight = FontWeight.w200} ){
    return TextStyle(fontSize: 13, fontWeight: fontWeight, color: color );
  }

  static TextStyle h7TitleTextStyle( {Color color = Colors.black, FontWeight fontWeight = FontWeight.w100} ){
    return TextStyle(fontSize: 11, fontWeight: fontWeight, color: color );
  }



}
