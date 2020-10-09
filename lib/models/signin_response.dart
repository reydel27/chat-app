// To parse this JSON data, do
//
//     final signinResponse = signinResponseFromJson(jsonString);

import 'dart:convert';

import 'package:messenger/models/user.dart';

SigninResponse signinResponseFromJson(String str) => SigninResponse.fromJson(json.decode(str));

String signinResponseToJson(SigninResponse data) => json.encode(data.toJson());

class SigninResponse {
    SigninResponse({
        this.ok,
        this.user,
        this.message,
        this.token,
    });

    bool ok;
    User user;
    String message;
    String token;

    factory SigninResponse.fromJson(Map<String, dynamic> json) => SigninResponse(
        ok: json["ok"],
        user: User.fromJson(json["user"]),
        message: json["message"],
        token: json["token"],
    );

    Map<String, dynamic> toJson() => {
        "ok": ok,
        "user": user.toJson(),
        "message": message,
        "token": token,
    };
}