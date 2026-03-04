
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class API{

  static Future<dynamic> signup({required Map<String,String> body}) async{

    final URL = Uri.parse("https://caperbit.com/workshop/public/api/v1/auth/register");

    final res = await http.post(
      URL,
      body: jsonEncode(body),
      headers: {
      "Content-Type": "application/json",
      },
    ); 

    debugPrint(res.body);

    return jsonDecode(res.body);
  }

  static Future<dynamic> signin({required Map<String,String> body}) async{

    final URL = Uri.parse("https://caperbit.com/workshop/public/api/v1/auth/login");

    final res = await http.post(
      URL,
      body: jsonEncode(body),
      headers: {
        "Content-Type":"application/json",
      }
    );

    debugPrint(res.body);

    return jsonDecode(res.body);
  }
}