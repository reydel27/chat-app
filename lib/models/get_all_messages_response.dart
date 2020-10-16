// To parse this JSON data, do
//
//     final getAllMessagesResponse = getAllMessagesResponseFromJson(jsonString);

import 'dart:convert';

GetAllMessagesResponse getAllMessagesResponseFromJson(String str) => GetAllMessagesResponse.fromJson(json.decode(str));

String getAllMessagesResponseToJson(GetAllMessagesResponse data) => json.encode(data.toJson());

class GetAllMessagesResponse {
    GetAllMessagesResponse({
        this.ok,
        this.messages,
    });

    bool ok;
    List<Message> messages;

    factory GetAllMessagesResponse.fromJson(Map<String, dynamic> json) => GetAllMessagesResponse(
        ok: json["ok"],
        messages: List<Message>.from(json["messages"].map((x) => Message.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "ok": ok,
        "messages": List<dynamic>.from(messages.map((x) => x.toJson())),
    };
}

class Message {
    Message({
        this.from,
        this.to,
        this.message,
        this.createdAt,
        this.updatedAt,
    });

    String from;
    String to;
    String message;
    DateTime createdAt;
    DateTime updatedAt;

    factory Message.fromJson(Map<String, dynamic> json) => Message(
        from: json["from"],
        to: json["to"],
        message: json["message"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
    );

    Map<String, dynamic> toJson() => {
        "from": from,
        "to": to,
        "message": message,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
    };
}
