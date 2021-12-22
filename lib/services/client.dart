import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';

import 'package:http/http.dart' as http;
import 'package:malory/classes/attribute.dart';
import 'package:malory/classes/room.dart';
import 'package:malory/classes/unit.dart';
import 'package:malory/utils.dart';

class Client {
  static const String _baseUrl = "127.0.0.1:5000";
  static const ttl = Duration(milliseconds: 333);

  static String _useranme = "";
  static String _password = "";
  static String _room = "";

  static String get username => _useranme;
  static String get room => _room;

  //TODO make better
  static handleExceptions(BuildContext context, Function f) async {
    try {
      await f();
    } on OSError catch (_) {
      showSnackBar(context, "Could not connect to server");
    } on SocketException catch (_) {
      showSnackBar(context, "Could not connect to server");
    } on HttpException catch (e) {
      showSnackBar(context, e.toString().replaceAll("HttpException: ", ""));
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  static Future<List<Attribute>> getAllAttributes() async {
    Response response = await http.get(
      Uri.http(
        _baseUrl,
        "/api/attributes",
      ),
    );
    if (response.statusCode != 200) {
      throw HttpException(response.body);
    }
    List<dynamic> jsonList = jsonDecode(response.body);
    return jsonList.map((e) => Attribute.fromJson(e)).toList();
  }

  static Future<Attribute> getAttribute(String name) async {
    Response response = await http.get(
      Uri.http(
        _baseUrl,
        "/api/attribute/$name",
      ),
    );
    if (response.statusCode != 200) {
      throw HttpException(response.body);
    }
    return Attribute.fromJson(jsonDecode(response.body));
  }

  static Future<List<Unit>> hasAttributeFull(String name) async {
    Response response = await http.get(
      Uri.http(
        _baseUrl,
        "/api/has_attribute/$name",
        {
          "full": "true",
        },
      ),
    );
    if (response.statusCode != 200) {
      throw HttpException(response.body);
    }
    List<dynamic> jsonList = jsonDecode(response.body);
    return jsonList.map((e) => Unit.fromJson(e)).toList();
  }

  static Future<List<String>> hasAttribute(String name) async {
    Response response = await http.get(
      Uri.http(
        _baseUrl,
        "/api/has_attribute/$name",
        {
          "full": "false",
        },
      ),
    );
    if (response.statusCode != 200) {
      throw HttpException(response.body);
    }
    List<dynamic> jsonList = jsonDecode(response.body);
    return jsonList.map((e) => e.toString()).toList();
  }

  static Future<List<Unit>> getAllUnits() async {
    Response response = await http.get(
      Uri.http(
        _baseUrl,
        "/api/units",
      ),
    );
    if (response.statusCode != 200) {
      throw HttpException(response.body);
    }
    List<dynamic> jsonList = jsonDecode(response.body);
    return jsonList.map((e) => Unit.fromJson(e)).toList();
  }

  static Future<Unit> getUnit(String name) async {
    Response response = await http.get(
      Uri.http(
        _baseUrl,
        "/api/unit/$name",
      ),
    );
    if (response.statusCode != 200) {
      throw HttpException(response.body);
    }
    return Unit.fromJson(jsonDecode(response.body));
  }

  static Future<List<String>> getCategories([bool playable = true]) async {
    Response response = await http.get(
      Uri.http(
        _baseUrl,
        "/api/categories",
        {
          "playable": playable.toString(),
        },
      ),
    );
    if (response.statusCode != 200) {
      throw HttpException(response.body);
    }
    List<dynamic> jsonList = jsonDecode(response.body);
    return jsonList.map((e) => e.toString()).toList();
  }

  static Future<List<String>> getNations() async {
    Response response = await http.get(
      Uri.http(
        _baseUrl,
        "/api/nations",
      ),
    );
    if (response.statusCode != 200) {
      throw HttpException(response.body);
    }
    List<dynamic> jsonList = jsonDecode(response.body);
    return jsonList.map((e) => e.toString()).toList();
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

  static Future<List<Room>> availableRooms() async {
    Response response =
        await http.get(Uri.http(_baseUrl, "/api/available_rooms"));
    if (response.statusCode != 200) {
      throw HttpException(response.body);
    }
    List<dynamic> jsonList = jsonDecode(response.body);
    return jsonList.map((e) => Room.fromJson(e)).toList();
  }

  static Future<void> joinRoom(String name) async {
    Response response = await http.post(
      Uri.http(_baseUrl, "/action/join_room"),
      body: {
        "username": _useranme,
        "password": _password,
        "room_name": name,
      },
    );
    if (response.statusCode != 200) {
      throw HttpException(response.body);
    }
    _room = name;
  }

  static Future<void> createRoom(String name, int points) async {
    Response response = await http.post(
      Uri.http(_baseUrl, "/action/create_room"),
      body: {
        "username": _useranme,
        "password": _password,
        "room_name": name,
        "points": points.toString(),
      },
    );
    if (response.statusCode != 200) {
      throw HttpException(response.body);
    }
    _room = name;
  }

  static Stream<bool> isGameReady() async* {
    bool ans = false;
    while (true) {
      Response response =
          await http.get(Uri.http(_baseUrl, "/api/is_game_ready/$_room"));
      if (response.statusCode != 200) {
        throw HttpException(response.body);
      }
      ans = jsonDecode(response.body);
      if (!ans) {
        yield false;
      } else {
        break;
      }
      await Future.delayed(ttl);
    }
  }

  static Future<void> leaveRoom() async {
    Response response = await http.post(
      Uri.http(_baseUrl, "/action/leave_room"),
      body: {
        "username": _useranme,
        "password": _password,
        "room_name": _room,
      },
    );
    if (response.statusCode != 200) {
      throw HttpException(response.body);
    }
  }

  static Future<String> apiVersion() async {
    Response response = await http.get(Uri.http(_baseUrl, "/api/version"));
    if (response.statusCode != 200) {
      throw HttpException(response.body);
    }
    return response.body;
  }
}
