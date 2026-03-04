
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

    
    if(res.statusCode!=200){
      debugPrint(res.body);
    }

    return jsonDecode(res.body);
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