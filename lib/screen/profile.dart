import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../theme.dart';
import 'Auth/login.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final uid1 = new FlutterSecureStorage();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        centerTitle: true,

      ),
      body: Center(
        child:   InkWell(
          onTap: () async {
            FirebaseAuth.instance.signOut();
            await uid1.delete(key: 'uid');
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const Login()));
          },
          child: Padding(
            padding: const EdgeInsets.all(50.0),
            child: Container(

              height: 50,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Mytheme().primary,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                child: Text('Log Out',

                  style: TextStyle(fontSize: 20,color: Colors.white,letterSpacing: 3.0),
                ),
              ),

            ),
          ),
        ),
      ),
    );
  }
}
