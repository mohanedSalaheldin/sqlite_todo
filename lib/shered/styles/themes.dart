import 'package:flutter/material.dart';
import 'package:sqfilte_todo/shered/styles/colors.dart';

ThemeData lightTheme() => ThemeData(
      useMaterial3: false,
      // scaffoldBackgroundColor: Colors.white,
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
        textStyle: MaterialStateProperty.all(
          const TextStyle(
            fontSize: 16.0,
          ),
        ),
        padding: MaterialStateProperty.all(
          const EdgeInsets.symmetric(
            horizontal: 15.0,
            vertical: 15.0,
          ),
        ),
      )),
      // scaffoldBackgroundColor: Colors.white,
      fontFamily: 'OneSans',
      appBarTheme: const AppBarTheme(
        // elevation: 50.0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          fontSize: 20.0,
          fontFamily: 'OneSans',
          fontWeight: FontWeight.w600,
        ),
      ),
      // primarySwatch: defaultColor,
      colorScheme: ColorScheme.fromSwatch().copyWith(
        primary: defaultColor,
        secondary: defaultColor,
      ),
      inputDecorationTheme: InputDecorationTheme(
        contentPadding: const EdgeInsetsDirectional.symmetric(
          horizontal: 20,
          vertical: 30,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            15,
          ),
        ),
        labelStyle: const TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
        ),
        iconColor: defaultColor,
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        elevation: 20.0,
        // backgroundColor: appBarDefaultColor,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: defaultColor,
      ),
      dropdownMenuTheme: DropdownMenuThemeData(
        inputDecorationTheme: InputDecorationTheme(
          contentPadding: const EdgeInsetsDirectional.symmetric(
            horizontal: 20,
            vertical: 30,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
              15,
            ),
          ),
          labelStyle: const TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
          iconColor: defaultColor,
        ),
      ),
      iconTheme: IconThemeData(color: defaultColor),
    );
