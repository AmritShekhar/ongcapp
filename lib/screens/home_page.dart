import 'package:flutter/material.dart';
import 'package:ongc_app/model/userModel/user_model.dart';
import 'package:ongc_app/screens/authentication/login.dart';
import 'package:ongc_app/screens/authentication/register.dart';
import 'package:ongc_app/screens/home/home.dart';

class HomePage extends StatefulWidget {
  //!c: const HomePage({ Key? key }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool visible = true, login = false, register = false;

  isconnected() async {
    UserModel.getUser();
    if (UserModel.sessionUser == null) {
      setState(() {
        login = false;
      });
    } else {
      setState(() {
        login = true;
      });
    }
  }

  toggle() {
    setState(() {
      visible = !visible;
    });
  }

  isregister() {
    setState(() {
      register = !register;
    });
  }

  islogin() {
    setState(() {
      login = !login;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isconnected();
  }

  @override
  Widget build(BuildContext context) {
    return login
        ? Home(login: islogin)
        : visible
            ? Login(toggle, islogin)
            : Register(toggle, isregister);
  }
}
