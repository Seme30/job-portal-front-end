import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:job_finder/models/User.dart';
import 'package:job_finder/services/AppUrl.dart';
import 'package:job_finder/services/SharedPreferences.dart';
import 'package:http/http.dart' as http;

enum Status {
  NotLoggedIn,
  NotRegistered,
  LoggedIn,
  Registered,
  Authenticating,
  Registering,
  LoggedOut
}

class AuthProvider with ChangeNotifier {
  Status _loggedInStatus = Status.NotLoggedIn;
  Status _registeredInStatus = Status.NotRegistered;

  Status get loggedInStatus => _loggedInStatus;
  set loggedInStatus(Status value) {
    _loggedInStatus = value;
  }

  Status get registeredInStatus => _loggedInStatus;
  set registeredInStatus(Status value) {
    _loggedInStatus = value;
  }

  Future<Map<dynamic, dynamic>> register(
      String username, String password, String role) async {
    final Map<dynamic, dynamic> userProfile = {
      'username': username,
      'password': password,
      'role': role
    };

    _registeredInStatus = Status.Registering;

    return await http
        .post(Uri.parse(AppUrl.signup),
            body: json.encode(userProfile),
            headers: {'Content-Type': 'application/json'})
        .then(onValue)
        .catchError(onError);
  }

  notify() {
    notifyListeners();
  }

  static dynamic onValue(http.Response response) async {
    Map<dynamic, dynamic> result;

    final Map<dynamic, dynamic> responseData = json.decode(response.body);

    print(responseData);

    if (response.statusCode == 201) {
      // now we will create a user model
      User authUser = User.fromJson(responseData);

      // now we will create shared preferences and save data
      UserPreferences().saveUser(authUser);

      result = {
        'status': true,
        'message': 'Successfully registered',
        'data': authUser
      };
    } else {
      result = {
        'status': false,
        'message': 'Successfully registered',
        'data': responseData
      };
    }
    return result;
  }

  Future<Map<dynamic, dynamic>> login(String username, String password) async {
    Map<dynamic, dynamic> result;

    final Map<dynamic, dynamic> loginData = {
      'username': username,
      'role': 'ADMIN',
      'password': password,
    };

    _loggedInStatus = Status.Authenticating;
    notifyListeners();

    http.Response response = await http.post(
        Uri.parse(AppUrl.login + "/" + username),
        body: json.encode(loginData),
        headers: {'Content-Type': 'application/json'});
    print(response);
    print("from login");
    if (response.statusCode == 200) {
      final Map<dynamic, dynamic> responseData = json.decode(response.body);

      print(responseData);
      print('from Auth Provider');

      User authUser = User.fromJson(responseData);

      UserPreferences().saveUser(authUser);

      _loggedInStatus = Status.LoggedIn;
      notifyListeners();

      result = {'status': true, 'message': 'Successful', 'user': authUser};
    } else {
      _loggedInStatus = Status.NotLoggedIn;
      notifyListeners();
      result = {
        'status': false,
        'message': json.decode(response.body)['error']
      };
    }

    return result;
  }

  static onError(error) {
    print('the error is ${error.detail}');
    return {'status': false, 'message': 'Unsuccessful Request', 'data': error};
  }
}
