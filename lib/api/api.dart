import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ongc_app/crypt/crypt.dart';

class Api {
  static addPost(Map data) async {
    final response = await http.post(Uri.parse(Url.addPost),
        body: {"data": encrypt(jsonEncode(data))});

    if (response.statusCode == 200) {
      var result = jsonDecode(decrypt(response.body));
      if (result[0]) {
        return result;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }
}

class Url {
  static String addPost = "http://172.20.10.3/dashboard/ONGC/addpost.php";
}
