import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
//////// import of config files ////////
import '../helpers/encryption.dart';
import '../helpers/storage_helper.dart';
import '../models/user.dart';
import '../models/httpRequest.dart';

class LoginProvider with ChangeNotifier {
  bool _loggedIn = false;
  User? _userData;

  bool get loggedIn {
    return _loggedIn;
  }

  User? get user {
    return _userData;
  }

  Future<bool> login({
    String? emailOrPhone,
    String? password,
  }) async {
    return _authenticate(
      emailOrPhone: emailOrPhone,
      password: password,
    );
  }

  Future<bool>? autoLogin() async {
    bool res = false;
    var result;
    String? _savedData = null;
    await StorageHelper.loadData(key: 'anyvas_user').then((String result) {
      _savedData = result;
    });
    if (_savedData != null &&
        !_savedData!.contains("no data found in storage.")) {
      _userData = User.decode(_savedData!);
      print('IN autoLogin method ');
      res = true;
    }
    if (res) {
      try {
        result = _authenticate(
          emailOrPhone: _userData!.email!.length <= 0
              ? _userData!.phone
              : _userData!.email, //// if email is null, then use phone,
          password: EncryDecry.methods().toDecrypt(_userData!.getCredential),
        );
        return result;
      } on Exception catch (error) {
        print(error.toString());
        throw error;
      }
    }
    return false;
  }

  Future<bool> _authenticate({String? emailOrPhone, String? password}) async {
    // print("IN LOGIN -- $emailOrPhone $password ");
    try {
      var request =
          http.Request('POST', Uri.parse('http://incap.bssoln.com/api/login'));
      request.body =
          json.encode({"username": emailOrPhone, "password": password});
      request.headers.addAll(HttpRequest.headers);
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        var responseData = await response.stream.bytesToString();
        _userData = await createUserObject(
          responseData,
          EncryDecry.methods().toEncrypt(password!),
        );

        String toBeSaved;
        toBeSaved = User.encode(_userData);
        try {
          await StorageHelper.saveData(key: "anyvas_user", data: toBeSaved);
        } on Exception catch (error) {
          print(error);
          throw error;
        }

        // print(
        //   "${_userData!.firstName} \n${_userData!.lastName} \n${_userData!.username}" +
        //       "\n${_userData!.email} ${_userData!.phone} ${_userData!.getCredential}" +
        //       "\n${_userData!.token.toString()}",
        // );
        _loggedIn = true;
        notifyListeners();
        // print('LOGGED IN ');
        return true;
        // log(responseData);
      } else {
        print("IN LOGIN -- ${response.statusCode} - ${response.reasonPhrase} ");
        var responseData = await response.stream.bytesToString();
        List<String> errorList =
            await HttpRequest.createHttpErrorList(responseData);
        errorList.forEach((errorMessage) {
          log(errorMessage);
          HttpRequest.loginErrorList.forEach((error) {
            if (errorMessage.contains(error)) {
              throw HttpRequest(error);
            }
          });
          if (response.statusCode == 400) {
            throw HttpRequest(response.reasonPhrase.toString());
          }
        });
      }
    } catch (error) {
      print(error);
      throw error;
    }
    return false;
  }

  Future<bool> logout() async {
    try {
      var request =
          http.Request('GET', Uri.parse('http://incap.bssoln.com/api/logout'));
      request.body = '''''';
      request.headers.addAll(HttpRequest.headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        print(await response.stream.bytesToString());
        print("after logging out");
        var userDataDeleted =
            await StorageHelper.removeData(key: 'anyvas_user');
        if (userDataDeleted) {
          _loggedIn = false;
          _userData = null;
          notifyListeners();
          return userDataDeleted;
        }
      } else {
        print(response.reasonPhrase);
        print("after logging error ");
      }
      print(" logging out failed");
      notifyListeners();
    } on Exception catch (error) {
      throw error;
    }
    return false;
  }

  Future<User> createUserObject(String responseData, String data) async {
    final extractedData = json.decode(responseData) as Map<String, dynamic>;
    final userData = User(
      email: extractedData['Data']['Info']['Email'],
      phone: extractedData['Data']['Info']['Phone'],
      username: extractedData['Data']['Info']['Username'],
      firstName: extractedData['Data']['Info']['FirstName'],
      lastName: extractedData['Data']['Info']['LastName'],
      token: extractedData['Data']['Token'],
      cred: data,
    );
    // print("${userData.email}, ${userData.phone} ${userData.username} ");
    return userData;
  }
}
