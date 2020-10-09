// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
    User({
        this.online,
        this.username,
        this.email,
        this.status,
        this.uid,
        this.host,
    });

    bool online;
    String username;
    String email;
    String status;
    String uid;
    String host;

    factory User.fromJson(Map<String, dynamic> json) => User(
        online: json["online"],
        username: json["username"],
        email: json["email"],
        status: json["status"],
        uid: json["uid"],
        host: json["host"]
    );

    Map<String, dynamic> toJson() => {
        "online": online,
        "username": username,
        "email": email,
        "status": status,
        "uid": uid,
        "host": host,
    };
}
