// To parse this JSON data, do
//
//     final getAllUsersResponse = getAllUsersResponseFromJson(jsonString);

import 'dart:convert';
import 'package:messenger/models/user.dart';

GetAllUsersResponse getAllUsersResponseFromJson(String str) => GetAllUsersResponse.fromJson(json.decode(str));

String getAllUsersResponseToJson(GetAllUsersResponse data) => json.encode(data.toJson());

class GetAllUsersResponse {
    GetAllUsersResponse({
        this.ok,
        this.users,
    });

    bool ok;
    List<User> users;

    factory GetAllUsersResponse.fromJson(Map<String, dynamic> json) => GetAllUsersResponse(
        ok: json["ok"],
        users: List<User>.from(json["users"].map((x) => User.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "ok": ok,
        "users": List<dynamic>.from(users.map((x) => x.toJson())),
    };
}
