// To parse this JSON data, do
//
//     final createAccountModel = createAccountModelFromJson(jsonString);

import 'dart:convert';

CreateAccountModel createAccountModelFromJson(String str) => CreateAccountModel.fromJson(json.decode(str));

String createAccountModelToJson(CreateAccountModel data) => json.encode(data.toJson());

class CreateAccountModel {
    int? id;
    String? userType;
    String? name;
    String? email;
    String? password;

    CreateAccountModel({
        this.id,
        this.userType,
        this.name,
        this.email,
        this.password,
    });

    factory CreateAccountModel.fromJson(Map<String, dynamic> json) => CreateAccountModel(
        id: json["id"],
        userType: json["userType"],
        name: json["name"],
        email: json["email"],
        password: json["password"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "userType": userType,
        "name": name,
        "email": email,
        "password": password,
    };
}
