// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:authenticate/res/string_values.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class User {
  String name;
  String user;
  String email;

  User({this.user = "", this.name = "", this.email = ""});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'],
      user: json['user'],
      email: json['email'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'user': user,
      'email': email,
    };
  }

  @override
  String toString() {
    return 'User{name: $name, user: $user, pass: $pass, email: $email}';
  }
}

class UserState extends ChangeNotifier {
  User? user;
  bool isLoadingUser = false;

  Future<void> isLogged(BuildContext context) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userSaved = prefs.getString(userPreference);
    if (userSaved != null) {
      user = User.fromJson(json.decode(userSaved));
      Navigator.pushReplacementNamed(context, "/user_detail");
    } else {
      Navigator.pushReplacementNamed(context, "/login");
    }
    notifyListeners();
  }

  Future<void> checkUser(
      BuildContext context, String pass, String userName) async {
    isLoadingUser = true;
    Future.delayed(const Duration(milliseconds: 2000)).then((value) async {
      final parameters = {
        'user': userName,
        'pass': pass,
      };
      final headers = {
        // 'Authorization': 'Bearer <token>',
        'Content-Type': 'application/json'
      };
      try {
        final uri = Uri.https('ejemplo.com/', 'user', parameters);
        final response = await http
            .get(uri, headers: headers)
            .timeout(const Duration(seconds: 2));

        if (response.statusCode == 200) {
          /// user correct
          /// {'name': 'Pepe', 'user': 'PepeUser', 'email': 'pepe@mail.com'}
          ///  user = User.fromJson(json.decode(response.body));
        } else {
          // user fail
        }
      } catch (_) {}

      user = User.fromJson({
        'name': 'Pepe Apellido1 Apellido2',
        'user': userName,
        'email': 'pepe@email.com'
      });
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString(userPreference, jsonEncode(user!.toJson())).then(
          (value) => {Navigator.pushReplacementNamed(context, '/user_detail')});

      isLoadingUser = false;
    });
    notifyListeners();
  }

  Future<void> logOut(BuildContext context) async {
    user = null;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs
        .remove(userPreference)
        .then((value) => Navigator.pushReplacementNamed(context, "/login"));
    notifyListeners();
  }
}
