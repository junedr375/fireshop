import 'package:flutter/material.dart';

///Getting App Theme Data
ThemeData getThemeData(BuildContext context) {
  return Theme.of(context);
}

///Light Theme for App
ThemeData appLightTheme() {
  return ThemeData(
      primaryColor: Colors.teal,
      primarySwatch: Colors.teal,
      scaffoldBackgroundColor: Colors.grey[200],
      tabBarTheme: TabBarTheme(
          labelColor: Colors.red,
          unselectedLabelColor: Colors.grey[800],
          labelStyle:
              const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          unselectedLabelStyle:
              const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
          indicatorSize: TabBarIndicatorSize.label,
          labelPadding:
              const EdgeInsets.symmetric(horizontal: 10, vertical: 10)),
      backgroundColor: Colors.white,
      cardColor: Colors.black,
      dividerColor: Colors.grey[700],
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      textTheme: TextTheme(
        headline1: const TextStyle(
            color: Colors.black, fontSize: 20, fontWeight: FontWeight.w700),
        headline2: const TextStyle(
            color: Colors.black, fontSize: 20, fontWeight: FontWeight.w600),
        headline3: const TextStyle(
            color: Colors.black, fontSize: 18, fontWeight: FontWeight.w500),
        headline4: const TextStyle(
            color: Colors.black, fontSize: 16, fontWeight: FontWeight.w400),
        headline5: const TextStyle(
            color: Colors.black, fontSize: 14, fontWeight: FontWeight.w600),
        headline6: const TextStyle(
            color: Colors.black, fontSize: 14, fontWeight: FontWeight.w400),
        bodyText1: TextStyle(
            color: Colors.grey[800], fontSize: 14, fontWeight: FontWeight.w300),
        bodyText2: TextStyle(
            color: Colors.grey[600], fontSize: 12, fontWeight: FontWeight.w400),
        subtitle1: const TextStyle(
            color: Colors.black, fontSize: 16, fontWeight: FontWeight.w400),
        subtitle2: const TextStyle(
            color: Colors.white, fontSize: 16, fontWeight: FontWeight.w400),
      ),
      iconTheme: const IconThemeData(color: Colors.black, size: 25));
}
