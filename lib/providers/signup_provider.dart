import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
//////// import of config files ////////
import '../models/httpRequest.dart';

class SignupProvider with ChangeNotifier {
  bool _registered = false;

  bool get registered {
    return _registered;
  }

  Future<bool> signUp({
    String? firstName,
    String? lastName,
    String? email,
    String? phone,
    String? password,
    String? confirmPassword,
  }) async {
    return _authenticate(
      firstName: firstName,
      lastName: lastName,
      email: email,
      phone: phone,
      password: password,
      confirmPassword: confirmPassword,
    );
  }

  Future<bool> _authenticate({
    String? firstName,
    String? lastName,
    String? email,
    String? phone,
    String? password,
    String? confirmPassword,
  }) async {
    try {
      var request = http.Request(
          'POST', Uri.parse('${HttpRequest.serverUrl}/register'));
      request.body = json.encode({
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "phone": phone,
        "password": password,
        "confirmPassword": confirmPassword,
      });
      request.headers.addAll(HttpRequest.headers);
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        var responseData = await response.stream.bytesToString();
        log(responseData);
        if (responseData.contains(HttpRequest.signupSuccessMessage)) {
          _registered = true;
          return _registered;
        }
      } else {
        print(" ${response.statusCode} - ${response.reasonPhrase} ");
        var responseData = await response.stream.bytesToString();

        List<String> errorList = await HttpRequest.createHttpErrorList(responseData);
        errorList.forEach((errorMessage) {
          log(errorMessage);
          HttpRequest.signupErrorList.forEach((error) {
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
}
