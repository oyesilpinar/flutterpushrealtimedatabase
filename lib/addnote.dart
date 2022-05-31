import 'dart:math';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'main.dart';

class addnote extends StatefulWidget {
  const addnote({Key? key}) : super(key: key);

  @override
  _addnoteState createState() => _addnoteState();
}

class _addnoteState extends State<addnote> {
  TextEditingController first = TextEditingController();
  TextEditingController second = TextEditingController();
  TextEditingController fourth = TextEditingController();
  TextEditingController third = TextEditingController();

  final fb = FirebaseDatabase.instance;

  @override
  Widget build(BuildContext context) {
    var rng = Random();
    var k = rng.nextInt(10000);
    /*
    String? a;
    getToken() async* {
      String? token = await FirebaseMessaging.instance.getToken();
      final String? tokenid = token;
      yield* tokenid;
    }
*/
    Future<String?> getToken() async {
      String? token = await FirebaseMessaging.instance.getToken();
      return Future.value(token);
    }

    final ref = fb.ref().child('todos/$k');
    return Scaffold(
      appBar: AppBar(
        title: Text("Bildirim App"),
        backgroundColor: Colors.indigo[900],
      ),
      body: Container(
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Container(
              decoration: BoxDecoration(border: Border.all()),
              child: TextField(
                controller: second,
                decoration: InputDecoration(
                  hintText: 'Etiket',
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              decoration: BoxDecoration(border: Border.all()),
              child: TextField(
                controller: third,
                decoration: InputDecoration(
                  hintText: 'Mesaj',
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              decoration: BoxDecoration(border: Border.all()),
              child: TextField(
                controller: first,
                decoration: InputDecoration(hintText: 'İsim'),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            MaterialButton(
              color: Colors.indigo[900],
              onPressed: () async {
                Future<String?> stringToken = getToken();
                String? token = await stringToken;
                print(token);
                ref.set({
                  "Etiket:": second.text,
                  "İsim:": first.text,
                  "Mesaj:": third.text,
                  "Token:": token,
                }).asStream();
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (_) => Home()));
              },
              child: Text(
                "Kaydet",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
