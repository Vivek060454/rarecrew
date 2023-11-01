import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:rarecrew/screen/Auth/login.dart';
import 'package:rarecrew/screen/customer%20list.dart';
import 'package:rarecrew/screen/dashboard.dart';
import 'package:rarecrew/theme.dart';

import 'Repository/repository.dart';
import 'bloc/blocs/customer_bloc.dart';
void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(RepositoryProvider(
      create: (context)=>WebServise(),
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData().copyWith(
        scaffoldBackgroundColor: Colors.white,
        errorColor: Colors.red,
        colorScheme: ThemeData().colorScheme.copyWith(
          primary: Mytheme().primary,
        ),
        primaryColor:  Mytheme().primary,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<MyHomePage> {
  final _auth = FirebaseAuth.instance;
  final uid1 = new FlutterSecureStorage();

  Future<bool> checkLogin() async {
    String? value = await uid1.read(key: "uid");
    if (value == null) {
      return false;
    }
    return true;
  }

  void initState() {
    super.initState();
    Timer(
      const Duration(seconds: 2),
          () => Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => FutureBuilder(
                future: checkLogin(),
                builder:
                    (BuildContext context, AsyncSnapshot<bool> snapshot) {
                  if (snapshot.data == false) {
                    return Login();
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Container(
                      color: Colors.white,
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
                  return BlocProvider(
                      create: (context)=>ProfileBloc(WebServise()),
                      child: Dashboard());
                },
              ))),

    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Mytheme().primary,
      body: Container(

        decoration:  BoxDecoration(
          color: Mytheme().primary,
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text('Rarecrew',textAlign:TextAlign.center,style: TextStyle(fontSize: 30,color: Colors.white,fontWeight: FontWeight.w500),),
          ),
        ),
      ),
    );
  }
}