import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ongc_app/widgets/loading.dart';
import 'package:ongc_app/widgets/textfield.dart';
import 'package:http/http.dart' as http;

class Register extends StatefulWidget {
  //!c: const Register({ Key? key }) : super(key: key);

  final VoidCallback visible, register;

  Register(this.visible, this.register);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  String err = "";

  bool _loading = false;

  void register(String name, String email, String pass) async {
    setState(() {
      err = "";
      _loading = true;
    });

    final response = await http.post(
      Uri.http(
        "172.20.10.3",
        "dashboard/ONGC/register.php",
      ),
      body: {"name": name, "email": email, "pass": pass},
    );
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      print(data);
      var result = data["data"];
      print(result);
      int success = result[1];
      print(success);
      if (success == 1) {
        setState(() {
          err = result[0];
          _loading = false;
          widget.register.call();
        });
      } else {
        setState(() {
          err = result[0];
          _loading = false;
        });
      }
    }
  }

  CustomTextField nameText = CustomTextField(
    title: "Name",
    placeholder: "Name",
  );

  CustomTextField emailText = CustomTextField(
    title: "Email",
    placeholder: "Email",
  );

  CustomTextField passText = CustomTextField(
    title: "Password",
    placeholder: "********",
    ispass: true,
  );

  CustomTextField confirmPassText = CustomTextField(
    title: "Confirm Password",
    placeholder: "********",
    ispass: true,
  );

  final _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    nameText.err = "This field is mandatory.";
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
                          "Register",
                          style: TextStyle(
                            fontSize: 20.0,
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * .03,
                        ),
                        nameText.textFormField(),
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
                        confirmPassText.textFormField(),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * .03,
                        ),
                        GestureDetector(
                          onTap: () {
                            if (_key.currentState!.validate()) {
                              if (passText.value == confirmPassText.value) {
                                register(
                                  nameText.value,
                                  emailText.value,
                                  passText.value,
                                );
                              } else {
                                print("Passwords don't match");
                              }
                              
                            }
                          },
                          child: Container(
                            height: MediaQuery.of(context).size.width * .13,
                            alignment: Alignment.center,
                            color: Colors.indigoAccent,
                            child: const Text(
                              'Register',
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
                              'Already have an account?\t\t',
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            GestureDetector(
                              onTap: widget.visible,
                              child: const Text(
                                'Login Here!',
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
