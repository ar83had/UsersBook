import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class API{

  static Future<void> signup({required Map<String,String> data}) async{

    final URL = Uri.parse("https://lockit-server.vercel.app/user/signup/store");
    Map<String, Map<String,String>> body = {"form":data};

    final res = await http.post(
      URL,
      body: jsonEncode(body),
      headers: {
      "Content-Type": "application/json",
      },
    );

    print(res.body);

  }

  static Future<void> signin({required String username, required String pws}) async{

    final URL = Uri.parse("https://lockit-server.vercel.app/user/signin/authenticate");

    final res = await http.get(
      URL,
      headers: {
        "username":username,
        "pws":pws,
      }
    );

    print(res.body);
  }
}