import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ongc_app/crypt/crypt.dart';
import 'package:ongc_app/model/userModel/user_model.dart';
import 'package:ongc_app/widgets/loading.dart';
import 'package:ongc_app/widgets/textfield.dart';
import 'package:http/http.dart' as http;

class Login extends StatefulWidget {
  //!c: const Login({ Key? key }) : super(key: key);

  final VoidCallback visible, login;

  Login(this.visible, this.login);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String err = "";

  bool _loading = false;

  void login(String email, String pass) async {
    setState(() {
      err = "";
      _loading = true;
    });

    final response = await http.post(
      Uri.http(
        "172.20.10.3",
        "dashboard/ONGC/login.php",
      ),
      body: {
        "email": encrypt(email),
        "pass": encrypt(pass),
      },
    );
    if (response.statusCode == 200) {
      var data = jsonDecode(decrypt(response.body));
      // print(data);
      var result = data["data"];
      print(result);
      int success = result[1];
      print(success);
      if (success == 1) {
        setState(() {
          err = result[0];
          UserModel.saveUser(UserModel.fromJson(result[2]));
          _loading = false;
          widget.login.call();
        });
      } else {
        setState(() {
          err = result[0];
          _loading = false;
        });
      }
    }
  }

  CustomTextField emailText = CustomTextField(
    title: "Email",
    placeholder: "Email",
  );

  CustomTextField passText = CustomTextField(
    title: "Password",
    placeholder: "********",
    ispass: true,
  );

  final _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    emailText.err = "This field is mandatory.";
    passText.err = "This field is mandatory.";
    return _loading
        ? Loading()
        : Scaffold(
            body: Center(
              child: SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.all(20),
                  child: Form(
                    key: _key,
                    child: Column(
                      children: [
                        const Text(
                          "Login",
                          style: TextStyle(
                            fontSize: 20.0,
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * .03,
                        ),
                        emailText.textFormField(),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * .03,
                        ),
                        passText.textFormField(),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * .03,
                        ),
                        GestureDetector(
                          onTap: () {
                            if (_key.currentState!.validate()) {
                              login(emailText.value, passText.value);
                            }
                          },
                          child: Container(
                            height: MediaQuery.of(context).size.width * .13,
                            alignment: Alignment.center,
                            color: Colors.indigoAccent,
                            child: const Text(
                              'LOGIN',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * .03,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Not registered yet?\t\t',
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            GestureDetector(
                              onTap: widget.visible,
                              child: const Text(
                                'Register Here!',
                                style: TextStyle(
                                  color: Colors.indigoAccent,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * .03,
                        ),
                        Text(
                          err,
                          style: const TextStyle(
                            color: Colors.red,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
  }
}
