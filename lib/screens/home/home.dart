import 'package:flutter/material.dart';
import 'package:ongc_app/model/userModel/user_model.dart';
import 'package:ongc_app/screens/home/drawer_page.dart';
import 'package:ongc_app/screens/home/ui_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  final VoidCallback login;

  Home({required this.login});

  //!c: const Home({ Key? key }) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var user = UserModel.fromJson({
    "id": "1",
    "name": "Token Black",
    "email": "token@black.com",
  });

  save() async {
    SharedPreferences p = await SharedPreferences.getInstance();
    p.setString("user", "Token Black");
    // p.commit();
  }

  getTest() async {
    String? t = "";
    var p = await SharedPreferences.getInstance();
    t = p.getString("user");
    print(t);
    return t;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          DrawerPage(
            login: widget.login,
          ),
          UIPage(),
        ],
      ),
    );
  }
}
