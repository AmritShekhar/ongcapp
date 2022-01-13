import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ongc_app/model/userModel/user_model.dart';
import 'package:ongc_app/screens/home/crud/addpost.dart';

class DrawerPage extends StatefulWidget {
  final VoidCallback login;

  DrawerPage({required this.login});

  //!c: const DrawerPage({ Key? key }) : super(key: key);

  @override
  _DrawerPageState createState() => _DrawerPageState();
}

class _DrawerPageState extends State<DrawerPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(40),
      color: Colors.deepPurple.shade300,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const CircleAvatar(),
              SizedBox(
                width: MediaQuery.of(context).size.width * .04,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    UserModel.sessionUser.name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .006,
                  ),
                  const Text(
                    "Active status",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Column(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddPost(),
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(30),
                  child: Row(
                    children: [
                      const Icon(
                        FontAwesomeIcons.plus,
                        color: Colors.white,
                        size: 30,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * .04,
                      ),
                      const Text(
                        "Upload",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(30),
                child: Row(
                  children: [
                    const Icon(
                      Icons.favorite,
                      color: Colors.white,
                      size: 30,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * .04,
                    ),
                    const Text(
                      "Favorites",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(30),
                child: Row(
                  children: [
                    const Icon(
                      Icons.mail,
                      color: Colors.white,
                      size: 30,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * .04,
                    ),
                    const Text(
                      "Messages",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(30),
                child: Row(
                  children: [
                    const Icon(
                      FontAwesomeIcons.solidUser,
                      color: Colors.white,
                      size: 30,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * .04,
                    ),
                    const Text(
                      "Profile",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Row(
            children: [
              const Icon(
                Icons.settings,
                size: 24,
                color: Colors.white,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * .04,
              ),
              const Text(
                'Settings',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * .02,
              ),
              Container(
                color: Colors.white,
                height: MediaQuery.of(context).size.height * .03,
                width: MediaQuery.of(context).size.width * .006,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * .02,
              ),
              GestureDetector(
                onTap: () {
                  widget.login.call();
                  UserModel.logOut();
                },
                child: const Text(
                  'Log out',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
