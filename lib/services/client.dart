import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';

import 'package:http/http.dart' as http;
import 'package:malory/utils.dart';

class Client {
  static const String _baseUrl = "127.0.0.1:5000";
  static String _useranme = "";
  static String _password = "";

  String get username => _useranme;

  //TODO make better
  static handleExceptions(BuildContext context,  Function f) async {
    try {
      await f();
    } on OSError catch (_) {
      showSnackBar(context, "Could not connect to server");
    } on SocketException catch (_) {
      showSnackBar(context, "Could not connect to server");
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  static Future<String> apiVersion() async {
    Response response = await http.get(Uri.http(_baseUrl, "/api/version"));
    if (response.statusCode != 200) {
      throw HttpException(response.body);
    }
    return response.body;
  }

  static Future<bool> registerUser(String username, String password) async {
    Response response = await http.post(
      Uri.http(_baseUrl, "/action/register"),
      body: {
        "username": username,
        "password": password,
      },
    );
    if (response.statusCode != 200) {
      throw HttpException(response.body);
    }
    bool isOk = jsonDecode(response.body);
    if (isOk) {
      _useranme = username;
      _password = password;
    }
    return isOk;
  }

  static Future<bool> verifyUser(String username, String password) async {
    Response response = await http.get(
      Uri.http(
        _baseUrl,
        "/api/verify",
        {
          "username": username,
          "password": password,
        },
      ),
    );
    if (response.statusCode != 200) {
      throw HttpException(response.body);
    }
    bool isOk = jsonDecode(response.body);
    if (isOk) {
      _useranme = username;
      _password = password;
    }
    return isOk;
  }
}
