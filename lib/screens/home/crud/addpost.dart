import 'package:flutter/material.dart';
import 'package:ongc_app/api/api.dart';
import 'package:ongc_app/model/post_model.dart';
import 'package:ongc_app/model/userModel/user_model.dart';
import 'package:ongc_app/widgets/textfield.dart';

class AddPost extends StatefulWidget {
  //!c: const AddPost({Key? key}) : super(key: key);

  @override
  _AddPostState createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  // add() async {
  //   await Api.addPost({});
  // }

  @override
  void initState() {
    super.initState();
  }

  CustomTextField head = CustomTextField(
    placeholder: "Enter title of the post",
    title: "Title",
  );

  CustomTextField basin = CustomTextField(
    title: "Basin",
    placeholder: "Basin",
  );

  CustomTextField description = CustomTextField(
    placeholder: "Enter description",
    title: "Description",
    line: 5,
  );

  final _key = GlobalKey<FormState>();

  List<String> basins = [
    'Krishna-Godavari',
    'Mumbai Offshore',
    'Assam Shelf',
    'Kaveri',
    'Western Offshore',
    'Assam-Arakan Fold Belt',
    'Mahanadi-Bengal-Andaman',
    'Western Onshore',
  ];

  var currentBasinSelected = 'Krishna-Godavari';

  PostModel myPost = PostModel();

  bool post = false;

  @override
  Widget build(BuildContext context) {
    head.err = "This field is mandatory.";
    description.err = "This field is mandatory";
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _key,
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * .1,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      "Post Details",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .03,
                ),
                head.textFormField(),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .03,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    border: Border.all(
                      color: Colors.grey,
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      borderRadius: BorderRadius.circular(8),
                      items: basins.map((String val) {
                        return DropdownMenuItem<String>(
                          value: val,
                          child: Text(val),
                        );
                      }).toList(),
                      onChanged: (String? newSelectedBasin) {
                        setState(() {
                          currentBasinSelected = newSelectedBasin!;
                        });
                      },
                      value: currentBasinSelected,
                      hint: const Text('Select Basin'),
                      iconSize: 35,
                      isExpanded: true,
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.indigoAccent,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .03,
                ),
                description.textFormField(),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .03,
                ),
                GestureDetector(
                  onTap: post
                      ? null
                      : () async {
                          if (_key.currentState!.validate()) {
                            setState(() {
                              post = true;
                            });
                            myPost.title = head.value;
                            myPost.basin = currentBasinSelected;
                            myPost.description = description.value;
                            myPost.user = UserModel.sessionUser.id;
                            var result = await Api.addPost(myPost.toMap());
                            if (result != null && result[0]) {
                              setState(() {
                                post = false;
                              });
                              Navigator.of(context).pop();
                            } else if (result != null && !result[0]) {
                              setState(() {
                                post = false;
                              });
                            } else {
                              setState(() {
                                post = false;
                              });
                            }
                          }
                          print(UserModel.sessionUser.id);
                        },
                  child: Container(
                    height: MediaQuery.of(context).size.width * .13,
                    alignment: Alignment.center,
                    color: Colors.indigoAccent,
                    child: const Text(
                      'ADD POST',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
