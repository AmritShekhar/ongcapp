import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class UserModel {
  String id;
  String name;
  String email;

  UserModel({
    this.id = "",
    this.name = "",
    this.email = "",
  });

  static UserModel sessionUser = UserModel(id: "", name: "", email: "");

  factory UserModel.fromJson(Map<String, dynamic> i) => UserModel(
        id: i['id'],
        name: i['name'],
        email: i['email'],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "email": email,
      };

  static Future<void> saveUser(UserModel user) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var data = json.encode(user.toMap());
    pref.setString("user", data);
    // pref.commit();
  }

  static Future<void> getUser() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var data = pref.getString("user");
    print(data);
    if (data != null) {
      var decode = jsonDecode(data);
      var user = UserModel.fromJson(decode);
      sessionUser = user;
      print(sessionUser);
      print(sessionUser.email);
    } else {
      sessionUser = UserModel(id: "", name: "", email: "");
    }
  }

  static void logOut() async {
    SharedPreferences p = await SharedPreferences.getInstance();
    p.setString("user", "");
    sessionUser = UserModel(id: "", name: "", email: "");
    // p.commit();
  }
}
